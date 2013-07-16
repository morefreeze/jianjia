
-- ���ִ���Χ����

local story

local function OnInit(self, scr)

    Sound:Load(Sound.BGM.Newbie)

    local views = self.viewlist

    -- �����߽�
    self:CreateEdge()

    views.right = flux.View()
    views.right:SetPosition(34, 3):SetColor(1,0,0,0):SetSize(0.1,7)
    views.right:SetPhy(flux.b2_staticBody):PhyNewFixture(102)


    views.b1 = flux.View()
    views.b1:SetSize(1,30):SetColor(1,0,0):SetPosition(-16, -2):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b2 = flux.View()
    views.b2:SetSize(5,4):SetColor(1,0,0):SetPosition(-8, 10):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b3 = flux.View()
    views.b3:SetSize(4,4):SetColor(1,0,0):SetPosition(-12.5, 12):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b4 = flux.View()
    views.b4:SetSize(1,1):SetColor(1,0,0):SetPosition(-4, 14):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b5 = flux.View()
    views.b5:SetSize(6,4):SetColor(1,0,0):SetPosition(0, 16.5):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b6 = flux.View()
    views.b6:SetSize(6,4):SetColor(1,0,0):SetPosition(5.5, 20):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b7 = flux.View()
    views.b7:SetSize(10,1):SetColor(1,0,0):SetPosition(14, 20):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b8 = flux.View()
    views.b8:SetSize(6,3):SetColor(1,0,0):SetPosition(22, 19.5):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b9 = flux.View()
    views.b9:SetSize(7,3):SetColor(1,0,0):SetPosition(29, 21):SetPhy(flux.b2_staticBody):PhyNewFixture()

    -- �·�
    views.b10 = flux.View()
    views.b10:SetSize(23,1):SetColor(1,0,0):SetPosition(-2, -13):SetRotation(135):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b11 = flux.View()
    views.b11:SetSize(3,1):SetColor(1,0,0):SetPosition(-13.5, -4):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b12 = flux.View()
    views.b12:SetSize(6,4):SetColor(1,0,0):SetPosition(12, -18):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b13 = flux.View()
    views.b13:SetSize(3,1):SetColor(1,0,0):SetPosition(7.5, -22):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b14 = flux.View()
    views.b14:SetSize(3,3):SetColor(1,0,0):SetPosition(16, -19):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b15 = flux.View()
    views.b15:SetSize(15,1):SetColor(1,0,0):SetPosition(26, -19):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b16 = flux.View()
    views.b16:SetSize(6,6):SetColor(1,0,0):SetPosition(26, -15):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b17 = flux.View()
    views.b17:SetSize(6,6):SetColor(1,0,0):SetPosition(31, -5):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b18 = flux.View()
    views.b18:SetSize(6,6):SetColor(1,0,0):SetPosition(31, -5):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b19 = flux.View()
    views.b19:SetSize(3,3):SetColor(1,0,0):SetPosition(0, -3):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.b20 = flux.View()
    views.b20:SetSize(3,3):SetColor(1,0,0):SetPosition(6, -5):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.task1 = flux.View()
    views.task1:SetSize(2,4):SetPosition(-15, 1):SetAlpha(0):SetPhy(flux.b2_staticBody):PhyNewFixture(101, true)

    for k,v in pairs(views) do
        if string.find(k,'^b%d+$') then
            v:SetAlpha(0)
        end
    end

    if not data.story[self.mapname] then
        data.story[self.mapname] = {}
    end
    story = data.story[self.mapname]
end

local function OnLoad(self, scr)
    SceneManager.map:Load('Resources/Maps/forest_outside_3.tmx'):SetAlpha(1)
    theSound:SetBGM(0)
    self:ResetEdge()

    theWorld:DelayRun(wrap(function()
        scr:SetPlayer(SceneManager.player)
        SceneManager.player:Reset()
    end), 1)
    
end

local function KeyInput(self, scr, key, state)

    local views = self.viewlist
    
    if state == flux.GLFW_PRESS then
        if key == _b'Z' or key == flux.GLFW_KEY_SPACE then

        end
    end

end

local function PhyContactBegin(self, scr, a, b)
    -- �ϱ߽�
    if a.index == 3 and b.index == 10001 then
    -- ��߽�
    elseif a.index == 3 and b.index == 10002 then
    -- �ұ߽�
    elseif a.index == 3 and b.index == 10003 then
    -- �±߽�
    elseif a.index == 3 and b.index == 10004 then
    end

    if a.index == 3 and b.index == 101 then
        if not story.task1 then        
            ShowText(0, {
                {data.ch[1]:GetAttr('name'), '���������ٴΣ�ÿ�ζ�����׳���ء�'},
                '�޴����Ը������������Ҷ��ͬ�����Ʈ��һͬɳɳ���죬ɢ���Ų���������',
                '��̧ͷ����������һ��������յĸо���������������֮�У�ȴ�����ԵðԵ���',
                'һ��紵������ʲô����Ʈ��������',
                {data.ch[1]:GetAttr('name'), '�ף�����ǣ�'},
                '�ҿ��˿����ϵĲ�����',
                {data.ch[1]:GetAttr('name'), '����'},
                '����͵�����˵�Ը�����񲻺ðɡ�',
                '���Ǿ�����ɴ峤�����顣',
                {data.ch[1]:GetAttr('name'), '�ⶫ����û��������ô����'},
                {data.ch[1]:GetAttr('name'), '����������ͦ����ģ���������Ϊ���ԭ��'},
                {data.ch[1]:GetAttr('name'), '��ô���߰ɡ�'},
            }, nil, nil, function()
                Items:GetItem(7)
                ShowTip('�����Ʒ [����֮��]')
            end)
            story.task1 = true
        end
    elseif a.index == 3 and b.index == 102 then
        SceneManager:Load('forest_outside_2', -30, 0.35)
    end

end

local function PhyContactEnd(self, scr, a, b)
    
end

Scene('forest_outside_3', '����', OnInit, OnLoad, KeyInput, PhyContactBegin, PhyContactEnd)
