
local bit = require("bit")

ScreenGame:lua_Init(wrap(function(scr)

    local self = ScreenGame
    self.phy = flux.ChipmunkWorld()
    theWorld:SetPhy(self.phy)
	
	self.phy:lua_CollisionBegin(wrap(function(base, a, b)
		-- print(base, a, b)
        self.scene:CollisionBegin(self, a, b)
	end))

    self.map = flux.TmxMap()
    self.map:SetBlockSize(2)
    self:AddView(self.map, -1)

    self.player = flux.TileCharacter()
    self.player:SetSprite('Resources/Images/ch/evans.png', 16)
    self.player:SetSize(2.2, 2.64)
    self.phy:AddTileCharacter(self.player)

    self.player:lua_MoveCallback(wrap(function(is_move, dir)
        local player = self.player
        if not is_move then 
            player:AnimCancel()
            if dir == flux.TD_LEFT then
                player:SetFrame(0)
            elseif dir == flux.TD_RIGHT then
                player:SetFrame(4)
            elseif dir == flux.TD_UP then
                player:SetFrame(12)
            elseif dir == flux.TD_DOWN then
                player:SetFrame(8)
            end
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

    self:LoadScene("newbie2")

    -- 注册按键
    self:RegKey(flux.GLFW_KEY_ESCAPE)
    self:RegKey(flux.GLFW_KEY_LEFT)
    self:RegKey(flux.GLFW_KEY_RIGHT)
    self:RegKey(flux.GLFW_KEY_UP)
    self:RegKey(flux.GLFW_KEY_DOWN)
    self:RegKey(flux.GLFW_KEY_SPACE)
    self:RegKey(flux.GLFW_KEY_ENTER)
    self:RegKey(_b'Z');
    
    theCamera:SetFocus(self.player)

end))

ScreenGame:lua_KeyInput(wrap(function(scr, key, scancode, action, mods)
    local self = ScreenGame

    --print(key, scancode, action, mods)
    if action == flux.GLFW_PRESS then
        if key == flux.GLFW_KEY_RIGHT then
            self.player:move(flux.TD_RIGHT)
        elseif key == flux.GLFW_KEY_LEFT then
            self.player:move(flux.TD_LEFT)
        elseif key == flux.GLFW_KEY_UP then
            self.player:move(flux.TD_UP)
        elseif key == flux.GLFW_KEY_DOWN then
            self.player:move(flux.TD_DOWN)
        elseif key == _b'Z' or key == flux.GLFW_KEY_SPACE then
            if self.phy:QueryViewByDir(self.player, self.player:GetDir()) then
                print('NPC find!')
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
