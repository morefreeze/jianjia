
-- 新手村

local story

local function OnInit(self, scr)

    Sound:Load(Sound.BGM.Newbie)

    local views = self.viewlist

    -- 创建边界
    self:CreateEdge()

    -- 中间的树

    views.b1 = flux.View(scr)
    views.b1:SetSize(3,5.2):SetColor(1,0,0):SetPosition(22, -2):SetPhy(flux.b2_staticBody):PhyNewFixture()

    -- 下方河流
    views.b2 = flux.View(scr)
    views.b2:SetSize(26,1):SetColor(1,0,0):SetPosition(-20, -18):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b3 = flux.View(scr)
    views.b3:SetSize(34,1):SetColor(1,0,0):SetPosition(16, -18):SetPhy(flux.b2_staticBody):PhyNewFixture()
    
    views.b4 = flux.View(scr)
    views.b4:SetSize(26,1):SetColor(1,0,0):SetPosition(-20, -22):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b5 = flux.View(scr)
    views.b5:SetSize(34,1):SetColor(1,0,0):SetPosition(16, -22):SetPhy(flux.b2_staticBody):PhyNewFixture()
    
    views.b6 = flux.View(scr)
    views.b6:SetSize(1,4):SetColor(1,0,0):SetPosition(-7.4, -20):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b7 = flux.View(scr)
    views.b7:SetSize(1,4):SetColor(1,0,0):SetPosition(-0.6, -20):SetPhy(flux.b2_staticBody):PhyNewFixture()
    
    views.b8 = flux.View(scr)
    views.b8:SetSize(3,3):SetColor(1,0,0):SetPosition(24, -14.6):SetPhy(flux.b2_staticBody):PhyNewFixture()
    
    -- 右上
    views.b9 = flux.View(scr)
    views.b9:SetSize(1,9):SetColor(1,0,0):SetPosition(24.5, 19):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b10 = flux.View(scr)
    views.b10:SetSize(3,3):SetColor(1,0,0):SetPosition(26, 11):SetPhy(flux.b2_staticBody):PhyNewFixture()
    
    views.b11 = flux.View(scr)
    views.b11:SetSize(7,3):SetColor(1,0,0):SetPosition(30, 7):SetPhy(flux.b2_staticBody):PhyNewFixture()
    
    -- 左侧
    views.b12 = flux.View(scr)
    views.b12:SetSize(2,8):SetColor(1,0,0):SetPosition(-14, -14):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b13 = flux.View(scr)
    views.b13:SetSize(2,11):SetColor(1,0,0):SetPosition(-11, -5):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b14 = flux.View(scr)
    views.b14:SetSize(1,21):SetColor(1,0,0):SetPosition(-3, 2):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b15 = flux.View(scr)
    views.b15:SetSize(7,1):SetColor(1,0,0):SetPosition(-6.7, -8):SetPhy(flux.b2_staticBody):PhyNewFixture()

    -- 酒馆
    views.b16 = flux.View(scr)
    views.b16:SetSize(7,1):SetColor(1,0,0):SetPosition(-1, 15.3):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b17 = flux.View(scr)
    views.b17:SetSize(1,4):SetColor(1,0,0):SetPosition(5.5, 22.5):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b18 = flux.View(scr)
    views.b18:SetSize(1,5):SetColor(1,0,0):SetPosition(7, 18.5):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b19 = flux.View(scr)
    views.b19:SetSize(1,6):SetColor(1,0,0):SetPosition(8.5, 16):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b20 = flux.View(scr)
    views.b20:SetSize(3,1):SetColor(1,0,0):SetPosition(6, 15):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b21 = flux.View(scr)
    views.b21:SetSize(1,1):SetColor(1,0,0):SetPosition(7.5, 13.5):SetPhy(flux.b2_staticBody):PhyNewFixture()
    
    for k,v in pairs(views) do
        if string.find(k,'^b%d+$') then
            v:SetAlpha(0)
        end
    end

    -- 人物
    views.dummy = flux.View()
    views.dummy:SetSize(4, 3.4):SetSprite('Resources/Images/ch/dummy.png'):SetPosition(12, 5):SetRotation(0):SetLight():SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.v = flux.View()
    views.v:SetSize(2.84, 2.58):SetSprite("Resources/Images/ch/V.png"):SetPosition(0, 13.5):SetRotation(0):SetLight():SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.head = flux.View()
    views.head:SetSize(2,2.67):SetSprite('Resources/Images/ch/cz_2.png'):SetPosition(5, -13):SetLight():SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.head_t = flux.View()
    views.head_t:SetSize(3,3):SetColor(1,0,0,0):SetPosition(5, -13):SetPhy(flux.b2_staticBody):PhyNewFixture(101, true)

    if not data.story[self.mapname] then
        data.story[self.mapname] = {}
    end
    story = data.story[self.mapname]
