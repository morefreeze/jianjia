
-- InfoCard ������Ϣ��
-- @param scr �㶮��
-- @param pos �ؼ�����λ�ã�Ĭ��Ϊ (0,0)
Widget.InfoCard = Class(Widget.Widget, function(self, scr, pos)

    -- ���һ�������������κ����壬ֻ���ø����и�����֪������һ�������ڵ��ø��๹�캯����
    Widget.Widget._ctor(self, scr, pos, "WIDGET.INFOCARD")

    local list = self._viewlist
    list.mapname = flux.TextView(ScreenFight.scr, nil, 'wqyS')
    list.mapname:SetTextColor(1, 1, 1)
    list.mapname:SetAlign(flux.ALIGN_LEFT):SetHUD(true)
    
    self:_UpdatePos()
end)

function Widget.InfoCard:_UpdatePos()
    local list = self._viewlist
    list.mapname:SetPosition(self.pos[1], self.pos[2])
end

-- ����
function Widget.InfoCard:Refresh()
    local list = self._viewlist    
    list.mapname:SetText(SceneManager.now.txt[1])
    --list[1]:SetText(enm:GetAttr('name'))
end
