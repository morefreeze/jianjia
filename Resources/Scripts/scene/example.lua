
-- example.lua
-- ʾ�������ļ�, fy
-- һ��������Ҫ�������º�����
-- OnInit �����ʼ���ؼ���ֻ����������������ڴ���ʱ�����á�
-- OnLoad ��������ʼ�趨��������ص�ͼ�����ų���ÿ�α�Load��ʱ�򶼻���� OnLoad��OnInit��OnLoad�Ĺ�ϵ����ͬScreen��OnInit��OnPush��
-- KeyInput ������Ӧ
-- PhyContactBegin ������ײ��ʼ��a��b������������������
-- PhyContactEnd ������ײ������a��b������������������

local function OnInit(self, scr)
    
end

local function OnLoad(self, scr)

end

local function KeyInput(self, scr, key, state)
    
end

local function PhyContactBegin(self, scr, a, b)
    
end

local function PhyContactEnd(self, scr, a, b)
    
end

SceneManager.scene.example = Scene('example', OnInit, OnLoad, KeyInput, PhyContactBegin, PhyContactEnd)
