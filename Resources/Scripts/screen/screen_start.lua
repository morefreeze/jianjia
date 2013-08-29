
ScreenStart:lua_Init(wrap(function(scr)

    local self = ScreenStart

    theSound:LoadSound(101, "Resources/Sounds/se001.ogg")
    theSound:LoadSound(102, "Resources/Sounds/se002.ogg")
    
    local size = theWorld:GetSize()

    self.title = flux.TextView('wqy', 35)
    self.title:SetPosition(0, 6):SetHUD(true)
    self.title:SetTextColor(1,0.3,0)
    self.title:SetText('这是个|#000000 |@40标题')

    self.bg = flux.View()
    self.bg:SetHUD(true):SetSize(size.x, size.y*3):SetPosition(0, -size.y*1)
    self.bg:SetSpriteFrame("Resources/Images/start/bg/sun.png", 0)
    
    self.txt = flux.TextView('wqy', 15)
    self.txt:SetPosition(0, -5):SetHUD(true)
    self.txt:SetTextColor(0,0,0)
    self.txt:SetText('按|#ff0000←→|#000000切换菜单项，Space或Enter开始')
    --self.txt:SetTextColor(0.69,0.69,0.69)

    self.menu = Widget.SliderIcon(scr)
    self.menu:SetData({'开始', 'Resources/Images/start/start.png'}, {'关于', 'Resources/Images/start/about.png'}, {'离开', 'Resources/Images/start/quit.png'})
    self.menu:SetSel(1)
    self.menu:SetMoveCallback(function(sel)
        theSound:PlaySound(101)
        self.bg:MoveTo(0.5, flux.Vector2(0, (sel-1)*size.y - size.y)):AnimDo()
        self.bar:SetSel(sel)
    end)
    self.menu._viewlist.txt:SetTextColor(0,0,0)
    
    self.bar = Widget.IconBar(scr, {0, -3.5}, 3)
    self.bar:SetData({'开始', 'Resources/Images/start/start.png'}, {'关于', 'Resources/Images/start/about.png'}, {'离开', 'Resources/Images/start/quit.png'})

    self.menu:SetSelectCallback(function(cursel)
        theSound:PlaySound(102)
        if cursel == 1 then
            theWorld:PushScreen(ScreenGame.scr)
        elseif cursel == 2 then
            --theWorld:PushScreen(ScreenAbout.scr)
        elseif cursel == 3 then
            theWorld:EndGame()
        end
    end)
    
    -- 注册按键
    self:RegKey(flux.GLFW_KEY_ESCAPE)
    self:RegKey(flux.GLFW_KEY_LEFT)
    self:RegKey(flux.GLFW_KEY_RIGHT)
    self:RegKey(flux.GLFW_KEY_UP)
    self:RegKey(flux.GLFW_KEY_DOWN)
    self:RegKey(flux.GLFW_KEY_SPACE)
    self:RegKey(flux.GLFW_KEY_ENTER)
    self:RegKey(_b'Z');
    
    self:AddView(self.bg)
    self:AddView(self.txt)
    self:AddView(self.title)
    self.menu:AddToScreen(scr)
    self.bar:AddToScreen(scr)
    
end))

-- 按键响应
ScreenStart:lua_KeyInput(wrap(function(scr, key, scancode, action, mods)
    --print(key, scancode, action, mods)
    local self = ScreenStart

    if action == flux.GLFW_PRESS then
        if key == flux.GLFW_KEY_ESCAPE then
            theWorld:EndGame()
        else
            self.menu:KeyInput(scr, key, action)
        end
    end
end))

-- OnPush 事件
ScreenStart:lua_OnPush(wrap(function(this)
    theSound:SetBGM(0)
    --ScreenStart.bg:PlayFrame(2, 0, 6):Sleep(15):Loop()
end))
