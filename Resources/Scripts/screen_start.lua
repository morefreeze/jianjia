

ScreenStart = {

    new = function()
        if ScreenStart.scr then return end

        -- 基础设定
        theSound:LoadSound(101, "Resources/Sounds/se001.ogg")
        theSound:LoadSound(102, "Resources/Sounds/se002.ogg")
        ScreenStart.scr = flux.Screen()

        -- 按键响应
        ScreenStart.scr:lua_KeyInput(wrap(function(this, key, state)
            if state == flux.GLFW_PRESS then
                if key == flux.GLFW_KEY_ESC then
                    theWorld:EndGame()
                else
                    ScreenStart.menu:KeyInput(this, key, state)
                end
            end
        end))

        -- OnPush 事件
        ScreenStart.scr:lua_OnPush(wrap(function(this)
            theSound:SetBGM(0)
        end))
    
        -- 初始化控件事件
        ScreenStart.scr:lua_Init(wrap(function(this)
            ScreenStart.txt = flux.TextView(this, nil, 'wqyS', '按←→切换菜单项，Space或Enter开始')
            ScreenStart.txt:SetPosition(0, -5):SetHUD(true)
            ScreenStart.txt:SetTextColor(0.69,0.69,0.69)

            ScreenStart.menu = Widget.SiderIcon(this)
            ScreenStart.menu:SetData({'开始', 'Resources/Images/start/start.png'}, {'关于', 'Resources/Images/start/about.png'}, {'离开', 'Resources/Images/start/quit.png'})
            ScreenStart.menu:SetSel(1)
            ScreenStart.menu:SetMoveCallback(function()
                theSound:PlaySound(101)
            end)

            ScreenStart.menu:SetSelectCallback(function(cursel)
                theSound:PlaySound(102)
                if cursel == 1 then
                    theWorld:PushScreen(ScreenGame.scr)
                elseif cursel == 2 then
                    theWorld:PushScreen(ScreenAbout.scr)
                elseif cursel == 3 then
                    theWorld:EndGame()
                end
            end)

            -- 注册按键
            this:RegKey(flux.GLFW_KEY_ESC)
            this:RegKey(flux.GLFW_KEY_LEFT)
            this:RegKey(flux.GLFW_KEY_RIGHT)
            this:RegKey(flux.GLFW_KEY_UP)
            this:RegKey(flux.GLFW_KEY_DOWN)
            this:RegKey(flux.GLFW_KEY_SPACE)
            this:RegKey(flux.GLFW_KEY_ENTER)
            this:RegKey(_b'Z');

            this:AddView(ScreenStart.txt)
            ScreenStart.menu:AddToScreen(this)
        end))

    end,
}
