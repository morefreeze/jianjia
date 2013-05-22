spells = {
    --id, ���֣�                              ����,      ����,   ��ѧ������ ����˵��
    { _'������˹֮����A',id=1,  condition={ lt = {}, eq = {}, gt = {} }, loss={ mp = 300 }, describe={ { need_cast = true, action_on = 1, change = { level = 999 }, change_scale = { hp_max = 0.3 }, delay = 3, round = 999, each_round = false, } }, txt='1������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��' }, -- 1
    { _'������˹֮����B',id=2,  condition={ lt = {}, eq = {}, gt = {} }, loss={ mp = 100 }, describe={ { need_cast = true, action_on = 1, change = { level = 999 }, change_scale = { hp_max = 0.3 }, delay = 3, round = 999, each_round = false, } }, txt='2������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��' }, -- 1
    { _'������˹֮����C',id=3,  condition={ lt = {}, eq = {}, gt = {} }, loss={ mp = 300 }, describe={ { need_cast = true, action_on = 1, change = { level = 999 }, change_scale = { hp_max = 0.3 }, delay = 3, round = 999, each_round = false, } }, txt='3������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��' }, -- 1
    { _'������˹֮����D',id=4,  condition={ lt = {}, eq = {}, gt = {} }, loss={ mp = 300 }, describe={ { need_cast = true, action_on = 1, change = { level = 999 }, change_scale = { hp_max = 0.3 }, delay = 3, round = 999, each_round = false, } }, txt='4������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��' }, -- 1
    { _'������˹֮����E',id=5,  condition={ lt = {}, eq = {}, gt = {} }, loss={ mp = 300 }, describe={ { need_cast = true, action_on = 1, change = { level = 999 }, change_scale = { hp_max = 0.3 }, delay = 3, round = 999, each_round = false, } }, txt='5������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��' }, -- 1
    { _'������˹֮����F',id=6,  condition={ lt = {}, eq = {}, gt = {} }, loss={ mp = 300 }, describe={ { need_cast = true, action_on = 1, change = { level = 999 }, change_scale = { hp_max = 0.3 }, delay = 3, round = 999, each_round = false, } }, txt='6������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��' }, -- 1
    { _'������˹֮����G',id=7,  condition={ lt = {}, eq = {}, gt = {} }, loss={ mp = 300 }, describe={ { need_cast = true, action_on = 1, change = { level = 999 }, change_scale = { hp_max = 0.3 }, delay = 3, round = 999, each_round = false, } }, txt='7������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��' }, -- 1
    { _'������˹֮����H',id=8,  condition={ lt = {}, eq = {}, gt = {} }, loss={ mp = 300 }, describe={ { need_cast = true, action_on = 1, change = { level = 999 }, change_scale = { hp_max = 0.3 }, delay = 3, round = 999, each_round = false, } }, txt='8������˹֮��������\n�����߳ɹ������Է���\n֮���������ְ֮��' }, -- 1
    { _'��Ѫ',id=9,  condition={ lt= {}, eq = {}, gt = {} }, loss={ mp = 100 }, describe={ { need_cast = true, action_on = 1, change = {}, change_scale = { hp = 0.3, atk_min = 1, atk_min = 1 }, delay = 0, round = 999, each_round = false, } }, txt='��Ѫ30%' },
}

Spell = Class()

-- �Ƿ�ﵽ�ͷ�������δ��ɣ�
-- ˵������Խ�ɫ�͹�����зֱ���
function Spell:CanCast(obj, spl)
    local req = spl.condition
    local cost = spl.loss

    -- ����һ����ɫ���ж��������ԡ�Ҫ���Լ���������
    if obj.is_character then
        -- �ж����Ժ�Ҫ��

        -- �ж�����
        for k, v in pairs(cost) do
            if v > obj:GetAttr(k) then
                return false
            end
        end
    else
        -- �����ǽ�ɫ���ж�����Ҫ��ͼ�������
        -- �ж�Ҫ��

        -- �ж�����
        for k, v in pairs(cost) do
            if v > obj:GetAttr(k) then
                return false
            end
        end
    end

    return true
end

--�ͷż���
function Spell:Cast(from, to, spl)
    local result = {}
    --�۳�����
    for k, v in pairs(spl.loss) do
        from:Dec(k, v)
    end
--    local con = spl.describe
    --��������
    for k, v in pairs(spl.describe[1].change) do
        local r = to:GetAttr(k) - v
        to:Inc(k, r)
        result[k] = r
    end
    --��������
    for k, v in pairs(spl.describe[1].change_scale) do
        local r = to:GetAttr(k) * v
        to:Inc(k, r)
        result[k] = r
    end
    return result
end
