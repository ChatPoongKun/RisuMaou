[dictionary/d_abl/hidden] function(triggerId)
    local dictCat = "d_abl"
    setChatVar(triggerId, "category", dictCat)
end!!

[dictionary/d_trait/hidden] function(triggerId)
    local dictCat = "d_trait"
    setChatVar(triggerId, "category", dictCat)
end!!



[dictionary/199/돌아가기] function(triggerId)
    setChatVar(triggerId, "category", "items")
    setState(triggerId, "screen", "main")
end!!   