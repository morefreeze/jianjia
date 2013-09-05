
local bit = require("bit")

relp = {
    p1 = flux.View(),
    p2 = flux.View(),
    p3 = flux.View(),
    p4 = flux.View(),
    
    reset = function()
        local size = theWorld:GetSize()
        relp.p1:SetPosition(-size.x/2,  size.y/2)
        relp.p2:SetPosition( size.x/2,  size.y/2)
        relp.p3:SetPosition( size.x/2, -size.y/2)
        relp.p4:SetPosition(-size.x/2, -size.y/2)
    end,
}

ScreenGame:lua_Init(wrap(function(scr)

    local self = ScreenGame
    self.phy = flux.ChipmunkWorld()
    theWorld:SetPhy(self.phy)
    thePhy = self.phy
    relp.reset()

	self.phy:lua_CollisionBegin(wrap(function(base, a, b)
        self.scene:CollisionBegin(self, a, b)
	end))

    self.map = flux.TmxMap()
    self.map:SetBlockSize(2)
    self:AddView(self.map, -1)

    self.player = flux.TileCharacter()
    self.player:SetSprite('Resources/Images/ch/evans.png', 16)
    self.player:SetSize(2.2, 2.64)
    self.phy:AddTileCharacter(self.player)
    
    self.mapname = flux.TextView('wqy', 15)
    self.mapname:SetAlign(flux.ALIGN_RIGHT)
    self.mapname:SetAnchor(relp.p2)
    self.mapname:SetPosition(-1, -1):SetHUD(true)
    self.mapname:SetTextColor(1,1,1)

    self.player:lua_MoveCallback(wrap(function(is_move, dir)
        local player = self.player
        if not is_move then 
            Utils:PlayerResetAnim()
        else
            if bit.band(dir, flux.TD_LEFT) ~= 0 then
                player:AnimCancel()
                player:PlayFrame(0.6, 0,3):Loop()
            elseif bit.band(dir, flux.TD_RIGHT) ~= 0 then
                player:AnimCancel()
                player:PlayFrame(0.6, 4,7):Loop()
            elseif bit.band(dir, flux.TD_UP) ~= 0 then
                player:AnimCancel()
                player:PlayFrame(0.6, 12,15):Loop()
            elseif bit.band(dir, flux.TD_DOWN) ~= 0 then
                player:AnimCancel()
                player:PlayFrame(0.6, 8,11):Loop()
            end
        end
    end))

    self:AddView(self.player)
    self:AddView(self.mapname)
    self:LoadScene("newbie2")

    -- 注册按键
    self:RegKey(flux.GLFW_KEY_ESCAPE)
    self:RegKey(flux.GLFW_KEY_LEFT)
    self:RegKey(flux.GLFW_KEY_RIGHT)
    self:RegKey(flux.GLFW_KEY_UP)
    self:RegKey(flux.GLFW_KEY_DOWN)
    self:RegKey(flux.GLFW_KEY_SPACE)
    self:RegKey(flux.GLFW_KEY_ENTER)
    self:RegKey(_b'Z')
    
end))

ScreenGame:lua_OnPush(wrap(function(scr)
    local self = ScreenGame
    theCamera:SetFocus(self.player)
end))

ScreenGame:lua_AfterPush(wrap(function(scr)
    local self = ScreenGame

    Text.show('名字', '这是一句话')
        .run(function()
                print('custom function called.')
            end)
        .show('测试', '测试一下')
    .go()

end))

ScreenGame:lua_OnPop(wrap(function(scr)
    local self = ScreenGame
    theCamera:SetFocus(nil)
end))

ScreenGame:lua_OnResize(wrap(function()
    local self = ScreenGame

    local pos = self.map:GetSize()
    theCamera:SetSize(pos.x, pos.y)

    relp.reset()
end))

ScreenGame:lua_KeyInput(wrap(function(scr, key, scancode, action, mods)
    local self = ScreenGame

    if action == flux.GLFW_PRESS then
        if key == flux.GLFW_KEY_RIGHT then
            self.player:move(flux.TD_RIGHT)
        elseif key == flux.GLFW_KEY_LEFT then
            self.player:move(flux.TD_LEFT)
        elseif key == flux.GLFW_KEY_UP then
            self.player:move(flux.TD_UP)
        elseif key == flux.GLFW_KEY_DOWN then
            self.player:move(flux.TD_DOWN)
        elseif key == flux.GLFW_KEY_ESCAPE then
            MsgBox:Show("是否想要回到标题页面？", MsgBox.STYLE_YESNO, function(index)
                if index == MsgBox.ON_YES then
                    theWorld:PushScreen(ScreenStart.scr)
                end
            end)
        elseif key == _b'Z' or key == flux.GLFW_KEY_SPACE then
            local v = self.phy:QueryViewByDir(self.player, self.player:GetDir())
            if v and self.scene then
                local info = self.scene:GetInfoFromIndex(v.index)
                if info then
                    Text:random_show(info.base.name, info.base.rchat)
                end
            end
        end
    elseif action == flux.GLFW_RELEASE then
        if key == flux.GLFW_KEY_RIGHT then
            self.player:move_cancel(flux.TD_RIGHT)
        elseif key == flux.GLFW_KEY_LEFT then
            self.player:move_cancel(flux.TD_LEFT)
        elseif key == flux.GLFW_KEY_UP then
            self.player:move_cancel(flux.TD_UP)
        elseif key == flux.GLFW_KEY_DOWN then
            self.player:move_cancel(flux.TD_DOWN)
        end
    end
end))
