
enemy_prefix = {
    -- ����,  ��ս�ȼ�����, ����ٷֱ�, hp�ٷֱ�, mp�ٷֱ�, �˺��ٷֱ�, �����ٷֱ�, ���װٷֱ�, ���԰ٷֱ�, �����б�����
    {'����',             1,       1.2,       1.5,        1,          1,        1.3,        1.3,        1.3,           {}}, -- 1
}

enemy_template = {
    -- ����,  ��ս�ȼ�����,   ����ٷֱ�,   hp�ٷֱ�,  mp�ٷֱ�,   �˺��ٷֱ�,   �����ٷֱ�,  ���װٷֱ�,    ���԰ٷֱ�,    �����б�����
    {'��ͨ',           0,          1,        1,        1,          1,         1,           1,          1,          {}}, -- 1
    {'��Ӣ',           1,       1.25,     1.25,     1.25,       1.15,      1.10,        1.10,       1.10,          {}}, -- 2
    {'Ӣ��',           2,       1.50,     1.35,     1.35,       1.30,      1.20,        1.20,       1.20,          {}}, -- 3
    {'����',           3,       1.75,     1.45,     1.45,       1.45,      1.30,        1.30,       1.30,          {}}, -- 4
    {'����',           3,       4.15,        1,        1,          1,         1,           1,          1,          {}}, -- 5
}

templ_set = {
    newbie = {{0.85, 0.15}, {enemy_template[1], enemy_template[2]}},
}

-- �������ͣ�1��ս��2Զ�̣�3ħ��

enemys = {
    --1����,	  2��ս�ȼ�,   3HP,   4MP,    5��������,6��С�˺�,7����˺�,    8����, 9����,  10����,    11ǰ׺����,  12       ģ�弯��,             13�����б�,   4˵��
    {'���ͼ�',	    1,    10,    0,         1,         2,       4,      12,    10,     8,          {},   templ_set.newbie,         {}, 'һֻ�����͵ļ����������εĵط����֡�����ʱҲ�ڴ�ͥ����֮���ε�'}, -- 1
    {'��·������',	1,    10,    0,         1,         2,       4,      12,    10,     8,          {},   templ_set.newbie,         {}, 'һֻ����ʧ������ȡ������������ðɣ�����Ҳ��������Ű֮'}, -- 2
    {'������Ұ��',    3,    20,    0,         1,         4,       8,      14,    10,     8,          {},   templ_set.newbie,         {}, 'һ�����ݵĹ���ƽʱ�ǻ��������Ѹ���Ѱ��ʳ�С�ı�ҧ���ˣ�˭֪������ʲô����'}, -- 3
    {'����è',		2,    15,    0,         1,         3,       6,      13,    10,     8,          {},   templ_set.newbie,         {}, 'һֻƯ���Ļ���è�������������ݣ���������Ҳ������ֻè��'}, -- 4
    {'�޴��ư��',    2,    5,     0,         2,         3,       6,      10,     4,    12,          {},   templ_set.newbie,         {}, 'һֻ˶���ư�棬����������⣬�ܼ�Ӳ�����ӡ��޴�Ŀ���Ħ�����̶�������'}, -- 5
    {'ħ������',	    1,    10,    225,       3,          2,       4,       6,    10,     8,         {},   templ_set.newbie,         {}, 'һ�Ż���·�Ĺ�������͸����������������ħ�������⣬������ħ�����'}, -- 6
}

-- ���Ｏ��
enemy_set = {
    -- ����������ִ�Ĺ���
    newbie = {1,2,3,4,5,6},
}

Enemy = Class()

-- �ڲ�����������id��ȡ�������ݣ�������ı�����ǵ��˵����ݣ���ԭ�����ء�
--         ��ô����ԭ������ʱ��Ҫ��id�����ݣ���ʱ��ֱ�Ӵ�����
function Enemy:_getitem(id_or_table)
    local _type = type(id_or_table)
    if _type == 'table' then
        return id_or_table
    elseif _type == 'number' then
        return enemys[id_or_table]
    end
end

-- ��ù����һ������
-- �������Ӧ��������ɵ���֮�󱻵��ã���Ϊ��Ӧ��ȥֱ���޸� enemys[x] ��ֵ��
-- ����Ҫ���临�ƺ����ʹ�á�
function Enemy:Dup(enm)
    local enm = self:_getitem(enm)
    local t = table.copy(enm)
    t.fight_attr = {change={}, scale={}}
    return t
end

-- ��ȡ�����ĳ������
-- ˵�������������õ���Ҿ���buff��debuff�Ժ������
function Enemy:GetAttr(enm, key)

    local hashmap = {
        name    = 1,
        level   = 2,
        hp      = 3,
        mp      = 4,
        atkway  = 5,
        armor   = 8,
        resist  = 9,
        defense =10,
    }
    if enm[5] == 1 then
        hashmap.atk_min = 6
        hashmap.atk_max = 7
    elseif enm[5] == 2 then
        hashmap.atk_range_min = 6
        hashmap.atk_range_max = 7
    elseif enm[5] == 3 then
        hashmap.atk_magic_min = 6
        hashmap.atk_magic_max = 7
    end

    local index = hashmap[key]
    if not index then
        return 0
    end
    
    local value = enm[index]

    if not enm.fight_attr then
        -- ��ʱ������ʵ�ǲ�̫�����ģ���Ϊ����Ĳ��� Enemy:Dup ���ƺ�Ķ���
        return value
    end

    if enm.fight_attr.change[key] then
        value = value + enm.fight_attr.change[key]
    end
    
    return value
end

-- ��ȡ����ľ���ֵ
function Enemy:Exp(enm)
    local enm = self:_getitem(enm)
    local level = self:GetAttr(enm, 'level')
    return math.ceil(50*level*(1+level/30)^(1+level/2))
end

-- ���﹥�����
function Enemy:Attack(enm, ch, way)
    -- way 1 ����
    -- way 2 Զ��
    -- way 3 ħ��
    local enm = self:_getitem(enm)
    local way = way or self:GetAttr(enm, 'atkway')
    local amr, atk_min, atk_max
    local def = self:GetAttr(enm, 'defense')

    if way == 1 then
        amr = Character:GetAttr(ch, 'armor')
        atk_min, atk_max = self:GetAttr(enm, 'atk_min'), self:GetAttr(enm, 'atk_max')
    elseif way == 2 then
        amr = Character:GetAttr(ch, 'armor')
        atk_min, atk_max = self:GetAttr(enm, 'atk_range_min'), self:GetAttr(enm, 'atk_range_max')
    elseif way == 3 then
        amr = Character:GetAttr(ch, 'resist')
        atk_min, atk_max = self:GetAttr(enm, 'atk_magic_min'), self:GetAttr(enm, 'atk_magic_max')
    end

    return math.ceil((math.random(atk_min, atk_max) + math.floor(atk_max - atk_min) - amr/5) * (1-def ^ 0.5 / 35))
end
