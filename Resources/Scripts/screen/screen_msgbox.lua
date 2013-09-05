
MsgBox = {}

MsgBox.STYLE_OK    = 1
MsgBox.STYLE_YESNO = 2

MsgBox.ON_OK  = 1
MsgBox.ON_YES = 1
MsgBox.ON_NO  = 2

-- OnPush 事件
ScreenMsgBox:lua_OnPush(wrap(function(scr)
    local self = ScreenMsgBox
    self.index = MsgBox.ON_NO
    thePhy:Pause()

    if MsgBox.style == MsgBox.STYLE_YESNO then
        self.sel:SetPosition(1.5, -0.5)
        self.ok:SetVisible(false)
        self.yes:SetVisible(true)
        self.no:SetVisible(true)
    else
        self.sel:SetPosition(0, -0.5)
        self.yes:SetVisible(false)
        self.no:SetVisible(false)
        self.ok:SetVisible(true)
    end
end))


-- 初始化控件事件
ScreenMsgBox:lua_Init(wrap(function(scr)

    local self = ScreenMsgBox

    -- 生成控件
    self.bg = flux.View()
    self.bg:SetHUD(true):SetColor(0,0,0):SetPosition(0, 0):SetSize(10.0, 4.0)

    self.text = flux.TextView("wqy", 25)
    self.text:SetTextColor(1,1,1):SetHUD(true):SetPosition(0, 1)
    self.text:SetText(MsgBox.text)

    self.sel = flux.View()
    self.sel:SetHUD(true)
    self.sel:SetColor(0.69,0.69,0.69)
    self.sel:SetSize(3.0, 1.0)

    self.yes = flux.TextView('wqy', 25)
    self.yes:SetTextColor(1,1,1)
    self.yes:SetHUD(true)
    self.yes:SetPosition(-1.5, -0.5)
    self.yes:SetText('是')

    self.no = flux.TextView("wqy", 25)
    self.no:SetTextColor(1,1,1)
    self.no:SetHUD(true)
    self.no:SetPosition(1.5, -0.5)
    self.no:SetText('否')

    self.ok = flux.TextView("wqy", 25)
    self.ok:SetTextColor(1,1,1)
    self.ok:SetHUD(true)
    self.ok:SetPosition(0, -0.5)
    self.ok:SetText('确定')

    -- 注册按键
    self:RegKey(flux.GLFW_KEY_ESCAPE)
    self:RegKey(flux.GLFW_KEY_SPACE)
    self:RegKey(flux.GLFW_KEY_LEFT)
    self:RegKey(flux.GLFW_KEY_RIGHT)
    self:RegKey(flux.GLFW_KEY_ENTER)
    self:RegKey(_b'Z')
    
    self:AddView(self.bg)
    self:AddView(self.text)
    self:AddView(self.sel)
    self:AddView(self.yes)
    self:AddView(self.no)
    self:AddView(self.ok)

end))

ScreenMsgBox:lua_OnPop(wrap(function(scr)
    thePhy:Continue()
end))

ScreenMsgBox:lua_KeyInput(wrap(function(scr, key, scancode, action, mods)

    local self = ScreenMsgBox

    if action == flux.GLFW_PRESS then
        if key == flux.GLFW_KEY_SPACE or key == flux.GLFW_KEY_ENTER or key == _b'Z' then
            theWorld:PopScreen()

            if MsgBox.callback then
                MsgBox.callback(self.index)
            end
        elseif key == flux.GLFW_KEY_LEFT or key == flux.GLFW_KEY_RIGHT then
            if MsgBox.style == MsgBox.STYLE_YESNO then
                if self.index == MsgBox.ON_YES then
                    self.index = MsgBox.ON_NO
                    self.sel:SetPosition(1.5, -0.5)
                else
                    self.index = MsgBox.ON_YES
                    self.sel:SetPosition(-1.5, -0.5)
                end
            end
        elseif key == flux.GLFW_KEY_ESCAPE then
            theWorld:PopScreen()
        end
    end

end))

function MsgBox:Show(text, style, callback)

    Utils:PlayerStop()
	MsgBox.style = style or MsgBox.STYLE_OK
    MsgBox.callback = callback
    MsgBox.text = text or ''
    theWorld:PushScreen(ScreenMsgBox.scr, flux.SCREEN_APPEND)

end
