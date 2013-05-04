

ScreenGame = {

    new = function()
        if ScreenGame.scr then return end

		-- �����趨
        ScreenGame.scr = flux.RMScreen()
		
		-- OnPush �¼�
        ScreenGame.scr:lua_OnPush(wrap(function(this)
			ScreenGame.scr:SetPlayer(ScreenGame.player)
			this:AddView(ScreenGame.player)
			this:AddView(ScreenGame.v1, -2)
			this:AddView(ScreenGame.t1, -2)
        end))

		-- ������Ӧ
        ScreenGame.scr:lua_KeyInput(wrap(function(this, key, state)
		    if state == flux.GLFW_PRESS then
                if key == flux.GLFW_KEY_ESC then
                    -- MsgBox(101, "�Ƿ���Ҫ�ص�����ҳ�棿")
				elseif key == _b'Z' then
					if ScreenGame.player:CheckFacing(ScreenGame.v1, 0.5) then
						print('����ս��!')
						theWorld:PushScreen(ScreenFight.scr, flux.SCREEN_APPEND)
					end
                end
            end
        end))
	
		-- ��ʼ���ؼ��¼�
        ScreenGame.scr:lua_Init(wrap(function(this)
            -- ���ɿؼ�
            ScreenGame.player = flux.RMCharacter(this)
			ScreenGame.player:SetColor(1,0,0)
			ScreenGame.player:SetPhy()
			
            ScreenGame.t1 = flux.TextView(this, nil, 'wqy', '����')
			ScreenGame.t1:SetValueMode(1):SetPosition(0, 5.5)
            ScreenGame.v1 = flux.View(this)
			ScreenGame.v1:SetValueMode(1):SetSprite('Resources/Images/fight.jpg'):SetSize(1.3,1.5):SetPosition(0,7):SetPhy(flux.b2_staticBody):PhyNewFixture(101)

            -- ע�ᰴ��
            this:RegKey(_b'Z')
            this:RegKey(flux.GLFW_KEY_ESC)
            this:RegKey(flux.GLFW_KEY_SPACE)
            this:RegKey(flux.GLFW_KEY_LEFT)
            this:RegKey(flux.GLFW_KEY_RIGHT)
            this:RegKey(flux.GLFW_KEY_UP)
            this:RegKey(flux.GLFW_KEY_DOWN)

        end))

    end,
}
