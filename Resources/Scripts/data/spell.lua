
spells = {
    --id, ���֣�          ����,     ����,   ��ѧ������ ����˵��
    {1,'������˹֮����A',   {lt={}, eq={}, gt={}}, {mp=300},   {{need_cast=true,  action_on=1,  change={level=999}, change_scale={hp_max=0.3}, delay=3, round=999, each_round=false,}}, '1������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��'}, -- 1
    {2,'������˹֮����B',   {lt={}, eq={}, gt={}}, {mp=100},   {{need_cast=true,  action_on=1,  change={level=999}, change_scale={hp_max=0.3}, delay=3, round=999, each_round=false,}}, '2������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��'}, -- 1
    {3,'������˹֮����C',   {lt={}, eq={}, gt={}}, {mp=300},   {{need_cast=true,  action_on=1,  change={level=999}, change_scale={hp_max=0.3}, delay=3, round=999, each_round=false,}}, '3������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��'}, -- 1
    {4,'������˹֮����D',   {lt={}, eq={}, gt={}}, {mp=300},   {{need_cast=true,  action_on=1,  change={level=999}, change_scale={hp_max=0.3}, delay=3, round=999, each_round=false,}}, '4������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��'}, -- 1
    {5,'������˹֮����E',   {lt={}, eq={}, gt={}}, {mp=300},   {{need_cast=true,  action_on=1,  change={level=999}, change_scale={hp_max=0.3}, delay=3, round=999, each_round=false,}}, '5������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��'}, -- 1
    {6,'������˹֮����F',   {lt={}, eq={}, gt={}}, {mp=300},   {{need_cast=true,  action_on=1,  change={level=999}, change_scale={hp_max=0.3}, delay=3, round=999, each_round=false,}}, '6������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��'}, -- 1
    {7,'������˹֮����G',   {lt={}, eq={}, gt={}}, {mp=300},   {{need_cast=true,  action_on=1,  change={level=999}, change_scale={hp_max=0.3}, delay=3, round=999, each_round=false,}}, '7������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��'}, -- 1
    {8,'������˹֮����H',   {lt={}, eq={}, gt={}}, {mp=300},   {{need_cast=true,  action_on=1,  change={level=999}, change_scale={hp_max=0.3}, delay=3, round=999, each_round=false,}}, '8������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��'}, -- 1
    {9,'��Ѫ',   {lt={}, eq={}, gt={}}, {mp=100},   {{need_cast=true,  action_on=1,  change={}, change_scale={hp=0.3,atk_min=1,atk_min=1}, delay=3, round=999, each_round=false,}}, '��Ѫ30%'},
}

spell = {}
function spell.can_cast(ch, spl)
    local need = spl[4]
    local ret = false
    for k,v in pairs(need) do
        if v > ch[k] then
            return false
        end
    end
    return true
end

--�ͷż���
function spell.cast(ch, spl, enm)
    --{ 1, '��A', { lt = {}, eq = {}, gt = {} }, { mp = 300 }, { { need_cast = true, action_on = 1, change = { level = 999 }, change_scale = { hp_max = 0.3 }, delay = 3, round = 999, each_round = false, } }, '1������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��' } , -- 1
    local con = spl[5]

end
