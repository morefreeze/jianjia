
-- 新手村

local story

local function OnInit(self, scr)
    
    Sound:Load(Sound.BGM.Newbie)

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
    
    self.scr = scr
    self:LoadNPC()

    --views.pcmiao_hi = flux.View(scr)
    --views.pcmiao_hi:SetSize(2,8):SetPosition(-13, -15):SetColor(1,0,0,0):SetPhy(flux.b2_staticBody):PhyNewFixture(101, true)

    --views.bbz = flux.View(scr)
    --views.bbz:SetSize(2.18,2.29):SetPosition(-10, -15):SetPhy(flux.b2_staticBody):PhyNewFixture()
    --views.bbz:SetSprite("Resources/Images/ch/bbz.png")

    if not data.story[self.mapname] then
        data.story[self.mapname] = {}
    end
    story = data.story[self.mapname]
end

local function OnLoad(self, scr)
    SceneManager.map:SetColor(0.486, 0.80, 0.486)
    SceneManager.map:Load('Resources/Maps/newbie3.tmx'):SetAlpha(1)
    theSound:SetBGM(Sound.BGM.Newbie.id)
    --theSound:SetBGM(0)
    self:ResetEdge()
    
    local views = self.viewlist
    views.pcmiao:PlayFrame(1, 0, 1):Loop()
    views.uu:PlayFrame(0.8, 0, 1):PlayFrame(0.8, 0, 1):PlayFrame(0.8, 2, 1):Loop()

    theWorld:DelayRun(wrap(function()
        scr:SetPlayer(SceneManager.player)
        SceneManager.player:Reset()
        if not story['1'] then
            ShowText(0, {
                {data.ch[1]:GetAttr('name'), '看样子，今天是个好天气。'},
                {data.ch[1]:GetAttr('name'), '东西收拾得差不多了，身体也养好了。离开这里大概就是这一两天的事情了。'},
                {data.ch[1]:GetAttr('name'), '既然打算走了，我应该去和村长打个招呼。'},
            })
            story['1'] = true
        end
    end), 1)
    
end

local function KeyInput(self, scr, key, state)

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
    
    -- PC的触发对话
    if a.index == 3 and b.index == 101 then
        if not story._pc then
            ShowText(0, {
                {npc.pc.name, '上午好呀，异乡人。'},
                {data.ch[1]:GetAttr('name'), '咦？上午好，' .. npc.pc.name .. '。'},
                '（这个猫耳小姑娘是我在村子里比较熟悉的人之一，之前受伤的时候时常来照顾我。）',
                '（一来二去，我们也就认识了。）',
                '（总而言之，是个心地善良的好人。）',
                {npc.pc.name, '嗯，你要去哪里呀？'},
                {data.ch[1]:GetAttr('name'), '我计划再过一段时间就离开村子，先去和村长说一声。'},
                {npc.pc.name, '这样呀……'},
                {npc.pc.name, '村长这个时候应该就在桥边晒太阳，你过去就可以看到他了。'},
                {data.ch[1]:GetAttr('name'), '嗯，谢谢你。'},
                '（我移开了视线，' .. npc.pc.name .. '则歪了歪脑袋，露出有点困惑的神情。不管怎么说，先去找到村长吧。）',
            })
            story._pc = true        
        end
    end
end

local function PhyContactEnd(self, scr, a, b)
   ;
end

Scene('newbie_a3', '影帆镇', OnInit, OnLoad, KeyInput, PhyContactBegin, PhyContactEnd)
