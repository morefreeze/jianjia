
-- 新手村

local function OnInit(self, scr)

    local views = self.viewlist

    -- 创建边界
    self:CreateEdge()

    views.b1 = flux.View(scr)
    views.b1:SetSize(12,1):SetColor(1,0,0):SetPosition(18, -2):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b2 = flux.View(scr)
    views.b2:SetSize(16,1):SetColor(1,0,0):SetPosition(4, -4):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b3 = flux.View(scr)
    views.b3:SetSize(58,1):SetColor(1,0,0):SetPosition(0, -23.7):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b4 = flux.View(scr)
    views.b4:SetSize(26,1):SetColor(1,0,0):SetPosition(-20, 6):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b5 = flux.View(scr)
    views.b5:SetSize(1,8):SetColor(1,0,0):SetPosition(-5, 3):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b6 = flux.View(scr)
    views.b6:SetSize(10,1):SetColor(1,0,0):SetPosition(-28, -18):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b7 = flux.View(scr)
    views.b7:SetSize(1,4):SetColor(1,0,0):SetPosition(-23, -21):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b8 = flux.View(scr)
    views.b8:SetSize(1,6.5):SetColor(1,0,0):SetPosition(25, -8):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b9 = flux.View(scr)
    views.b9:SetSize(1,4):SetColor(1,0,0):SetPosition(25, -17):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b10 = flux.View(scr)
    views.b10:SetSize(1,1):SetColor(1,0,0):SetPosition(27, -20):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b11 = flux.View(scr)
    views.b11:SetSize(1,1):SetColor(1,0,0):SetPosition(29, -22):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b12 = flux.View(scr)
    views.b12:SetSize(1,4):SetColor(1,0,0):SetPosition(27, -13):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b13 = flux.View(scr)
    views.b13:SetSize(8,4):SetColor(1,0,0):SetPosition(0, -13):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b14 = flux.View(scr)
    views.b14:SetSize(5,1):SetColor(1,0,0):SetPosition(0, -10.2):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b15 = flux.View(scr)
    views.b15:SetSize(4,1):SetColor(1,0,0):SetPosition(0, -16):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b16 = flux.View(scr)
    views.b16:SetSize(3,5.2):SetColor(1,0,0):SetPosition(14, -16):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b17 = flux.View(scr)
    views.b17:SetSize(7,4):SetColor(1,0,0):SetPosition(-12, -5):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b18 = flux.View(scr)
    views.b18:SetSize(1,13):SetColor(1,0,0):SetPosition(-7, -4):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b19 = flux.View(scr)
    views.b19:SetSize(1,13):SetColor(1,0,0):SetPosition(-21, -4):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b20 = flux.View(scr)
    views.b20:SetSize(13,1):SetColor(1,0,0):SetPosition(-14, 2):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b21 = flux.View(scr)
    views.b21:SetSize(6,1):SetColor(1,0,0):SetPosition(-18, -10):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b22 = flux.View(scr)
    views.b22:SetSize(4,1):SetColor(1,0,0):SetPosition(-16, -20):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b23 = flux.View(scr)
    views.b23:SetSize(6,1):SetColor(1,0,0):SetPosition(-15, -21.8):SetPhy(flux.b2_staticBody):PhyNewFixture()
    
    for k,v in pairs(views) do
        if string.find(k,'^b%d+$') then
            v:SetAlpha(0)
        end
    end

    views.boss = flux.TextView(scr, nil, 'wqy', '')
    views.boss:SetTextColor(1,1,1):SetSize(1.079, 1.245):SetPosition(3, 12.5):SetSprite('Resources/Images/fight.jpg'):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.head = flux.TextView(scr, nil, 'wqy', '村长')
    views.head:SetTextColor(1,1,1):SetSize(2,2):SetColor(0,0,0):SetPosition(5, -13):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.pcmiao = flux.TextView(scr, nil, 'wqy', 'PC喵')
    views.pcmiao:SetTextColor(1,1,1):SetSize(2,2):SetColor(0,0,0):SetPosition(-13, -9):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.uu = flux.TextView(scr, nil, 'wqy', 'UU')
    views.uu:SetTextColor(1,1,1):SetSize(2,2):SetColor(0,0,0):SetPosition(25.2, -13):SetPhy(flux.b2_staticBody):PhyNewFixture()

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
                {'项目组', '若干个版本以后，他们自会消失。'},
                {'项目组', '做游戏不是一件容易的事情，需要长久的时间和大量的精力，以及必不可少的齐心协力。'},
                {'项目组', '这会是一段漫长的时间。我们会聆听你们的意见和建议，也请谅解等待。我们会竭尽所能。'},
                '游戏有存档功能，但目前只会在游戏关闭的时候自动保存。',
                '首先，请选择人物的行为倾向。'
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
            elseif SceneManager.player:CheckFacing(views.pcmiao) then
                RandomShowText({0, {{'PC喵', '喵！来抱抱！'}}},  {0, {{'PC喵', '打滚……有点困……'}}}, {0, {{'PC喵', '今天天气好好的呀，来发个呆吧嗯！'}}})
            elseif SceneManager.player:CheckFacing(views.uu) then
                RandomShowText({0, {{'码头钓鱼者 UU', '哎，这里鱼都被我钓光了，怎么我的翅膀就不上钩了呢？'}}},  {0, {{'码头钓鱼者 UU', '最近村里的猪肉好吃么？都是我从河里钓上来的耶！'}}}, {0, {{'码头钓鱼者 UU', '哼，经过我的努力，我终于在河里钓上猪了，只要努力我坚信水坑也可以钓回我的翅膀！！'}}}, {0, {{'码头钓鱼者 UU', '你知道为什么那么多人为one piece疯狂么？我前几年就钓到了，嘘~~~小声点。'}}}, {0, {{'码头钓鱼者 UU', '你见过传说中的one piece么？如果你能帮我找回双翼，我会把它送给你的。'}}})
            elseif SceneManager.player:CheckFacing(views.head) then
                RandomShowText({0, {{'村长', '早睡早起，方能养生。'}}},  {0, {{'村长', '小子，往那边站一点，没看见我在晒太阳吗。'}}}, {0, {{'村长', '你知道“骷髅心脏”戏剧团下次来的日子吗，上次的‘额外演出’真是让人回味无穷……'}}})
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

SceneManager.scene.newbie_a3 = Scene({'影帆镇 - 3', '一座平凡的小镇'}, OnInit, OnLoad, KeyInput, PhyContactBegin, PhyContactEnd)
