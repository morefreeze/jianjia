
ScreenMsgBox = {

    new = function()

        if ScreenMsgBox.scr then return end

        ScreenMsgBox.scr = flux.Screen()

        ScreenMsgBox.scr:lua_OnPush(wrap(function(this)
            ScreenMsgBox.index = 2
			this:SetFromCode(ScreenMsgBox.fromcode or 0)
			this:SetRetCode(0)
			theWorld:PhyPause()
            
            if ScreenMsgBox.style == 1 then
                ScreenMsgBox.sel:SetPosition(1.5, -0.5)
                ScreenMsgBox.ok:SetAlpha(0) -- SetVisible(false)
                ScreenMsgBox.yes:SetAlpha(1)
                ScreenMsgBox.no:SetAlpha(1)
            else
                ScreenMsgBox.sel:SetPosition(0, -0.5)
                ScreenMsgBox.yes:SetAlpha(0)
                ScreenMsgBox.no:SetAlpha(0)
                ScreenMsgBox.ok:SetAlpha(1)
            end

        end))

        ScreenMsgBox.scr:lua_OnPop(wrap(function(this)
			theWorld:PhyContinue()
        end))
        
        -- 初始化控件事件
        ScreenMsgBox.scr:lua_Init(wrap(function(this)
        -- 生成控件
            ScreenMsgBox.About = flux.TextView(this, nil, "wqyL", config.TITLE)
            ScreenMsgBox.About:SetColor(0,0,1):SetPosition(0, 6):SetHUD(true)

            -- 生成控件
            ScreenMsgBox.bg = flux.View(this)
            ScreenMsgBox.bg:SetHUD(true):SetColor(0,0,0):SetPosition(0, 0):SetSize(10.0, 4.0)

            ScreenMsgBox.text = flux.TextView(this, nil, "wqy", ScreenMsgBox._text)
            ScreenMsgBox.text:SetTextColor(1,1,1):SetHUD(true):SetPosition(0, 1)

            ScreenMsgBox.sel = flux.View(this)
            ScreenMsgBox.sel:SetHUD(true):SetColor(0.69,0.69,0.69):SetSize(3.0, 1.0)

            ScreenMsgBox.yes = flux.TextView(this, nil, "wqy", '是')
            ScreenMsgBox.yes:SetTextColor(1,1,1):SetHUD(true):SetPosition(-1.5, -0.5)

            ScreenMsgBox.no = flux.TextView(this, nil, "wqy", '否')
            ScreenMsgBox.no:SetTextColor(1,1,1):SetHUD(true):SetPosition(1.5, -0.5)

            ScreenMsgBox.ok = flux.TextView(this, nil, "wqy", '确定')
            ScreenMsgBox.ok:SetTextColor(1,1,1):SetHUD(true):SetPosition(0, -0.5)

            -- 注册按键
            this:RegKey(flux.GLFW_KEY_ESC)
            this:RegKey(flux.GLFW_KEY_SPACE)
            this:RegKey(flux.GLFW_KEY_LEFT)
            this:RegKey(flux.GLFW_KEY_RIGHT)
            this:RegKey(flux.GLFW_KEY_ENTER)
			this:RegKey(_b'Z')
            
            this:AddView(ScreenMsgBox.bg)
            this:AddView(ScreenMsgBox.text)
            this:AddView(ScreenMsgBox.sel)
            this:AddView(ScreenMsgBox.yes)
            this:AddView(ScreenMsgBox.no)
            this:AddView(ScreenMsgBox.ok)
        end))

        ScreenMsgBox.scr:lua_KeyInput(wrap(function(this, key, state)
            if state == flux.GLFW_PRESS then
                if key == flux.GLFW_KEY_SPACE or key == flux.GLFW_KEY_ENTER or key == _b'Z' then
                    this:SetRetCode(ScreenMsgBox.index)
                    theWorld:PopScreen()

                    if ScreenMsgBox.index == 1 then
                        if ScreenMsgBox.cb_yes_or_ok then
                            ScreenMsgBox.cb_yes_or_ok()
                        end
                    elseif ScreenMsgBox.index == 2 then
                        if ScreenMsgBox.cb_no then
                            ScreenMsgBox.cb_no()
                        end
                    end
                elseif key == flux.GLFW_KEY_LEFT or key == flux.GLFW_KEY_RIGHT then
                    if ScreenMsgBox.style == 1 then
                        if ScreenMsgBox.index == 1 then
                            ScreenMsgBox.index = 2
                            ScreenMsgBox.sel:SetPosition(1.5, -0.5)
                        else
                            ScreenMsgBox.index = 1
                            ScreenMsgBox.sel:SetPosition(-1.5, -0.5)
                        end
                    end
                elseif key == flux.GLFW_KEY_ESC then
                    theWorld:PopScreen()
                end
            end
        end))
        
    end,
}

function MsgBox(fromcode, text, style, cb_yes_or_ok, cb_no)

    ScreenMsgBox.new()
	ScreenMsgBox.style = style or 1
	ScreenMsgBox.fromcode = fromcode
    ScreenMsgBox.cb_yes_or_ok = cb_yes_or_ok
    ScreenMsgBox.cb_no = cb_no
    ScreenMsgBox._text = text or '是否想要回到标题页面？'
    theWorld:PushScreen(ScreenMsgBox.scr, flux.SCREEN_APPEND)

end
