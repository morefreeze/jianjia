
-- 新手村外围丛林


local function OnInit(self, scr)

    Sound:Load(Sound.BGM.Newbie)

    local views = self.viewlist

    -- 创建边界
    self:CreateEdge()

    views.top = flux.View(scr)
    views.top:SetPosition(9,25):SetColor(1,0,0,0):SetSize(5,0.1)
    views.top:SetPhy(flux.b2_staticBody):PhyNewFixture(101)

    views.left = flux.View(scr)
    views.left:SetPosition(-33.9,-21.7):SetColor(1,0,0,0):SetSize(0.1,8)
    views.left:SetPhy(flux.b2_staticBody):PhyNewFixture(102)

    views.bottom = flux.View(scr)
    views.bottom:SetPosition(8,-25):SetColor(1,0,0,0):SetSize(8,0.1)
    views.bottom:SetPhy(flux.b2_staticBody):PhyNewFixture(103)

    -- 中间的树

    for k,v in pairs(views) do
        if string.find(k,'^b%d+$') then
            v:SetAlpha(0)
        end
    end

end

local function OnLoad(self, scr)
    SceneManager.map:Load('Resources/Maps/forest_outside_1.tmx'):SetAlpha(1)
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
            if SceneManager.player:CheckFacing(views.dummy) then
            elseif SceneManager.player:CheckFacing(views.v) then
            end
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
        SceneManager:Load('newbie_a2', -4, -22.5)
    elseif a.index == 3 and b.index == 102 then
        SceneManager:Load('forest_outside_2', 30, 5)
    elseif a.index == 3 and b.index == 103 then
        ShowText(0, {{'伊方', '我应该先去丛林西侧。'}})
    end

end

local function PhyContactEnd(self, scr, a, b)
    
end

Scene('forest_outside_1', '丛林', OnInit, OnLoad, KeyInput, PhyContactBegin, PhyContactEnd)
