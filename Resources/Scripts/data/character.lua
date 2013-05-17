
character = {}
function character.new(name, txt)
    local txt = txt or ''
    return {
		name = name,
        txt = txt,
		exp_max = 1,
		exp = 0,
		level = 1,

		-- Ѫ��
		hp_max = 0,
		mp_max = 0,
		hp = 0,
		mp = 0,

		-- ���ˣ���ս��Զ�̣�����
		atk_min = 0,
		atk_max = 0,
		atk_range_min = 0,
		atk_range_max = 0,
		atk_magic_min = 0,
		atk_magic_max = 0,

		-- �Ŀ������ף�ֱ�Ӽ����˺������������ԡ�������Ӱ���˺����⣩
		armor = 0,
		resist = 0,
		defense = 0,

		-- ��ϵ����ƽ�⣬�����˺��������ͷųɹ�ϵ����������
		balance = 5,
		crit_dmg = 0,
		cast = 0,
		cast_success_rate = 0,
		crit_rate = 0,

		-- ����
		strength = 5,
		agility = 5,
		intelligence = 5,
		spellpower = 5,
		endurance = 5,
		will = 5,

        -- ������װ���б�
        skills = {},
        equip = {},

        -- װ�����Լӳɺ�ս�����Լӳ�
        equip_attr = {change={}, scale={}},
        fight_attr = {change={}, scale={}},
    }
end

Character = Class()

-- װ����Ʒ
-- ˵�����ڲ�������������������
function Character:_Equip(ch, item_id)
    local i = items[item_id]
    for k,v in pairs(i.equip.change) do
        if not ch.equip_attr.change[k] then
            ch.equip_attr.change[k] = 0
        end
        ch.equip_attr.change[k] = ch.equip_attr.change[k] + v
    end
    for k,v in pairs(i.equip.scale) do
        if not ch.equip_attr.scale[k] then
            ch.equip_attr.scale[k] = 0
        end
        ch.equip_attr.scale[k] = ch.scale.change[k] + v
    end
    ch.equip[i.equip.pos] = item_id
end

-- װ��ĳ����Ʒ
-- ˵��:װ����λ 1ͷ����2�·���3���ס�4������5Ь�ӡ�6��Ʒ
--      item_id ��װ��id
function Character:Equip(ch, item_id)
    local i = items[item_id]
    local pos = i.equip.pos

    -- �������¾ɵ�װ��(����еĻ�)
    Character:Unequip(ch, pos)
    -- Ȼ��װ���µ�
    Character:_Equip(ch, item_id)
end

-- ����ĳ��λ��װ��
-- ˵��:װ����λ 1ͷ����2�·���3���ס�4������5Ь�ӡ�6��Ʒ
function Character:Unequip(ch, pos)
    if ch.equip[pos] then
        local i = items[ch.items[pos]]
        for k,v in pairs(i.equip.change) do
            ch.equip_attr.change[k] = ch.equip_attr.change[k] - v
        end
        for k,v in pairs(i.equip.scale) do
            ch.equip_attr.scale[k] = ch.scale.change[k] - v
        end
        ch.equip[pos] = nil
    end
end

-- ��ȡ��ɫ��ĳ������
-- ˵�������������õ���Ҿ���װ����ս��buff�ӳ��Ժ������
function Character:GetAttr(ch, key)
    local value = ch[key]
    if ch.equip_attr.change[key] then
        value = value + ch.equip_attr.change[key]
    end
    if ch.fight_attr.change[key] then
        value = value + ch.fight_attr.change[key]
    end

    local scale = 1
    if ch.equip_attr.scale[key] then
        scale = scale + ch.equip_attr.scale[key]
    end
    if ch.fight_attr.scale[key] then
        scale = scale + ch.fight_attr.scale[key]
    end

    return value * scale
end

-- ��ȡ��ҵ�ĳ������
-- ˵�������������õ���ҵ�ԭʼ����
function Character:GetRawAttr(ch, key)
    return ch[key]
end

-- ����װ������
-- ˵��������װ��ǿ��ֵΪ0�����������
function Character:UpdateEquipAttr(ch)
    ch.equip_attr.change = {}
    ch.equip_attr.scale = {}

    for k,v in pairs(ch.equip) do
        Character:_Equip(ch, v)
    end
end

-- ����ս��ǿ��
-- ˵������ս���л�õ�ǿ������
function Character:ResetFightAttr(ch)
    ch.fight_attr.change = {}
    ch.fight_attr.scale = {}    
end

-- ����ֵ����
function character.hp_inc(p, num)
    p.hp = p.hp + num
    if p.hp > p.hp_max then
        p.hp = p.hp_max
    end
end

