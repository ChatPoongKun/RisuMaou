function (triggerId, ...)
    local prompts = {...}
    local concat = {}

    -- 나열된 프롬프트들을 로어북에서 불러와 조합
    for i ,v in ipairs(prompts) do
        table.insert(concat, json.decode(getLoreBooks(triggerId, v)[1].content))
    end

    return concat
end