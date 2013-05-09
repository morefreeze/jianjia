
character = {}
function character.new(name)
	return {
		name = name,
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

		-- �Ŀ������ס��������ԡ��������˺�����
		armor = 0,
		resist = 0,
		defense = 0,
		dtr = 0,

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
	return (p.hp > 0)
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
	end
end

-- ���ݾ����ȡ�ȼ�
function character.get_level(exp)
	return math.ceil(math.sqrt(math.sqrt(exp+1)) - 2)
end

-- ���ݵȼ���������
function character.update_player_by_level(p)
	-- Ѫ�� = 140 + ���� * 15 + �ȼ� * 10
	p.hp_max = 140 + p.endurance * 15 + p.level * 10
	p.hp = p.hp_max
	-- ���� = 90 + ħ�� * 25 + �ȼ� * 10
	p.mp_max = 90 + p.spellpower * 25 + p.level * 10
	p.mp = p.mp_max

	-- ��ս������ = [����*0.75 + �ȼ�*0.5, ����*1.1 + �ȼ�*0.75]
	p.atk_min = p.strength * 0.75 + p.level * 0.5
	p.atk_max = p.strength * 1.1 + p.level * 0.75
	-- Զ�̹����� = [����*0.66 + ��ս����*0.15 + �ȼ�*0.2, ����*1.5 + ��ս����*0.35 + �ȼ�*1]
	p.atk_range_min = p.agility * 0.66 + p.atk_min * 0.15 + p.level*0.2
	p.atk_range_max = p.agility * 1.5 + p.atk_max * 0.35 + p.level
	-- ħ������ = [����*0.75, ����*3.5]
	p.atk_magic_min = p.intelligence * 0.75
	p.atk_magic_max = p.intelligence * 3.5

	-- ���� = ���� * 1.5 + �ȼ�*0.25
	p.armor = p.strength * 1.5 + p.level * 0.25
	-- ���� = ħ�� * 1.7 + �ȼ�*1.5
	p.resist = p.spellpower * 1.7 + p.level * 1.5
	-- ���� = ���� * 2 + �ȼ� * 2.25
	p.defense = p.endurance * 2 + p.level * 2.25
	
	-- �����˺����� = (���� / 150) ^ 1.25 + 1
	p.crit_dmg = (p.agility / 150) ^ 1.25 + 1
	-- ʩ���ɹ�ϵ��
	p.cast = (p.intelligence ^ 1.35 + p.level * 7)
	p.cast_success_rate =  p.cast ^ 0.8 / 998
	-- ��������
	p.crit_rate = (p.will / 400) ^ 0.8
	-- �˺�����
	p.dtr = p.armor ^ 0.5 / 35
end

function character.attack(p, e, way)
	-- way 1 ����
	-- way 2 ħ��
	way = way or 1
	if way == 1 then
		-- (math.random(p.atk_min, p.atk_max) + (p.atk_max - p.atk_min)*p.will ^ 0.5 / 50 - e.defense) * p.
	end
end