-- ����ֵ���٣�����С�� 0������false����������
function character.hp_dec(p, num)
    p.hp = p.hp - num
    local check = p.hp > 0
    if not check then p.hp = 0 end
    return check
end

-- mp����
function character.mp_inc(p, num)
    p.mp = p.mp + num
    if p.mp > p.mp_max then
        p.mp = p.mp_max
    end
end

-- mp���٣�����С�� 0������false
function character.mp_dec(p, num)
    local new_mp = p.mp - num
    local check = (new_mp > 0)
    if check then p.mp = p.mp - num end
    return check
end

-- ��������
function character.exp_inc(p, exp)
    p.exp = p.exp + exp
    local level = p.level
    p.level = character.get_level(p.exp)
    if p.level ~= level then
        character.update_player_by_level(p)
        return p.level
    end
end

-- ���ݾ����ȡ�ȼ�
function character.get_level(exp)
	return math.ceil(math.sqrt(math.sqrt(exp+1)))
end

-- get max_exp
function character.get_max_exp(level)
	return math.pow(level, 4)
end

-- ���ݵȼ���������
function character.update_player_by_level(p)
	-- exp_max = level ^ 4
	p.exp_max = character.get_max_exp(p.level)
	-- Ѫ�� = 140 + ���� * 15 + �ȼ� * 10
	p.hp_max = 140 + p.endurance * 15 + p.level * 10
	p.hp = p.hp_max
	-- ���� = 90 + ħ�� * 25 + �ȼ� * 10
	p.mp_max = 90 + p.spellpower * 25 + p.level * 10
	p.mp = p.mp_max

	-- ��ս������ = [����*0.75 + �ȼ�*0.5, ����*1.1 + �ȼ�*0.75]
	p.atk_min = math.ceil(p.strength * 0.75 + p.level * 0.5)
	p.atk_max = math.ceil(p.strength * 1.1 + p.level * 0.75)
	-- Զ�̹����� = [����*0.66 + ��ս����*0.15 + �ȼ�*0.2, ����*1.5 + ��ս����*0.35 + �ȼ�*1]
	p.atk_range_min = math.ceil(p.agility * 0.66 + p.atk_min * 0.15 + p.level*0.2)
	p.atk_range_max = math.ceil(p.agility * 1.5 + p.atk_max * 0.35 + p.level)
	-- ħ������ = [����*0.75, ����*3.5]
	p.atk_magic_min = math.ceil(p.intelligence * 0.75)
	p.atk_magic_max = math.ceil(p.intelligence * 3.5)

	-- ���� = ���� * 1.5 + �ȼ�*0.25
	p.armor = math.ceil(p.strength * 1.5 + p.level * 0.25)
	-- ���� = ħ�� * 1.7 + �ȼ�*1.5
	p.resist = math.ceil(p.spellpower * 1.7 + p.level * 1.5)
	-- ���� = ���� * 2 + �ȼ� * 2.25
	p.defense = math.ceil(p.endurance * 2 + p.level * 2.25)

	-- �����˺����� = (���� / 150) ^ 1.25 + 1
	p.crit_dmg = (p.agility / 150) ^ 1.25 + 1
	-- ʩ���ɹ�ϵ��
	p.cast = math.ceil(p.intelligence ^ 1.35 + p.level * 7)
	p.cast_success_rate =  p.cast ^ 0.8 / 998
	-- ��������
	p.crit_rate = (p.will / 400) ^ 0.8
end

-- [roll������min������max��+ ������max-����min)*��־^0.5/50 - ����/ħ��]*(1-�˺��ֵ���* ��������

-- �����˺���ֵ
function Character:Attack(ch, enm, way)
    -- way 1 ����
    -- way 2 Զ��
    -- way 3 ħ��
    local way = way or 1
    local amr, atk_min, atk_max
    local def = self:GetAttr(ch, 'defense')
    local will = self:GetAttr(ch, 'will')

    if way == 1 then
        amr = Enemy:GetAttr(enm, 'armor')
        atk_min, atk_max = self:GetAttr(ch, 'atk_min'), self:GetAttr(ch, 'atk_max')
    elseif way == 2 then
        amr = Enemy:GetAttr(enm, 'armor')
        atk_min, atk_max = self:GetAttr(ch, 'atk_range_min'), self:GetAttr(ch, 'atk_range_max')
    elseif way == 3 then
        amr = Enemy:GetAttr(enm, 'resist')
        atk_min, atk_max = self:GetAttr(ch, 'atk_magic_min'), self:GetAttr(ch, 'atk_magic_max')
    end

    return math.ceil((math.random(atk_min, atk_max) + math.floor((atk_max - atk_min)*will ^ 0.5 / 50) - amr/5) * (1-def ^ 0.5 / 35))
end
