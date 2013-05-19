
require('scene.scene')

Fifo = Class(function(self)
    -- ������
	self.fifo_list = {}
end)

local scenes_fifo = Fifo()

SceneManager = Class()
SceneManager.scene = {}
SceneManager.now = nil

function SceneManager:Init()
    SceneManager.scr = ScreenGame.scr
    SceneManager.player = ScreenGame.player
    SceneManager.map = ScreenGame.map
    
    SceneManager.bg = flux.View(self.scr)
    SceneManager.bg:SetHUD(true):SetSize(100, 100):SetColor(0, 0, 0)

    SceneManager.splash = flux.View(self.scr)
    SceneManager.splash:SetHUD(true):SetSize(100, 100):SetColor(0, 0, 0, 0)
end

-- ��ȡ����ʵ��
function SceneManager:Get(scene)
    return SceneManager.scene[scene]
end

-- ��ȡ��������
function SceneManager:GetSceneName()
    if self.now then
        return self.now.name
    end
end

-- ����һ���³���
function SceneManager:Load(scene, x, y)
    theWorld:DelayRun(wrap(function()
        self:Unload()
        self.splash:SetAlpha(1):AnimCancel()
        self.splash:Sleep(0.5):FadeOut(0.5):AnimDo()
        local find_index = scenes_fifo:find (scene)
        if find_index > 1 then
            scenes_fifo:set_priority ( find_index)
        else
            local pop_scene = scenes_fifo:push (scene)
            if not table.empty(pop_scene) then            
                print ("unload scene" , pop_scene )
    --			�����unload����
    --			pop_scenes.unload()
            end
            require('scene.' .. scene)
        end
        if x and y then
            self.player:SetPosition(x, y)
        end
        self.scene[scene]:AddToScreen(self.scr)
        self.now = self.scene[scene]
        self.now.name = scene
    end))
end

-- �뿪��ǰ����
function SceneManager:Unload()
    self.scr:RemoveAllView()
    self.scr:AddView(self.map)
    self.scr:AddView(self.player)
    self.scr:AddView(self.bg, -1)
    self.scr:AddView(self.splash, 99)
    self.now = nil
end

-- �ͷ�һ����������Դ
function SceneManager:FreeScene(scene)

end

-- ������Ӧ
function SceneManager:KeyInput(scr, key, state)
    if self.now then
        self.now:KeyInput(scr, key, state)
    end
end

-- ��ײ��ʼ
function SceneManager:PhyContactBegin(scr, a, b)
    if self.now then
        self.now:PhyContactBegin(scr, a, b)
    end
end

-- ��ײ����
function SceneManager:PhyContactEnd(scr, a, b)
    if self.now then
        self.now:PhyContactEnd(scr, a, b)
    end
end

--���Ƕ���fifo���Ϊ10

function Fifo:push(scene)
	if #self.fifo_list == 10 then
		local unload_scene = self.fifo_list[10]
		for j = 10, 2, -1 do
			self.fifo_list[j] = self.fifo_list[j - 1]
		end
		self.fifo_list[1] = scene

		return unload_scene
	else
		for j = #self.fifo_list + 1, 2, -1 do
			self.fifo_list[j] = self.fifo_list[j - 1]
		end
		self.fifo_list[1] = scene
	end
	return {}
end


function Fifo:pop(param)

end

function Fifo:set_priority(find_index)
	tmp = self.fifo_list[find_index]
	for j = find_index, 2, -1 do
		self.fifo_list[j] = self.fifo_list[j - 1]
	end
	self.fifo_list[1] = tmp
end

function Fifo:find(scene)
	for i = 1, 10, 1 do
        if self.fifo_list[i] == scene then
            return i
        end
    end
	return 0
end

--print (scene_find (t,6))
