
character = {}
function character.new(name)
	return {
		name = name,
		exp_max = 1,
		exp = 0,
		level = 0,

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
		defense = 0,
		resist = 0,
		armor = 0,

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
	}
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

	-- ���� = ���� * 2 + �ȼ� * 2.25
	p.defense = math.ceil(p.endurance * 2 + p.level * 2.25)
	-- ���� = ħ�� * 1.7 + �ȼ�*1.5
	p.resist = math.ceil(p.spellpower * 1.7 + p.level * 1.5)
	-- ���� = ���� * 1.5 + �ȼ�*0.25
	p.armor = math.ceil(p.strength * 1.5 + p.level * 0.25)

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
function character.attack(ch, enm, way)
	-- way 1 ����
	-- way 2 Զ��
	-- way 3 ħ��
	local way = way or 1
	local def, atk_min, atk_max
	if way == 1 then
		def = enm[8]
		atk_min, atk_max = ch.atk_min, ch.atk_max
	elseif way == 2 then
		def = enm[8]
		atk_min, atk_max = ch.atk_range_min, ch.atk_range_max
	elseif way == 3 then
		def = enm[9]
		atk_min, atk_max = ch.atk_magic_min, ch.atk_magic_max
	end
	return math.ceil((math.random(atk_min, atk_max) + math.floor((atk_max - atk_min)*ch.will ^ 0.5 / 50) - def/5) * (1-enm[10] ^ 0.5 / 35))
end
