
skills = {
    -- ���֣�          ����,     ����,   ��ѧ������ ����˵��
    {'������˹֮����',   {lt={}, eq={}, gt={}}, {mp=300},   {{need_cast=true,  action_on=1,  change={level=999}, change_scale={hp_max=-0.7}, delay=3, round=999, each_round=false,}}, '������˹֮�������������߳ɹ������Է���֮���������ְ֮��'}, -- 1
}

skill = {}
function skill.can_cast(ch, skl)
    local need = skl[3]
    local ret = false

    for k,v in pairs(need) do
        if v > ch[k] then
            return false
        end
    end
    return true
end

function skill.cast(ch, skl, enm)
    
end
