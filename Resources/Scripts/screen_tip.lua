

ScreenTip = {
    tip_txt = '',

    new = function()
        if ScreenTip.scr then return end

        -- 基础设定
        ScreenTip.scr = flux.Screen()

        -- 按键响应
        ScreenTip.scr:lua_KeyInput(wrap(function(this, key, state)
            if state == flux.GLFW_PRESS then
                theWorld:PopScreen()
            end
        end))

        -- OnPush 事件
        ScreenTip.scr:lua_OnPush(wrap(function(this)
            theWorld:PhyPause()
        end))
    
        ScreenTip.scr:lua_OnPop(wrap(function(this)
            theWorld:PhyContinue()
            ScreenGame.player:Reset()
        end))

        -- 初始化控件事件
        ScreenTip.scr:lua_Init(wrap(function(this)

            local size = theWorld:GetSize()

            ScreenTip.txt = flux.TextView(this, nil, 'wqy', ScreenTip.tip_txt)
            ScreenTip.txt:SetPosition(0, -size.y/2+3):SetHUD(true)
            ScreenTip.txt:SetTextColor(1,1,1):SetColor(0,0,0):SetSize(10,2)

            -- 注册按键
            this:RegKey(flux.GLFW_KEY_ESC)
            this:RegKey(flux.GLFW_KEY_SPACE)
            this:RegKey(flux.GLFW_KEY_ENTER)
            this:RegKey(_b'Z');

            this:AddView(ScreenTip.txt)
        end))

    end,
}

function ShowTip(txt)
    ScreenTip.new()
    ScreenTip.tip_txt = txt
    theWorld:PushScreen(ScreenTip.scr, flux.SCREEN_APPEND)    
end
