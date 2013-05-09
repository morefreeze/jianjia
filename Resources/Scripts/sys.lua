

data = {
	num = {
		boot=0,
		game=0,
	},
	player = {
		x = 0, -- x ����
		y = 0, -- y ����
		alignment = 0, -- ��Ӫ
	},
}

math.randomseed(os.time())

require('data.enemy')
require('data.skill')
require('data.character')

-- [[���˲���]]
-- ���˵����԰�����id�� ���֡��ȼ������������������ס����ԡ�ģ��id��ǰ׺id������id�б�����ͼƬ

-- [roll������min������max��+ ������max-����min)*��־^0.5/50 - ����/ħ��]*(1-�˺��ֵ���* ��������

sys = {

	init = function()
		sys.load()
		data.num.boot = data.num.boot + 1
	end,

	save = function()
		if ScreenGame.player then
			local pos = ScreenGame.player:GetPosition()
			data.player.x, data.player.y = pos.x, pos.y
		end
		local f = io.open('Savedata/flag1', 'w+')
		f:write(json.encode(data))
		f.close()
	end,

	load = function()
		lfs.mkdir('Savedata')
		if io.exists('Savedata/flag1') then
			local f = io.open('Savedata/flag1', 'r')
			data = json.decode(f:read('*a'))
			f.close()
		end
	end,
}

