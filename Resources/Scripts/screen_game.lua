
local bit = require("bit")


ScreenGame = {

    new = function()
        if ScreenGame.scr then return end

        -- �����趨
        ScreenGame.scr = flux.RMScreen()

        -- OnPush �¼�
        ScreenGame.scr:lua_OnPush(wrap(function(this)
            theCamera:SetFocus(ScreenGame.player)
            ScreenGame.scr:SetPlayer(ScreenGame.player)
            ScreenGame.player:SetPosition(data.player.x, data.player.y)
            SceneManager:Load(data.player.scene)
            ScreenGame._bg:SetAlpha(1):Sleep(0.7, wrap(function() ScreenGame._bg:SetAlpha(0) end)):AnimDo()
        end))

        -- AfterPush �¼�
        ScreenGame.scr:lua_AfterPush(wrap(function(this)

            if table.empty(data.ch) then
                table.insert(data.ch, Character('����'))

                --��ʼ������
                data.ch[1]:LearnSpell(1)
                data.ch[1]:LearnSpell(2)
            end

        end))

        ScreenGame.scr:lua_OnResume(wrap(function(this, from, ret)
            if from == 0 then
                ScreenGame.player:Reset()
            elseif from == 3 then
                -- ��ս�������л���
                local retval, exp, loot, levelup = GetFightRet()
                if retval == 2 then
                    -- ʤ��
                    print('ս��ʤ��! ��þ��� ' .. exp)
                    
                    if not table.empty(loot) then
                        print('�����Ʒ����:')
                        for k,v in pairs(loot) do
                            print(items[k][1] .. ' X ' .. v)
                        end
                    end
                    for k,v in pairs(levelup) do
                        print('��ɫ', v[1]:GetAttr('name'), '������', v[2], '��')
                    end
                elseif retval == 1 then
                    print('ս��ʧ�ܣ�')
                end
            elseif from == 100001 then
                ScreenAlignmentChoose.new()
                theWorld:PushScreen(ScreenAlignmentChoose.scr, flux.SCREEN_APPEND)
            elseif from == 1001 then
                data.player.alignment = ret
                ShowText(0, {
                    '��Ӫѡ����ɡ�',
                    '�ո����Z������ȷ�ϼ���������Ի�ʱҪ�߽�������֮һ���С�',
                    '����B�����Բ鿴����',
                    '��Ȼ�����￪ʼ��û����Ʒ�ģ�������ֻ������Ʒ',
                    '���ˣ�������տ��Ĵ��������߿��ɣ�',
                })
            end
        end))

        -- ������Ӧ
        ScreenGame.scr:lua_KeyInput(wrap(function(this, key, state)
            SceneManager:KeyInput(this, key, state)

            if state == flux.GLFW_PRESS then
                if key == flux.GLFW_KEY_ESC then
                    MsgBox(0, "�Ƿ���Ҫ�ص�����ҳ�棿", 1, function()
                        ScreenStart.new()
                        theWorld:PushScreen(ScreenStart.scr)
                    end)
                elseif key == _b'C' then
                    --if data.ch[1] then
                    --    theWorld:PushScreen(ScreenCharacter.scr, flux.SCREEN_APPEND)
                    --    show_character_content(data.ch[1])
                    --end
                elseif key == _b'B' then
                    ShowItemPanel(false)
                elseif key == flux.GLFW_KEY_KP_ADD then
                    local v = theSound:GetVolume()
                    if v < 100 then
                        theSound:SetVolume(v + 10)
                        ScreenGame.info:RefreshVolume()
                    end
                elseif key == flux.GLFW_KEY_KP_SUBTRACT then
                    local v = theSound:GetVolume()
                    if v > 0 then
                        theSound:SetVolume(v - 10)
                        ScreenGame.info:RefreshVolume()
                    end
                end
            end
        end))
    
        -- ��ʼ���ؼ��¼�
        ScreenGame.scr:lua_Init(wrap(function(this)
            -- ���ɿؼ�
            ScreenGame.player = flux.RMCharacter(this)
            ScreenGame.player:SetSpeed(6):SetSprite('Resources/Images/ch/yf.png', 16)
            ScreenGame.player:SetSize(2.2, 2.64)
            ScreenGame.player:SetPhy()
            ScreenGame.player:PhyNewFixture(flux.RM_Character) -- flux.RM_Character, false, 1.5, 0.4, flux.Vector2(0, -1.7)
            ScreenGame.player:SetFrame(8)
            ScreenGame.player:SetLight()

            ScreenGame.map = flux.TmxMap(this)
            ScreenGame.map:SetBlockSize(2)
            ScreenGame.map:SetPhy(flux.b2_staticBody)
            ScreenGame.map:SetLight()

            ScreenGame._bg = flux.View(this)
            ScreenGame._bg:SetSize(theWorld:GetSize()):SetColor(0, 0, 0):SetHUD(true)

            ScreenGame._layer = flux.View(this)
            --ScreenGame._layer:SetSize(theWorld:GetSize()):SetColor(0.35, 0.29, 0.16, 0.4):SetHUD(true) -- 90 73 41

            local size = theWorld:GetSize()
            ScreenGame.info = Widget.InfoCard(this, {size.x/2 - 0.34, size.y/2 - 0.8})

            this:AddView(ScreenGame.player)
            this:AddView(ScreenGame._bg, 150)
            this:AddView(ScreenGame.map, -1)
            this:AddView(ScreenGame._layer, 149)
            ScreenGame.info:AddToScreen(this)
            --local sc = flux.Color(0.22, 0.22, 0.9)
            --local sc = flux.Color(0.7, 0.39, 0.09)
            --local sc = flux.Color(0.35, 0.29, 0.16)
            --this:SetSpriteColor(sc)

            -- ע�ᰴ��
            this:RegKey(_b'Z')
            -- character board
            this:RegKey(_b'C')
            this:RegKey(_b'B')
            this:RegKey(flux.GLFW_KEY_ESC)
            this:RegKey(flux.GLFW_KEY_SPACE)
            this:RegKey(flux.GLFW_KEY_LEFT)
            this:RegKey(flux.GLFW_KEY_RIGHT)
            this:RegKey(flux.GLFW_KEY_UP)
            this:RegKey(flux.GLFW_KEY_DOWN)
            this:RegKey(flux.GLFW_KEY_DOWN)
            this:RegKey(flux.GLFW_KEY_KP_ADD)
            this:RegKey(flux.GLFW_KEY_KP_SUBTRACT)
            
            ScreenGame.player:lua_MoveCallback(wrap(function(is_move, dir)
                --print(is_move, dir)
                local self = ScreenGame.player
                if not is_move then
                    self:AnimCancel()
                    if dir == flux.RD_LEFT then
                        self:SetFrame(0)
                    elseif dir == flux.RD_RIGHT then
                        self:SetFrame(4)
                    elseif dir ==flux.RD_TOP then
                        self:SetFrame(12)
                    elseif dir == flux.RD_BOTTOM then
                        self:SetFrame(8)
                    end
                else
                    if bit.band(dir, flux.RD_LEFT) ~= 0 then
                        self:AnimCancel()
                        self:PlayFrame(0.6, 0,3):Loop()
                    elseif bit.band(dir, flux.RD_RIGHT) ~= 0 then
                        self:AnimCancel()
                        self:PlayFrame(0.6, 4,7):Loop()
                    elseif bit.band(dir, flux.RD_TOP) ~= 0 then
                        self:AnimCancel()
                        self:PlayFrame(0.6, 12,15):Loop()
                    elseif bit.band(dir, flux.RD_BOTTOM) ~= 0 then
                        self:AnimCancel()
                        self:PlayFrame(0.6, 8,11):Loop()
                    end
                end
            end))
            
            SceneManager:Init()
        end))

        -- ����Ӵ���ʼ
        ScreenGame.scr:lua_PhyContactBegin(wrap(function(this, a, b)
            SceneManager:PhyContactBegin(this, a, b)
        end))

        -- ����Ӵ�����
        ScreenGame.scr:lua_PhyContactEnd(wrap(function(this, a, b)
            SceneManager:PhyContactEnd(this, a, b)
        end))
    end,
    
    Refresh = function()
        scr = ScreenGame.scr
        scr:AddView(ScreenGame.map)
        scr:AddView(ScreenGame._bg, 150)
        scr:AddView(ScreenGame.player)
        scr:AddView(ScreenGame._layer, 149)
        ScreenGame.info:AddToScreen(scr)
    end,

}
