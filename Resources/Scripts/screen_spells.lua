--��ɫ
local Colors={
    normal=flux.Color(1,1,1),
    selection=flux.Color(1,0,0),
}
--��ʼ���ؼ�
local function InitRes(this)
    --��ʼ������
    ScreenSpells.bg = flux.View(this)
    ScreenSpells.bg:SetHUD(true)
    ScreenSpells.bg:SetSize(24, 6)
    ScreenSpells.bg:SetPosition(0, 0):SetAlpha(0.8)
    ScreenSpells.bg:SetSprite('Resources/Images/textbg.png')
    this:AddView(ScreenSpells.bg)

    ScreenSpells.spellsView = {
        flux.TextView(this,nil,'wqy'),
        flux.TextView(this,nil,'wqy'),
        flux.TextView(this,nil,'wqy'),
        flux.TextView(this,nil,'wqy'),
        flux.TextView(this,nil,'wqy'),
    }
    --ÿҳ��ʾ��������
    for i=1,5 do
        --ScreenSpellsView.spellsView[i] = flux.TextView(this,nil,'wqy'):SetAlpha(0)
        ScreenSpells.spellsView[i]:SetTextColor(Colors.normal):SetPosition(-7,3+-1*i):SetAlign(flux.ALIGN_LEFT):SetAlpha(0):SetHUD(true)--
        this:AddView(ScreenSpells.spellsView[i])
    end
    --����˵��
    ScreenSpells.instruct=flux.TextView(this,nil,'wqy')
    ScreenSpells.instruct:SetTextColor(Colors.normal):SetPosition(4,1):SetAlign(flux.ALIGN_LEFT):SetHUD(true)
    this:AddView(ScreenSpells.instruct)

    --����ѡ���
    ScreenSpells.spellsSelection=flux.View(this)
    ScreenSpells.spellsSelection:SetColor(0.7,0,1):SetAlpha(0.3):SetSize(6,1):SetPosition(-4.5,2):SetHUD(true)
    this:AddView(ScreenSpells.spellsSelection)
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
ScreenSpells={
    --�Ѽ��ܴ�����
    new = function(spls,callback)
        ScreenSpells.spells = spls
        ScreenSpells.spellsNums=table.length(spls)
        ScreenSpells.callback=callback
        --��ʼ��
        if ScreenSpells.scr==nil then
            ScreenSpells.scr = flux.Screen()
            ScreenSpells.scr:lua_Init(wrap(function(this)
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
            ScreenSpells.scr:lua_OnPush(wrap(function(this)
                theWorld:PhyPause()
                ScreenSpells.update(ScreenSpells.curSelection,0)
            end))
            ScreenSpells.scr:lua_OnPop(wrap(function(this)
                theWorld:PhyContinue()
            end))

            --���������¼�
            ScreenSpells.scr:lua_KeyInput(wrap(function(this, key, state)
                if state == flux.GLFW_PRESS then
                    if key==flux.GLFW_KEY_UP then
                        --��
                        if ScreenSpells.curSelection > 1 then
                            ScreenSpells.update(ScreenSpells.curSelection,-1)
                        end
                    elseif key==flux.GLFW_KEY_DOWN then
                        --��
                        if ScreenSpells.curSelection < ScreenSpells.spellsNums then
                            ScreenSpells.update(ScreenSpells.curSelection,1)
                        end
                    elseif key==flux.GLFW_KEY_ENTER then
                        --ѡ���ͷż���
                        local tk = table.find(ScreenSpells.spells,ScreenSpells.curSelection)
                        if Spell:CanCast(data.ch[1],spells[tk]) then
                            print("�ͷż��ܰ�ɧ��")
                            if type(ScreenSpells.callback)=='function' then
                                ScreenSpells.callback(spells[tk])
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
        if nextSelection >=1 and nextSelection<=ScreenSpells.spellsNums then
            if step==1 then
                --��
                if ScreenSpells.curPosition<5 then
                    ScreenSpells.curPosition=ScreenSpells.curPosition+1
                end
                ScreenSpells.curSelection=nextSelection
            elseif step==-1 then
                --��
                if ScreenSpells.curPosition>1 then
                    ScreenSpells.curPosition=ScreenSpells.curPosition-1
                end
                ScreenSpells.curSelection=nextSelection
            elseif step==0 then
                --�������
                ScreenSpells.curSelection=nextSelection
            end
        end
        ScreenSpells.spellsSelection:SetAlpha(0.3):SetPosition(-4.5,3-ScreenSpells.curPosition)
        --����˵����Ϣ
        --ScreenSpells.instruct:SetText(ScreenSpells.spells[ScreenSpells.curSelection][6]):SetAlpha(1)
        local k= table.find(ScreenSpells.spells,ScreenSpells.curSelection)
        ScreenSpells.instruct:SetText(spells[k][6]):SetAlpha(1)
        --ScreenSpells.instruct:SetText(Split(ScreenSpells.spells[ScreenSpells.curPosition][5])):SetAlpha(1)
        local m=nil
        if ScreenSpells.curPosition==1 and (step==-1 or step==0) then
            m=-1
        elseif ScreenSpells.curPosition==5 and step==1 then
            m=-5
        end
        print("����")
        --���¼����б�
        if  m then
            for k, v in pairs(ScreenSpells.spellsView) do
                --����id,�ȼ�
                local tk = table.find(ScreenSpells.spells,k+ScreenSpells.curSelection+m)
                if tk and spells[tk] then
                    if spells[tk][2] then
                        v:SetText(spells[tk][2]):SetAlpha(1)
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