

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
        end))

        -- AfterPush �¼�
        ScreenGame.scr:lua_AfterPush(wrap(function(this)

            if table.empty(data.ch) then
                data.ch = {
                    character.new('����')
                }
                character.update_player_by_level(data.ch[1])
                --��ʼ������
                data.ch[1].skills[2]=3
                data.ch[1].skills[3]=1
                data.ch[1].skills[5]=1
                data.ch[1].skills[4]=1
                --data.ch[1].spells[7]=1
                ShowText(101, {'ѡ����Ӫ'})
            end
        end))

        ScreenGame.scr:lua_OnResume(wrap(function(this, from, ret)
            if from == 0 then
                ScreenGame.player:Reset()
            elseif from == 3 then
                -- ��ս�������л���
                if ret ~= 0 then
                    for k,v in pairs(data.ch) do
                        local level = character.exp_inc(v, ret)
                        if level then
                            print('���', v.name, '������', level, '��')
                        end
                    end
                end
            elseif from == 101 then
                ScreenAlignmentChoose.new()
                theWorld:PushScreen(ScreenAlignmentChoose.scr, flux.SCREEN_APPEND)
            elseif from == 1001 then
                data.player.alignment = ret
            end
        end))

        -- ������Ӧ
        ScreenGame.scr:lua_KeyInput(wrap(function(this, key, state)
            if state == flux.GLFW_PRESS then
                if key == flux.GLFW_KEY_ESC then
                -- MsgBox(101, "�Ƿ���Ҫ�ص�����ҳ�棿")
                elseif key == _b'Z' then
                    if ScreenGame.player:CheckFacing(ScreenGame.boss, 0.5) then
                        --�������
                        -- ShowText(0, {{"����С���������","�����ߣ���ʲô��˵��ô��",2,1,102,{'����ȱ��ԭ������','ԭ���������������'},callback},{"���ص���",{"��֧1�Ľ��","��֧2�Ľ��"},1,2,101,{'��֧3','��֧4'}},{"Yu","b",2,1,101,{"ffdsaf1","fdafdsa2"}},{"���ص���","c",1,2,102},{"Yu","d",2,1,102},"һ�����������߰�"},{"Resources/Images/SCA07.png","Resources/Images/hero.png"})
                        --ͷ�����
                        ShowText(0, {{"����С���������","�����ߣ���ʲô��˵��ô��",2,3,102,{'����ȱ��ԭ������','ԭ���������������'},callback},{"���ص���",{"��֧1�Ľ��","��֧2�Ľ��"},1,4,101,{'��֧3','��֧4'}},{"Yu","b",2,3,101,{"ffdsaf1","fdafdsa2"}},{"���ص���","c",1,4,102},{"Yu","d",2,3,102},"һ�����������߰�"},{"Resources/Images/hero.png","Resources/Images/hero.png"})

                    elseif ScreenGame.player:CheckFacing(ScreenGame.dummy) then
                        print('ľ׮��ս��ʹ��')
                        ShowFight(enemy_set.newbie)
                    elseif ScreenGame.player:CheckFacing(ScreenGame.head) then
                        RandomShowText({{0, {{'�峤', '���룬���ģ����룬���ģ����룬���ġ���'}}},  {0, {{'�峤', '����������Բ����ĸ�����ϯ������ѽ~'}}}, {0, {{'�峤', '��ʵ��ֻ��һ��һʮ����ģ�������������ʮ����Ƚ�����һ�㣿'}}}})
                    end
                elseif key == _b'C' then
                    if data.ch[1] then
                        theWorld:PushScreen(ScreenCharacter.scr, flux.SCREEN_APPEND)
                        show_character_content(data.ch[1])
                    end
                end
            end
        end))
    
        -- ��ʼ���ؼ��¼�
        ScreenGame.scr:lua_Init(wrap(function(this)
            -- ���ɿؼ�
            ScreenGame.player = flux.RMCharacter(this)
            ScreenGame.player:SetColor(1,0,0) -- SetRotation(-45)
            ScreenGame.player:SetPhy()

            ScreenGame.boss = flux.TextView(this, nil, 'wqy', '')
            ScreenGame.boss:SetTextColor(1,1,1):SetSize(1.079, 1.245):SetPosition(3, 12.5):SetSprite('Resources/Images/fight.jpg'):SetPhy(flux.b2_staticBody):PhyNewFixture()

            ScreenGame.dummy = flux.TextView(this, nil, 'wqy', 'ľ׮')
            ScreenGame.dummy:SetTextColor(1,1,1):SetSize(1.5, 1):SetColor(0,0,0):SetPosition(-2, 11):SetRotation(-45):SetPhy(flux.b2_staticBody):PhyNewFixture()

            this:AddView(ScreenGame.player)
            this:AddView(ScreenGame.boss)
            this:AddView(ScreenGame.dummy)
            
            ScreenGame.grass = flux.TmxMap(this)
            ScreenGame.grass:Load('Resources/Maps/example.tmx'):SetPosition(0, 4)
            --ScreenGame.grass:SetSize(500, 500):SetSprite('Resources/Images/grass.jpg'):SetPaintMode(flux.PAINT_MODE_TILE)
            this:AddView(ScreenGame.grass, -1)

            ScreenGame.school = flux.TextView(this, nil, 'wqyL', 'ѧУ')
            ScreenGame.school:SetTextColor(1,1,1):SetColor(0,0,1):SetSize(25, 12):SetPosition(0, 40)
            this:AddView(ScreenGame.school)

            ScreenGame.alchemy = flux.TextView(this, nil, 'wqyL', '���𹤷�')
            ScreenGame.alchemy:SetTextColor(1,1,1):SetColor(1,1,0):SetSize(5.375, 8.16):SetPosition(10, 10):SetSprite('Resources/Images/21.png')
            this:AddView(ScreenGame.alchemy)

            ScreenGame.pet = flux.TextView(this, nil, 'wqyL', '����ҽԺ')
            ScreenGame.pet:SetTextColor(1,1,1):SetSize(5.375, 8.16):SetPosition(10, 20):SetSprite('Resources/Images/27.png')
            this:AddView(ScreenGame.pet)
            
            ScreenGame.smithy = flux.TextView(this, nil, 'wqyL', '������')
            ScreenGame.smithy:SetTextColor(1,1,1):SetSize(10, 10):SetPosition(-10, 14):SetSprite('Resources/Images/buildings/smithy.png')
            this:AddView(ScreenGame.smithy)

            ScreenGame.fair = flux.TextView(this, nil, 'wqyL', '����')
            ScreenGame.fair:SetTextColor(1,1,1):SetColor(0, 0.75, 0):SetSize(20, 20):SetPosition(0, -13)
            this:AddView(ScreenGame.fair)

            ScreenGame.headhome = flux.TextView(this, nil, 'wqyL', '�峤��')
            ScreenGame.headhome:SetTextColor(1,1,1):SetColor(0.75, 0, 0):SetSize(8, 5):SetPosition(-20, -13)
            this:AddView(ScreenGame.headhome)

            ScreenGame.hotel = flux.TextView(this, nil, 'wqyL', '�õ�')
            ScreenGame.hotel:SetTextColor(1,1,1):SetColor(0.75, 0, 0):SetSize(8, 5):SetPosition(-34, -13)
            this:AddView(ScreenGame.hotel)
            
            ScreenGame.bar = flux.TextView(this, nil, 'wqyL', '�ư�')
            ScreenGame.bar:SetTextColor(1,1,1):SetColor(0.75, 0, 0):SetSize(8, 5):SetPosition(-49, -13)
            this:AddView(ScreenGame.bar)
            
            ScreenGame.uptown1 = flux.TextView(this, nil, 'wqyL', '������1')
            ScreenGame.uptown1:SetTextColor(1,1,1):SetColor(0, 0.35, 0.55):SetSize(30, 15):SetPosition(30, -29)
            this:AddView(ScreenGame.uptown1)
            
            ScreenGame.church = flux.TextView(this, nil, 'wqyL', '����')
            ScreenGame.church:SetTextColor(1,1,1):SetColor(0.44, 0.35, 0.55):SetPosition(-30, 27):SetSize(13, 23)
            this:AddView(ScreenGame.church)
            
            ScreenGame.uptown2 = flux.TextView(this, nil, 'wqyL', '������2')
            ScreenGame.uptown2:SetTextColor(1,1,1):SetColor(0, 0.35, 0.55):SetSize(15, 33):SetPosition(30, 29)
            this:AddView(ScreenGame.uptown2)

            ScreenGame.wharf = flux.TextView(this, nil, 'wqyL', '��ͷ')
            ScreenGame.wharf:SetTextColor(1,1,1):SetColor(0.45, 0.25, 0.55):SetPosition(27, 68):SetSize(15, 33)
            this:AddView(ScreenGame.wharf)

            ScreenGame.head = flux.TextView(this, nil, 'wqy', '�峤')
            ScreenGame.head:SetTextColor(1,1,1):SetSize(1,1):SetColor(0,0,0):SetPosition(-20, -8):SetPhy(flux.b2_staticBody):PhyNewFixture()
            this:AddView(ScreenGame.head)

            -- ע�ᰴ��
            this:RegKey(_b'Z')
            -- character board
            this:RegKey(_b'C')
            this:RegKey(flux.GLFW_KEY_ESC)
            this:RegKey(flux.GLFW_KEY_SPACE)
            this:RegKey(flux.GLFW_KEY_LEFT)
            this:RegKey(flux.GLFW_KEY_RIGHT)
            this:RegKey(flux.GLFW_KEY_UP)
            this:RegKey(flux.GLFW_KEY_DOWN)

        end))

    end,
}
