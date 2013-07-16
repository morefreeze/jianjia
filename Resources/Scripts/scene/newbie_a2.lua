
-- ���ִ�

local story

local function OnInit(self, scr)

    Sound:Load(Sound.BGM.Newbie)

    local views = self.viewlist

    -- �����߽�
    self:CreateEdge()

    -- �м����

    views.b1 = flux.View(scr)
    views.b1:SetSize(3,5.2):SetColor(1,0,0):SetPosition(22, -2):SetPhy(flux.b2_staticBody):PhyNewFixture()

    -- �·�����
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
    
    -- ����
    views.b9 = flux.View(scr)
    views.b9:SetSize(1,9):SetColor(1,0,0):SetPosition(24.5, 19):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b10 = flux.View(scr)
    views.b10:SetSize(3,3):SetColor(1,0,0):SetPosition(26, 11):SetPhy(flux.b2_staticBody):PhyNewFixture()
    
    views.b11 = flux.View(scr)
    views.b11:SetSize(7,3):SetColor(1,0,0):SetPosition(30, 7):SetPhy(flux.b2_staticBody):PhyNewFixture()
    
    -- ���
    views.b12 = flux.View(scr)
    views.b12:SetSize(2,8):SetColor(1,0,0):SetPosition(-14, -14):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b13 = flux.View(scr)
    views.b13:SetSize(2,11):SetColor(1,0,0):SetPosition(-11, -5):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b14 = flux.View(scr)
    views.b14:SetSize(1,21):SetColor(1,0,0):SetPosition(-3, 2):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b15 = flux.View(scr)
    views.b15:SetSize(7,1):SetColor(1,0,0):SetPosition(-6.7, -8):SetPhy(flux.b2_staticBody):PhyNewFixture()

    -- �ƹ�
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

    -- ����
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
                print('����ս����')
                ShowFight(enemy_set.newbie)
            elseif SceneManager.player:CheckFacing(views.v) then
                RandomShowText('v', {0, {{'����ʫ�� ����լ', '�������ĺ����������Ա��������飬�ұ�ӵ�Űٻ���������� ~ �����ȿȣ�û���Ҿ��Ǵ�˵�е�����ʫ�ˣ�Ҫǩ����'}}},  {0, {{'����ʫ�� ����լ', 'ʲô����˵������լ�����꣬���ѵ�û����˵��˼����Ա�˫�����ߵĸ���ңԶ��'}}}, {0, {{'����ʫ�� ����լ', '�����ƻ���峤���������������򳡣����ܼ����������ϵ�Ӣ�˼�ֱ���������ʧ��'}}}, {0, {{'����ʫ�� ����լ', '��ã���������ҵİ� ~ �������ɽ���»����� ~ ʲô���Ľ�������ѽ��ҡ�� ~ ʲô���ĸ���������� ~ '}}})
            elseif SceneManager.player:CheckFacing(views.head) then
                RandomShowText('cz', {0, {{'�峤', '��˯���𣬷���������'}}},  {0, {{'�峤', 'С�ӣ����Ǳ�վһ�㣬û��������ɹ̫����'}}}, {0, {{'�峤', '��֪�����������ࡱϷ�����´������������ϴεġ������ݳ����������˻�ζ�����'}}})
            end
        end
    end

end

local function PhyContactBegin(self, scr, a, b)
    local views = self.viewlist
    -- �ϱ߽�
    if a.index == 3 and b.index == 10001 then
        
    -- ��߽�
    elseif a.index == 3 and b.index == 10002 then
    -- �ұ߽�
    elseif a.index == 3 and b.index == 10003 then
        SceneManager:Load('newbie_a3', -28, SceneManager.player:GetPosition().y)
    -- �±߽�
    elseif a.index == 3 and b.index == 10004 then
        SceneManager:Load('forest_outside_1', 8, 23)
    end
    
    if a.index == 3 and b.index == 101 then
        if not story._cz then
            ShowText(0, {
                {npc.cz.name, 'Ӵ�����꣬���������ҵ���'},
                {data.ch[1]:GetAttr('name'), '�ǵġ��Ҵ����ٹ�������뿪���'},
                {npc.cz.name, 'Ŷ��'},
                {data.ch[1]:GetAttr('name'), '����������������չˣ��Һܸ�����ʶ������ӵ�ÿһ���ˡ�����Ϊ���һ�ʧȥ�Ķ������Ҳ��ò��뿪���'},
                {npc.cz.name, '�����ȥ�����أ�'},
                {data.ch[1]:GetAttr('name'), '��ȥ����֮�����ˮ��ɡ��������һ��߱�������½��'},
                {npc.cz.name, '��ô�������ð���ߡ����㿪ʼ�����;֮ǰ���Ƿ�Ը�������һ��СС�������أ�'},
                {data.ch[1]:GetAttr('name'), '��Ȼ��Ը��Ч�͡�'},
                {npc.cz.name, '�����֮��ȥ���ֵ�����������û��ҵĹ��ȡ���һ���ǰ��������ǿô��������ˡ�'},
                {data.ch[1]:GetAttr('name'), '�õģ�����Ͷ���'},
            })        
            story._cz = true
        else
            if Items:HasItem(7) then
                ShowText(0, {
                    {npc.cz.name, '�����ˣ�����ͦ���'},
                    {data.ch[1]:GetAttr('name'), '�š�������������Ұ���ȡ�����ˡ�'},
                    {npc.cz.name, 'û���š�����ȻҪ���ˣ���ʱ�����������˸��һ�°ɡ�'},
                    {data.ch[1]:GetAttr('name'), '�š�'},
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

Scene('newbie_a2', 'Ӱ����', OnInit, OnLoad, KeyInput, PhyContactBegin, PhyContactEnd)