end

local function OnLoad(self, scr)
    
    local views = self.viewlist
    
    SceneManager.map:Load('Resources/Maps/newbie2.tmx'):SetAlpha(1)
    theSound:SetBGM(Sound.BGM.Newbie.id)
    --theSound:SetBGM(0)
    self:ResetEdge()
    
    if story._cz2 then
        views.head:SetSprite('Resources/Images/ch/cz_1.png')
    end

    theWorld:DelayRun(wrap(function()
        scr:SetPlayer(SceneManager.player)
        SceneManager.player:Reset()
    end), 1)
    
end

local function KeyInput(self, scr, key, state)

    local views = self.viewlist
    
    if state == flux.GLFW_PRESS then
        if key == _b'Z' or key == flux.GLFW_KEY_SPACE then
            if SceneManager.player:CheckFacing(views.dummy) then
                print('进入战斗！')
                ShowFight(enemy_set.newbie)
            elseif SceneManager.player:CheckFacing(views.v) then
                RandomShowText('v', {0, {{'吟游诗人 艺术宅', '若漫长的寒冬还不足以冰封这热情，我必拥着百花来与你相逢 ~ ……咳咳，没错我就是传说中的吟游诗人，要签名吗？'}}},  {0, {{'吟游诗人 艺术宅', '什么？你说我是死宅？少年，你难道没有听说过思想可以比双脚行走的更加遥远。'}}}, {0, {{'吟游诗人 艺术宅', '我正计划向村长提议重新修整足球场，不能见到我在球场上的英姿简直是人类的损失。'}}}, {0, {{'吟游诗人 艺术宅', '苍茫的天涯是我的爱 ~ 绵绵的青山脚下花正开 ~ 什么样的节奏是最呀最摇摆 ~ 什么样的歌声才是最开怀 ~ '}}})
            elseif SceneManager.player:CheckFacing(views.head) then
                RandomShowText('cz', {0, {{'村长', '早睡早起，方能养生。'}}},  {0, {{'村长', '小子，往那边站一点，没看见我在晒太阳吗。'}}}, {0, {{'村长', '你知道“骷髅心脏”戏剧团下次来的日子吗，上次的‘额外演出’真是让人回味无穷……'}}})
            end
        end
    end

end

local function PhyContactBegin(self, scr, a, b)
    local views = self.viewlist
    -- 上边界
    if a.index == 3 and b.index == 10001 then
        
    -- 左边界
    elseif a.index == 3 and b.index == 10002 then
    -- 右边界
    elseif a.index == 3 and b.index == 10003 then
        SceneManager:Load('newbie_a3', -28, SceneManager.player:GetPosition().y)
    -- 下边界
    elseif a.index == 3 and b.index == 10004 then
        SceneManager:Load('forest_outside_1', 8, 23)
    end
    
    if a.index == 3 and b.index == 101 then
        if not story._cz then
            ShowText(0, {
                {npc.cz.name, '哟，少年，你是来找我的吗？'},
                {data.ch[1]:GetAttr('name'), '是的。我打算再过几天就离开这里。'},
                {npc.cz.name, '哦？'},
                {data.ch[1]:GetAttr('name'), '这段日子以来承蒙照顾，我很高兴认识这个村子的每一个人。但是为了找回失去的东西，我不得不离开这里。'},
                {npc.cz.name, '你打算去哪里呢？'},
                {data.ch[1]:GetAttr('name'), '先去丛林之外的甜水镇吧……或许我会走遍整个大陆。'},
                {npc.cz.name, '那么，年轻的冒险者。在你开始你的旅途之前，是否愿意帮我做一件小小的事情呢？'},
                {data.ch[1]:GetAttr('name'), '当然，愿意效劳。'},
                {npc.cz.name, '你过桥之后，去丛林的最西侧帮我拿回我的拐杖。我一定是把他落在那棵大树后面了。'},
                {data.ch[1]:GetAttr('name'), '好的，我这就动身。'},
            })        
            story._cz = true
        else
            if Items:HasItem(7) then
                ShowText(0, {
                    {npc.cz.name, '回来了？动作挺快嘛。'},
                    {data.ch[1]:GetAttr('name'), '嗯。是这个东西吗？我把它取回来了。'},
                    {npc.cz.name, '没错。嗯……既然要走了，找时间跟村子里的人告别一下吧。'},
                    {data.ch[1]:GetAttr('name'), '嗯。'},
                })
                Items:LostItem(7)
                views.head:SetSprite('Resources/Images/ch/cz_1.png')
                story._cz2 = true
            end
        end
    end
end

local function PhyContactEnd(self, scr, a, b)
    
end

Scene('newbie_a2', '影帆镇', OnInit, OnLoad, KeyInput, PhyContactBegin, PhyContactEnd)
