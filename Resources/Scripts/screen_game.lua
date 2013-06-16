

ScreenGame = {

    new = function()
        if ScreenGame.scr then return end

        -- 基础设定
        ScreenGame.scr = flux.RMScreen()

        -- OnPush 事件
        ScreenGame.scr:lua_OnPush(wrap(function(this)
            theCamera:SetFocus(ScreenGame.player)
            ScreenGame.scr:SetPlayer(ScreenGame.player)
            ScreenGame.player:SetPosition(data.player.x, data.player.y)
            SceneManager:Load(data.player.scene)
        end))

        -- AfterPush 事件
        ScreenGame.scr:lua_AfterPush(wrap(function(this)

            if table.empty(data.ch) then
                table.insert(data.ch, Character('伊方'))

                --初始化技能
                data.ch[1]:LearnSpell(1)
                data.ch[1]:LearnSpell(2)
            end

        end))

        ScreenGame.scr:lua_OnResume(wrap(function(this, from, ret)
            if from == 0 then
                ScreenGame.player:Reset()
            elseif from == 3 then
                -- 从战斗场景中回来
                local retval, exp, loot, levelup = GetFightRet()
                if retval == 2 then
                    -- 胜利
                    print('战斗胜利! 获得经验 ' .. exp)
                    
                    if not table.empty(loot) then
                        print('获得物品掉落:')
                        for k,v in pairs(loot) do
                            print(items[k][1] .. ' X ' .. v)
                        end
                    end
                    for k,v in pairs(levelup) do
                        print('角色', v[1]:GetAttr('name'), '升到了', v[2], '级')
                    end
                elseif retval == 1 then
                    print('战斗失败！')
                end
            elseif from == 100001 then
                ScreenAlignmentChoose.new()
                theWorld:PushScreen(ScreenAlignmentChoose.scr, flux.SCREEN_APPEND)
            elseif from == 1001 then
                data.player.alignment = ret
                ShowText(0, {
                    '阵营选择完成。',
                    '空格键和Z键都是确认键，与人物对话时要走进按两者之一才行。',
                    '另外B键可以查看背包',
                    '当然背包里开始是没有物品的，不过打怪会掉落物品',
                    '好了，在这个空旷的村子里走走看吧！',
                })
            end
        end))

        -- 按键响应
        ScreenGame.scr:lua_KeyInput(wrap(function(this, key, state)
            SceneManager:KeyInput(this, key, state)

            if state == flux.GLFW_PRESS then
                if key == flux.GLFW_KEY_ESC then
                    MsgBox(0, "是否想要回到标题页面？", 1, function()
                        ScreenStart.new()
                        theWorld:PushScreen(ScreenStart.scr)
                    end)
                elseif key == _b'C' then
                    if data.ch[1] then
                        theWorld:PushScreen(ScreenCharacter.scr, flux.SCREEN_APPEND)
                        show_character_content(data.ch[1])
                    end
                elseif key == _b'B' then
                    ShowItemPanel(false)
                end
            end
        end))
    
        -- 初始化控件事件
        ScreenGame.scr:lua_Init(wrap(function(this)
            -- 生成控件
            ScreenGame.player = flux.RMCharacter(this)
            ScreenGame.player:SetSpeed(6):SetSprite('Resources/Images/yf.png')
            ScreenGame.player:SetSize(2.2, 2.64)
            ScreenGame.player:SetPhy()
            ScreenGame.player:PhyNewFixture(flux.RM_Character) -- flux.RM_Character, false, 1.5, 0.4, flux.Vector2(0, -1.7)

            ScreenGame.map = flux.TmxMap(this)
            ScreenGame.map:SetBlockSize(2)
            ScreenGame.map:SetPhy(flux.b2_staticBody)

            local size = theWorld:GetSize()
            ScreenGame.info = Widget.InfoCard(this, {size.x/2 - 0.34, size.y/2 - 0.8})

            this:AddView(ScreenGame.player)
            this:AddView(ScreenGame.map, -1)
            ScreenGame.info:AddToScreen(this)

            -- 注册按键
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
            
            SceneManager:Init()
        end))

        -- 物体接触开始
        ScreenGame.scr:lua_PhyContactBegin(wrap(function(this, a, b)
            SceneManager:PhyContactBegin(this, a, b)
        end))

        -- 物体接触结束
        ScreenGame.scr:lua_PhyContactEnd(wrap(function(this, a, b)
            SceneManager:PhyContactEnd(this, a, b)
        end))
    end,
    
    Refresh = function()
        scr = ScreenGame.scr
        scr:AddView(ScreenGame.map)
        scr:AddView(ScreenGame.player)
        ScreenGame.info:AddToScreen(scr)
    end,

}
