
-- 新手村外围丛林

local function OnInit(self, scr)

    Sound:Load(Sound.BGM.Newbie)

    local views = self.viewlist

    -- 创建边界
    self:CreateEdge()
    
    views.left = flux.View(scr)
    views.left:SetPosition(-33.8, 0):SetColor(1,0,0,0):SetSize(0.1,5)
    views.left:SetPhy(flux.b2_staticBody):PhyNewFixture(101)

    views.right = flux.View(scr)
    views.right:SetPosition(34, 5):SetColor(1,0,0,0):SetSize(0.1,8)
    views.right:SetPhy(flux.b2_staticBody):PhyNewFixture(102)

    -- 中间的树

    for k,v in pairs(views) do
        if string.find(k,'^b%d+$') then
            v:SetAlpha(0)
        end
    end

end

local function OnLoad(self, scr)
    SceneManager.map:Load('Resources/Maps/forest_outside_2.tmx'):SetAlpha(1)
    theSound:SetBGM(0)
    self:ResetEdge()

    theWorld:DelayRun(wrap(function()
        scr:SetPlayer(SceneManager.player)
        SceneManager.player:Reset()
    end), 1)
    
end

local function KeyInput(self, scr, key, state)

    local views = self.viewlist
    
    if state == flux.GLFW_PRESS then
        if key == _b'Z' or key == flux.GLFW_KEY_SPACE then

        end
    end

end

local function PhyContactBegin(self, scr, a, b)
    -- 上边界
    if a.index == 3 and b.index == 10001 then
    -- 左边界
    elseif a.index == 3 and b.index == 10002 then
    -- 右边界
    elseif a.index == 3 and b.index == 10003 then
    -- 下边界
    elseif a.index == 3 and b.index == 10004 then
    end

    if a.index == 3 and b.index == 101 then
        SceneManager:Load('forest_outside_3', 30, 3.725)
    elseif a.index == 3 and b.index == 102 then
        SceneManager:Load('forest_outside_1', -32, -20.7)
    end

end

local function PhyContactEnd(self, scr, a, b)
    
end

Scene('forest_outside_2', '丛林', OnInit, OnLoad, KeyInput, PhyContactBegin, PhyContactEnd)
