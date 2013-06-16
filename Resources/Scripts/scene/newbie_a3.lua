
-- ���ִ�

local function OnInit(self, scr)
    
    Sound:Load(Sound.BGM.Newbie1)

    local views = self.viewlist

    -- �����߽�
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

    views.head = flux.TextView(scr, nil, 'wqy', '�峤')
    views.head:SetTextColor(1,1,1):SetSize(2,2):SetColor(0,0,0):SetPosition(5, -13):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.pcmiao = flux.View(scr)
    views.pcmiao:SetSize(2.2,2.772):SetPosition(-13, -9):SetPhy(flux.b2_staticBody):PhyNewFixture()
    --views.pcmiao:SetSprite("Resources/Images/ch/QPC01.png")
    views.pcmiao:SetSpriteFrame("Resources/Images/ch/QPC01.png", 1)
    views.pcmiao:SetSpriteFrame("Resources/Images/ch/QPC02.png", 2)

    views.uu = flux.TextView(scr, nil, 'wqy', 'UU')
    views.uu:SetTextColor(1,1,1):SetSize(2,2):SetColor(0,0,0):SetPosition(25.2, -13):SetPhy(flux.b2_staticBody):PhyNewFixture()

    --views.red = flux.TextView(scr, nil, 'wqy', '����')
    --views.red:SetTextColor(1,1,1):SetSize(7,7):SetColor(0,0,0):SetPosition(5, 0):SetPhy(flux.b2_staticBody)

end

local function OnLoad(self, scr)
    SceneManager.map:SetColor(0.486, 0.80, 0.486)
    SceneManager.map:Load('Resources/Maps/newbie3.tmx'):SetAlpha(1)
    theSound:SetBGM(Sound.BGM.Newbie1.id)
    self:ResetEdge()
    
    local views = self.viewlist
    views.pcmiao:PlayFrame(1, 1, 2):Loop()

    -- �������
    theWorld:DelayRun(wrap(function()
        scr:SetPlayer(SceneManager.player)
        SceneManager.player:Reset()
    end), 1)
    
end

local function KeyInput(self, scr, key, state)

    local views = self.viewlist
    
    if state == flux.GLFW_PRESS then
        if key == _b'Z' or key == flux.GLFW_KEY_SPACE then
            if SceneManager.player:CheckFacing(views.boss, 0.5) then
                ShowText(0, {{"����С���������","�����ߣ���ʲô��˵��ô��",2,1,102,{'����ȱ��ԭ������','ԭ���������������'},callback},{"���ص���",{"��֧1�Ľ��","��֧2�Ľ��"},1,2,101,{'��֧3','��֧4'}},{"Yu","b",2,1,101,{"ffdsaf1","fdafdsa2"}},{"���ص���","c",1,2,102},{"Yu","d",2,1,102},"һ�����������߰�"},{"Resources/Images/SCA07.png","Resources/Images/hero.png"})
            elseif SceneManager.player:CheckFacing(views.pcmiao) then
                RandomShowText({0, {{'PC��', '������������'}}},  {0, {{'PC��', '��������е�������'}}}, {0, {{'PC��', '���������úõ�ѽ�������������ţ�'}}})
            elseif SceneManager.player:CheckFacing(views.uu) then
                RandomShowText({0, {{'��ͷ������ UU', '���������㶼���ҵ����ˣ���ô�ҵĳ��Ͳ��Ϲ����أ�'}}},  {0, {{'��ͷ������ UU', '������������ó�ô�������ҴӺ����������Ү��'}}}, {0, {{'��ͷ������ UU', '�ߣ������ҵ�Ŭ�����������ں���������ˣ�ֻҪŬ���Ҽ���ˮ��Ҳ���Ե����ҵĳ�򣡣�'}}}, {0, {{'��ͷ������ UU', '��֪��Ϊʲô��ô����Ϊone piece���ô����ǰ����͵����ˣ���~~~С���㡣'}}}, {0, {{'��ͷ������ UU', '�������˵�е�one pieceô��������ܰ����һ�˫���һ�����͸���ġ�'}}})
            elseif SceneManager.player:CheckFacing(views.head) then
                RandomShowText({0, {{'�峤', '��˯���𣬷���������'}}},  {0, {{'�峤', 'С�ӣ����Ǳ�վһ�㣬û��������ɹ̫����'}}}, {0, {{'�峤', '��֪�����������ࡱϷ�����´������������ϴεġ������ݳ����������˻�ζ�����'}}})
            end
        end
    end

end

local function PhyContactBegin(self, scr, a, b)
    -- �ϱ߽�
    if a.index == 3 and b.index == 10001 then

    -- ��߽�
    elseif a.index == 3 and b.index == 10002 then
        SceneManager:Load('newbie_a2', 30, SceneManager.player:GetPosition().y)
    -- �±߽�
    elseif a.index == 3 and b.index == 10003 then
    -- �ұ߽�
    elseif a.index == 3 and b.index == 10004 then
    end
end

local function PhyContactEnd(self, scr, a, b)
    
end

SceneManager.scene.newbie_a3 = Scene({'Ӱ���� - 3', 'һ��ƽ����С��'}, OnInit, OnLoad, KeyInput, PhyContactBegin, PhyContactEnd)
