import requests
from bs4 import BeautifulSoup
import os
import csv
import re
import time

def create_directories(output_dir='dnd_monsters_full'):
    """결과물을 저장할 디렉토리를 생성합니다."""
    images_dir = os.path.join(output_dir, 'images')
    if not os.path.exists(images_dir):
        os.makedirs(images_dir)
        print(f"'{images_dir}' 디렉토리를 생성했습니다.")
    return output_dir, images_dir

def fetch_html(url):
    """주어진 URL의 HTML 콘텐츠를 가져옵니다."""
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
    }
    try:
        response = requests.get(url, headers=headers, timeout=15)
        response.raise_for_status()
        return response.text
    except requests.exceptions.RequestException as e:
        print(f"'{url}' 페이지를 가져오는 데 실패했습니다: {e}")
        return None

def find_last_page(soup):
    """페이지네이션에서 마지막 페이지 번호를 찾습니다."""
    pagination_links = soup.select('.b-pagination-list a.b-pagination-item')
    last_page = 1
    if not pagination_links:
        return 1 # 페이지네이션이 없으면 1페이지 뿐임
        
    for link in pagination_links:
        try:
            page_num = int(link.get_text(strip=True))
            if page_num > last_page:
                last_page = page_num
        except (ValueError, TypeError):
            continue # 숫자가 아닌 링크(예: 'Next')는 무시
            
    print(f"총 {last_page} 페이지를 발견했습니다.")
    return last_page

def download_image(url, path, name):
    """이미지를 다운로드하여 지정된 경로에 저장합니다."""
    if not url:
        return
    try:
        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}
        img_response = requests.get(url, headers=headers, timeout=10, stream=True)
        img_response.raise_for_status()
        
        with open(path, 'wb') as f:
            for chunk in img_response.iter_content(chunk_size=8192):
                f.write(chunk)
        # print(f"  -> '{name}' 이미지 다운로드 성공: {os.path.basename(path)}")
    except requests.exceptions.RequestException as e:
        print(f"  -> '{name}' 이미지 다운로드 실패: {url}, 오류: {e}")

def parse_monster_page(html_content, images_dir):
    """HTML 콘텐츠를 파싱하여 몬스터 정보를 추출하고 이미지를 다운로드합니다."""
    soup = BeautifulSoup(html_content, 'html.parser')
    monster_blocks = soup.find_all('div', class_='info')
    
    if not monster_blocks:
        return []

    page_data = []
    
    for monster in monster_blocks:
        name, cr, m_type, size, image_url = 'N/A', 'N/A', 'N/A', 'N/A', None

        # 이름 추출
        name_element = monster.select_one('.monster-name .name a')
        if name_element:
            name = name_element.get_text(strip=True)

        # CR 추출
        cr_element = monster.select_one('.monster-challenge span')
        if cr_element:
            cr = cr_element.get_text(strip=True)
            
        # 타입 추출
        type_element = monster.select_one('.monster-type .type')
        if type_element:
            m_type = type_element.get_text(strip=True)
            
        # 크기 추출
        size_element = monster.select_one('.monster-size span')
        if size_element:
            size = size_element.get_text(strip=True)

        # 이미지 URL 추출
        image_style_element = monster.select_one('.monster-icon .image')
        if image_style_element and 'style' in image_style_element.attrs:
            match = re.search(r"url\(['\"]?(.*?)['\"]?\)", image_style_element['style'])
            if match:
                image_url = match.group(1)

        print(f"  - 추출: {name} (CR: {cr}, Type: {m_type}, Size: {size})")
        
        # 이미지 다운로드
        if image_url:
            safe_name = re.sub(r'[\\/*?:"<>|]', "", name)
            safe_cr = cr.replace('/', '-')
            file_extension = os.path.splitext(image_url)[1] or '.jpeg'
            
            image_filename = f"{safe_name}_CR_{safe_cr}{file_extension}"
            image_path = os.path.join(images_dir, image_filename)
            download_image(image_url, image_path, name)
        
        page_data.append([name, cr, m_type, size, image_url if image_url else 'No Image'])
        
    return page_data

def save_to_csv(data, path):
    """추출된 데이터를 CSV 파일로 저장합니다."""
    if not data:
        print("저장할 데이터가 없습니다.")
        return
        
    try:
        with open(path, 'w', newline='', encoding='utf-8-sig') as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(['Name', 'CR', 'Type', 'Size', 'Image URL'])  # 헤더
            writer.writerows(data)
        print(f"\n모든 몬스터 정보({len(data)}개)가 '{path}' 파일에 성공적으로 저장되었습니다.")
    except IOError as e:
        print(f"\nCSV 파일 저장 중 오류가 발생했습니다: {e}")

# --- 메인 실행 로직 ---
if __name__ == "__main__":
    BASE_URL = "https://www.dndbeyond.com/monsters"
    
    # 1. 폴더 생성
    output_dir, images_dir = create_directories()
    
    # 2. 첫 페이지에서 마지막 페이지 번호 찾기
    print("첫 페이지를 분석하여 전체 페이지 수를 확인합니다...")
    first_page_html = fetch_html(BASE_URL)
    
    if first_page_html:
        soup = BeautifulSoup(first_page_html, 'html.parser')
        last_page = find_last_page(soup)
        
        all_monsters_data = []
        
        # 3. 모든 페이지 순회하며 데이터 수집
        for page_num in range(1, last_page + 1):
            print(f"\n--- {page_num} / {last_page} 페이지 처리 중 ---")
            
            # 첫 페이지는 이미 로드했으므로 재사용, 그 외 페이지는 새로 요청
            if page_num == 1:
                html = first_page_html
            else:
                page_url = f"{BASE_URL}?page={page_num}"
                html = fetch_html(page_url)
                # 서버에 부담을 주지 않도록 1초 대기
                time.sleep(1)
            
            if html:
                page_monsters = parse_monster_page(html, images_dir)
                all_monsters_data.extend(page_monsters)

        # 4. 수집된 모든 데이터를 CSV 파일로 저장
        csv_path = os.path.join(output_dir, 'dnd_monsters_list.csv')
        save_to_csv(all_monsters_data, csv_path)

    print("\n모든 작업이 완료되었습니다.")