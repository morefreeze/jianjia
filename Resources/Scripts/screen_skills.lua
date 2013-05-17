--��ɫ
local Colors={
    normal=flux.Color(1,1,1),
    selection=flux.Color(1,0,0),
}
--��ʼ���ؼ�
local function InitRes(this)
    --��ʼ������
    ScreenSkills.bg = flux.View(this)
    ScreenSkills.bg:SetHUD(true)
    ScreenSkills.bg:SetSize(24, 6)
    ScreenSkills.bg:SetPosition(0, 0):SetAlpha(0.8)
    ScreenSkills.bg:SetSprite('Resources/Images/textbg.png')
    this:AddView(ScreenSkills.bg)

    ScreenSkills.skillsView = {
        flux.TextView(this,nil,'wqy'),
        flux.TextView(this,nil,'wqy'),
        flux.TextView(this,nil,'wqy'),
        flux.TextView(this,nil,'wqy'),
        flux.TextView(this,nil,'wqy'),
    }
    --ÿҳ��ʾ��������
    for i=1,5 do
        --ScreenSkillsView.skillsView[i] = flux.TextView(this,nil,'wqy'):SetAlpha(0)
        ScreenSkills.skillsView[i]:SetTextColor(Colors.normal):SetPosition(-7,3+-1*i):SetAlign(flux.ALIGN_LEFT):SetAlpha(0):SetHUD(true)--
        this:AddView(ScreenSkills.skillsView[i])
    end
    --����˵��
    ScreenSkills.instruct=flux.TextView(this,nil,'wqy')
    ScreenSkills.instruct:SetTextColor(Colors.normal):SetPosition(4,1):SetAlign(flux.ALIGN_LEFT):SetHUD(true)
    this:AddView(ScreenSkills.instruct)

    --����ѡ���
    ScreenSkills.skillsSelection=flux.View(this)
    ScreenSkills.skillsSelection:SetColor(0.7,0,1):SetAlpha(0.3):SetSize(6,1):SetPosition(-4.5,2):SetHUD(true)
    this:AddView(ScreenSkills.skillsSelection)
end
--��ȡ�ַ���
local function Split(s)
    local ts=''
    while true do
        if string.len(s)>22 then
            ts=ts..(string.sub(s,1,22))..'\n'
            s=string.sub(s,22,string.len(s))
        else
            ts = ts..s
            return ts
        end
    end
end

--��ʾ����
ScreenSkills={
    --�Ѽ��ܴ�����
    new = function(spells,callback)
        ScreenSkills.skills = spells
        ScreenSkills.skillsNums=table.length(spells)
        ScreenSkills.callback=callback
        --��ʼ��
        if ScreenSkills.scr==nil then
            ScreenSkills.scr = flux.Screen()
            ScreenSkills.scr:lua_Init(wrap(function(this)
                InitRes(this)
                -- ע�ᰴ��
                this:RegKey(_b'Z')
                this:RegKey(flux.GLFW_KEY_LEFT)
                this:RegKey(flux.GLFW_KEY_ESC)
                this:RegKey(flux.GLFW_KEY_ENTER)
                this:RegKey(flux.GLFW_KEY_SPACE)
                this:RegKey(flux.GLFW_KEY_RIGHT)
                this:RegKey(flux.GLFW_KEY_UP)
                this:RegKey(flux.GLFW_KEY_DOWN)
            end))
            ScreenSkills.scr:lua_OnPush(wrap(function(this)
                theWorld:PhyPause()
                ScreenSkills.update(ScreenSkills.curSelection,0)
            end))
            ScreenSkills.scr:lua_OnPop(wrap(function(this)
                theWorld:PhyContinue()
            end))

            --���������¼�
            ScreenSkills.scr:lua_KeyInput(wrap(function(this, key, state)
                if state == flux.GLFW_PRESS then
                    if key==flux.GLFW_KEY_UP then
                        --��
                        print("S��ѡ��")
                        if ScreenSkills.curSelection > 1 then
                            print("��ѡ��")
                            ScreenSkills.update(ScreenSkills.curSelection,-1)
                        end
                    elseif key==flux.GLFW_KEY_DOWN then
                        --��
                        if ScreenSkills.curSelection < ScreenSkills.skillsNums then
                            ScreenSkills.update(ScreenSkills.curSelection,1)
                        end
                    elseif key==flux.GLFW_KEY_ENTER then
                        --ѡ���ͷż���
                        local tk = table.find(ScreenSkills.skills,ScreenSkills.curSelection)
                        if skill.can_cast(data.ch[1],skills[tk]) then
                            print("�ͷż��ܰ�ɧ��")
                            if type(ScreenSkills.callback)=='function' then
                                ScreenSkills.callback(skills[tk])
                            end
                            theWorld:PopScreen()
                        else
                            print("�ͷ���������")
                        end
                    elseif key==flux.GLFW_KEY_ESC then
                        theWorld:PopScreen()
                    end
                end
            end))
        end
    end,
    --����
    update = function(curSelection,step)
        --ѡ��
        local nextSelection = curSelection+step
        if nextSelection >=1 and nextSelection<=ScreenSkills.skillsNums then
            if step==1 then
                --��
                if ScreenSkills.curPosition<5 then
                    ScreenSkills.curPosition=ScreenSkills.curPosition+1
                end
                ScreenSkills.curSelection=nextSelection
            elseif step==-1 then
                --��
                if ScreenSkills.curPosition>1 then
                    ScreenSkills.curPosition=ScreenSkills.curPosition-1
                end
                ScreenSkills.curSelection=nextSelection
            elseif step==0 then
                --�������
                ScreenSkills.curSelection=nextSelection
            end
        end
        ScreenSkills.skillsSelection:SetAlpha(0.3):SetPosition(-4.5,3-ScreenSkills.curPosition)
        --����˵����Ϣ
        --ScreenSkills.instruct:SetText(ScreenSkills.skills[ScreenSkills.curSelection][6]):SetAlpha(1)
        local k= table.find(ScreenSkills.skills,ScreenSkills.curSelection)
        ScreenSkills.instruct:SetText(skills[k][6]):SetAlpha(1)
        --ScreenSkills.instruct:SetText(Split(ScreenSkills.skills[ScreenSkills.curPosition][5])):SetAlpha(1)
        local m=nil
        if ScreenSkills.curPosition==1 and (step==-1 or step==0) then
            m=-1
        elseif ScreenSkills.curPosition==5 and step==1 then
            m=-5
        end
        print("����")
        --���¼����б�
        if  m then
            for k, v in pairs(ScreenSkills.skillsView) do
                --����id,�ȼ�
                local tk = table.find(ScreenSkills.skills,k+ScreenSkills.curSelection+m)
                if tk and skills[tk] then
                    if skills[tk][2] then
                        v:SetText(skills[tk][2]):SetAlpha(1)
                    end
                else
                    v:SetAlpha(0)
                end
            end
        end
    end,
    --��ǰѡ����
    curSelection=1,
    --��������
    spellsNums=1,
    --��ǰλ��
    curPosition=1,
}