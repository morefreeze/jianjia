
-- ���ִ�

local function OnInit(self, scr)

    local views = self.viewlist

    -- �����߽�
    self:CreateEdge()

    views.boss = flux.TextView(scr, nil, 'wqy', '')
    views.boss:SetTextColor(1,1,1):SetSize(1.079, 1.245):SetPosition(3, 12.5):SetSprite('Resources/Images/fight.jpg'):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.dummy = flux.TextView(scr, nil, 'wqy', 'ľ׮')
    views.dummy:SetTextColor(1,1,1):SetSize(1.5, 1):SetColor(0,0,0):SetPosition(-2, 11):SetRotation(0):SetPhy(flux.b2_staticBody):PhyNewFixture()

    views.head = flux.TextView(scr, nil, 'wqy', '�峤')
    views.head:SetTextColor(1,1,1):SetSize(1,1):SetColor(0,0,0):SetPosition(-20, -8):SetPhy(flux.b2_staticBody):PhyNewFixture()

end

local function OnLoad(self, scr)
    SceneManager.map:Load('Resources/Maps/example.tmx'):SetAlpha(1)
    self:ResetEdge()
end

local function KeyInput(self, scr, key, state)

    local views = self.viewlist
    
    if state == flux.GLFW_PRESS then
        if key == _b'Z' or key == flux.GLFW_KEY_SPACE then
            if SceneManager.player:CheckFacing(views.boss, 0.5) then
                ShowText(0, {{"����С���������","�����ߣ���ʲô��˵��ô��",2,1,102,{'����ȱ��ԭ������','ԭ���������������'},callback},{"���ص���",{"��֧1�Ľ��","��֧2�Ľ��"},1,2,101,{'��֧3','��֧4'}},{"Yu","b",2,1,101,{"ffdsaf1","fdafdsa2"}},{"���ص���","c",1,2,102},{"Yu","d",2,1,102},"һ�����������߰�"},{"Resources/Images/SCA07.png","Resources/Images/hero.png"})
            elseif SceneManager.player:CheckFacing(views.dummy) then
                print('ľ׮��ս��ʹ��')
                ShowFight(enemy_set.newbie)
            elseif SceneManager.player:CheckFacing(views.head) then
                RandomShowText({{0, {{'�峤', '���룬���ģ����룬���ģ����룬���ġ���'}}},  {0, {{'�峤', '����������Բ����ĸ�����ϯ������ѽ~'}}}, {0, {{'�峤', '��ʵ��ֻ��һ��һʮ����ģ�������������ʮ����Ƚ�����һ�㣿'}}}})
            end
        end
    end

end

local function PhyContactBegin(self, scr, a, b)
    if a.index == 3 and b.index == 10001 then
        
    elseif a.index == 3 and b.index == 10002 then
    elseif a.index == 3 and b.index == 10003 then
    elseif a.index == 3 and b.index == 10004 then
    
    end
end

local function PhyContactEnd(self, scr, a, b)
    
end

SceneManager.scene.newbie = Scene('newbie', OnInit, OnLoad, KeyInput, PhyContactBegin, PhyContactEnd)
