
-- InfoCard ������Ϣ��
-- @param scr �㶮��
-- @param pos �ؼ�����λ�ã�Ĭ��Ϊ (0,0)
Widget.InfoCard = Class(Widget.Widget, function(self, scr, pos)

    -- ���һ�������������κ����壬ֻ���ø����и�����֪������һ�������ڵ��ø��๹�캯����
    Widget.Widget._ctor(self, scr, pos, "WIDGET.INFOCARD")

    local list = self._viewlist
    list.mapname = flux.TextView(ScreenFight.scr, nil, 'wqyS')
    list.mapname:SetTextColor(1, 1, 1)
    list.mapname:SetAlign(flux.ALIGN_RIGHT):SetHUD(true)
 
    list.alignment = flux.TextView(ScreenFight.scr, nil, 'wqyS')
    list.alignment:SetTextColor(1, 1, 1)
    list.alignment:SetAlign(flux.ALIGN_RIGHT):SetHUD(true)
    
    self:_UpdatePos()
end)

function Widget.InfoCard:_UpdatePos()
    local list = self._viewlist
    list.mapname:SetPosition(self.pos[1], self.pos[2])
    list.alignment:SetPosition(self.pos[1], self.pos[2]-0.5)
end

-- ����
function Widget.InfoCard:Refresh()
    local list = self._viewlist    
    list.mapname:SetText(SceneManager.now.txt[1])
    
    local amtext
    if data.player.alignment == 1 then
        amtext = '��������'
    elseif data.player.alignment == 2 then
        amtext = '����'
    elseif data.player.alignment == 3 then
        amtext = '����Ӫ(����)'
    elseif data.player.alignment == 4 then
        amtext = 'а��'
    elseif data.player.alignment == 5 then
        amtext = '����а��'
    end
    if amtext then
        list.alignment:SetText('��Ϊ����:' .. amtext)
    else
        list.alignment:SetText('')
    end
end
