
function ShowText(fromcode, textlist, ch_info)

	-- ch_info = {'pic1', 'pic2', ...}
	
	scr = {}

    if scr.ScreenText == nil then
        ScreenText = {}
        scr.ScreenText = flux.Screen()

        scr.ScreenText:lua_OnPush(wrap(function(this)
            -- ���ɿؼ�
			theWorld:PhyPause()

            local bg = flux.View(this)
            bg:SetHUD(true)
			bg:SetSize(24, 6)
            -- bg:SetColor(0,0,1,0.5)
            bg:SetPosition(0, -6)
			bg:SetSprite('Resources/Images/textbg.png')
            this:AddView(bg)

			local t
			if type(ScreenText.textlist[1]) == 'string' then
			    t = flux.TextView(this, nil, 'wqy', ScreenText.textlist[1])
			else
				t = flux.TextView(this, nil, 'wqy', ScreenText.textlist[1][1])
			end
            t:SetHUD(true)
            t:SetColor(1,1,1)
            t:SetPosition(0, -6)
            this:AddView(t)

			--local ch1 = flux.View(this)
			--local ch2 = flux.View(this)

            -- ע�ᰴ��
			this:RegKey(_b'Z')
            this:RegKey(flux.GLFW_KEY_LEFT)
            this:RegKey(flux.GLFW_KEY_ESC)
            this:RegKey(flux.GLFW_KEY_ENTER)
            this:RegKey(flux.GLFW_KEY_SPACE)
            this:RegKey(flux.GLFW_KEY_RIGHT)

            -- ��������
            ScreenText.bg = bg
            ScreenText.t = t

			scr.ScreenText:lua_OnPush(wrap(function(this)
				if type(ScreenText.textlist[1]) == 'string' then
					ScreenText.t:SetText(ScreenText.textlist[1])
				else
					ScreenText.t:SetText(ScreenText.textlist[1][1])
				end
				theWorld:PhyPause()
			end))
        end))

        scr.ScreenText:lua_OnPop(wrap(function(this)
			theWorld:PhyContinue()
		end))

        scr.ScreenText:lua_KeyInput(wrap(function(this, key, state)
            if state == flux.GLFW_PRESS then
                if key == flux.GLFW_KEY_ENTER or key == flux.GLFW_KEY_SPACE or key == _b'Z' or key == flux.GLFW_KEY_RIGHT then
					if ScreenText.curpos > #ScreenText.textlist then
						this:SetFromCode(ScreenText.fromcode)
						theWorld:PopScreen()
					else
						local text = ScreenText.textlist[ScreenText.curpos]
						if type(text) == 'string' then
							ScreenText.t:SetText(text)
						else
							ScreenText.t:SetText(text[1])
							if text[2] then
								-- text[2] ��������
								-- text[3] ������λ�ã�1����࣬2���Ҳ�
							end
							if text[4] then
								-- text[4] Ϊ�����������ڿ�����˵����ͬʱ��������
								theSound.PlaySound(text[4])
							end
						end
						ScreenText.curpos = ScreenText.curpos + 1
					end
				elseif key == flux.GLFW_KEY_LEFT then
					-- ��ʱ�����ǰһ�仰
					if ScreenText.curpos > 2 then
						local text = ScreenText.textlist[ScreenText.curpos-2]
						if type(text) == 'string' then
							ScreenText.t:SetText(text)
						else
							ScreenText.t:SetText(text[1])
						end
						ScreenText.curpos = ScreenText.curpos - 1
					end
				elseif key == flux.GLFW_KEY_ESC then
					this:SetFromCode(ScreenText.fromcode)
					theWorld:PopScreen()
                end
            end
        end))

    end

	ScreenText.fromcode = fromcode
	ScreenText.textlist = textlist
	ScreenText.curpos = 2
    theWorld:PushScreen(scr['ScreenText'], flux.SCREEN_APPEND)

end
