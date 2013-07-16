
-- ���ִ�

local function OnInit(self, scr)

    local views = self.viewlist
    views.bg = flux.View(scr)
    views.bg:SetSize(theWorld:GetSize()):SetHUD(true)
    Sound:Load(Sound.BGM.JinZhao)

end

local function OnLoad(self, scr)

    -- �����
    theWorld:DelayRun(wrap(function()
        scr:SetPlayer(SceneManager.player)
        SceneManager.player:Reset()
        theSound:SetBGM(Sound.BGM.JinZhao.id)
        ShowText(0, {
            {'��Ŀ��', '�װ�������ǣ������ǿ�����λ���ʱ��֤�����ǳɹ��Ľ�������Ϸ�������ǡ����磺ð��֮�á����̰汾r3'},
            {'��Ŀ��', '���Ǿ���ʹ�ò��Ϸ������̰汾��Ȼ���������ķ�ʽ��������Ϸ������'},
            {'��Ŀ��', '��ˣ����ǻῴ��һЩ�ܴ�Ķ�����������Ϸ���棬���ؽ黳��'},
            {'��Ŀ��', '���ɸ��汾�Ժ������Ի���ʧ��'},
            {'��Ŀ��', '����Ϸ����һ�����׵����飬��Ҫ���õ�ʱ��ʹ����ľ������Լ��ز����ٵ�����Э����'},
            {'��Ŀ��', '�����һ��������ʱ�䡣���ǻ��������ǵ�����ͽ��飬Ҳ���½�ȴ������ǻ�߾����ܡ�'},
            '��Ϸ�д浵���ܣ���Ŀǰֻ������Ϸ�رյ�ʱ���Զ����档',
            '==================',
            '��ת����������ǰ���������ʵ���ˮ�ӡ�',
            '��ˮ���������˶�������',
            '�����Ӱ���򣬹�ȥ����������������ĵط���',
            '������֮ǰ��ʧȥ��ʶ���ұ�С��ľ�����𣬶�������֮���ҷ����Լ�ʧȥ�˼��䡣',
            '����Ҹе������Ա�Ļ̻���������ʶ���ˣ����ˡ��������������֮�⣬���Ѿ�һ�����С�',
            '������ǰ�ĺ�ˮ����������ֺ���������԰С��֮��һ�����룬�����ҵĹ��������ڵ���һ�����ϡ�',
            '�ұ������������ˡ�',
            '��ţ���ʱ��̤���ó��˰ɡ�',
        }, nil, nil, function()
            SceneManager:Load('newbie_a3', 20, -11.5)
        end)
    end), 1)

end

local function KeyInput(self, scr, key, state)

    local views = self.viewlist

end

local function PhyContactBegin(self, scr, a, b)

end

local function PhyContactEnd(self, scr, a, b)
    
end

Scene('newbie_start', '��ʼ����', OnInit, OnLoad, KeyInput, PhyContactBegin, PhyContactEnd)
