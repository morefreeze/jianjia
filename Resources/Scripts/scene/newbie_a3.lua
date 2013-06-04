
-- 新手村

local function OnInit(self, scr)

    local views = self.viewlist

    -- 创建边界
    self:CreateEdge()

    views.boss = flux.TextView(scr, nil, 'wqy', '')
    views.boss:SetTextColor(1,1,1):SetSize(1.079, 1.245):SetPosition(3, 12.5):SetSprite('Resources/Images/fight.jpg'):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.head = flux.TextView(scr, nil, 'wqy', '村长')
    views.head:SetTextColor(1,1,1):SetSize(3,3):SetColor(0,0,0):SetPosition(-20, 0):SetPhy(flux.b2_staticBody):PhyNewFixture()

    --views.red = flux.TextView(scr, nil, 'wqy', '测试')
    --views.red:SetTextColor(1,1,1):SetSize(7,7):SetColor(0,0,0):SetPosition(5, 0):SetPhy(flux.b2_staticBody)

end

local function OnLoad(self, scr)
    SceneManager.map:SetColor(0.486, 0.80, 0.486)
    SceneManager.map:Load('Resources/Maps/newbie3.tmx'):SetAlpha(1)
    self:ResetEdge()

    if data.player.alignment == 0 then
        -- 新玩家
        theWorld:DelayRun(wrap(function()
            scr:SetPlayer(SceneManager.player)
            SceneManager.player:Reset()
            ShowText(101, {
                {'项目组', '亲爱的玩家们，当你们看到这段话的时候，证明你们成功的进入了游戏。这里是《蒹葭：冒险之旅》工程版本r1'},
                {'项目组', '我们决定使用不断发布工程版本，然后向后迭代的方式来进行游戏开发。'},
                {'项目组', '因此，你们会看到一些很挫的东西出现在游戏里面，不必介怀。'},
                {'项目组', '因为若干个版本以后，他们会消失的。'},
                '',
                '空格键和Z键都是确认键，与人物对话时要走进按两者之一才行。',
                '另外B键可以查看背包', '由于是工程版本，所以这段话会在每次进入这个场景时出现，请谅解。',
                '请选择人物的行为倾向。'
            })
        end), 2)
    else
        -- 非新玩家
        theWorld:DelayRun(wrap(function()
            scr:SetPlayer(SceneManager.player)
            SceneManager.player:Reset()
        end), 1)
    end
    
end

local function KeyInput(self, scr, key, state)

    local views = self.viewlist
    
    if state == flux.GLFW_PRESS then
        if key == _b'Z' or key == flux.GLFW_KEY_SPACE then
            if SceneManager.player:CheckFacing(views.boss, 0.5) then
                ShowText(0, {{"紧握小黄书的男人","旅行者，有什么想说的么？",2,1,102,{'我们缺少原画！！','原画大神求带！！！'},callback},{"神秘的人",{"分支1的结果","分支2的结果"},1,2,101,{'分支3','分支4'}},{"Yu","b",2,1,101,{"ffdsaf1","fdafdsa2"}},{"神秘的人","c",1,2,102},{"Yu","d",2,1,102},"一二三四五六七八"},{"Resources/Images/SCA07.png","Resources/Images/hero.png"})
            elseif SceneManager.player:CheckFacing(views.head) then
                RandomShowText({0, {{'村长', '敲碗，无聊，敲碗，无聊，敲碗，无聊……'}}},  {0, {{'村长', '多少年来方圆百里的妇联主席都是我呀~'}}}, {0, {{'村长', '其实我只有一百一十八岁的，啊不，或者是十八岁比较年轻一点？'}}})
            end
        end
    end

end

local function PhyContactBegin(self, scr, a, b)
    -- 上边界
    if a.index == 3 and b.index == 10001 then
        
    -- 左边界
    elseif a.index == 3 and b.index == 10002 then
        SceneManager:Load('newbie_a2', 30, SceneManager.player:GetPosition().y)
    -- 下边界
    elseif a.index == 3 and b.index == 10003 then
    -- 右边界
    elseif a.index == 3 and b.index == 10004 then
    end
end

local function PhyContactEnd(self, scr, a, b)
    
end

SceneManager.scene.newbie_a3 = Scene(OnInit, OnLoad, KeyInput, PhyContactBegin, PhyContactEnd)
