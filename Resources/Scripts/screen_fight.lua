

ScreenFight = {

    new = function()
        if ScreenFight.scr then return end

		-- �����趨
        ScreenFight.scr = flux.Screen()
		
		-- OnPush �¼�
        ScreenFight.scr:lua_OnPush(wrap(function(this)
			ScreenFight.splash:FadeOut(0.5):AnimDo()
        end))

		-- ������Ӧ
        ScreenFight.scr:lua_KeyInput(wrap(function(this, key, state)
		
        end))
	
		-- ��ʼ���ؼ��¼�
        ScreenFight.scr:lua_Init(wrap(function(this)
            -- ���ɿؼ�
			ScreenFight.bg = flux.View(this):SetHUD(true):SetSize(32, 24)

			ScreenFight.splash = flux.View(this)
			ScreenFight.splash:SetSize(32, 24):SetColor(0,0,0)

            -- ע�ᰴ��
            this:RegKey(_b'Z')
            this:RegKey(flux.GLFW_KEY_ESC)
            this:RegKey(flux.GLFW_KEY_SPACE)
            this:RegKey(flux.GLFW_KEY_LEFT)
            this:RegKey(flux.GLFW_KEY_RIGHT)
            this:RegKey(flux.GLFW_KEY_UP)
            this:RegKey(flux.GLFW_KEY_DOWN)

			this:AddView(ScreenFight.bg)
			this:AddView(ScreenFight.splash)
        end))

    end,
}
