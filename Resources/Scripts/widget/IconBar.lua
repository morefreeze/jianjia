
-- IconBar ������
-- @param scr �㶮��
-- @param pos �ؼ�����λ�ã�Ĭ��Ϊ (0,0)
Widget.IconBar = Class(Widget.Widget, function(self, scr, pos, size)

    -- ���һ�������������κ����壬ֻ���ø����и�����֪������һ�������ڵ��ø��๹�캯����
    Widget.Widget._ctor(self, scr, pos, "WIDGET.ICONBAR")

    local list = self._viewlist
    for i=1,size do
        list[i] = flux.View()
        list[i]:SetPosition(pos[1]+(i-2)*2, pos[2]):SetSize(1.25, 1.25):SetHUD(true)
    end
    
    list.sel = flux.View()
    list.sel:SetLayer(-1):SetHUD(true)
    list.sel:SetPosition(pos[1]-2, pos[2]):SetSize(1.3, 1.3):SetColor(0.69,0.69,0.69, 0.6) -- SetSprite('Resources/Images/UI/iconbar_border.png')
    
    self.size = size
    self:_UpdatePos()
end)

function Widget.IconBar:SetSel(sel)
    local list = self._viewlist
    self.sel = 1
    list.sel:SetPosition(self.pos[1]+(sel-2)*2, self.pos[2])
end

function Widget.IconBar:SetData(...)

    local data = {...}
    local list = self._viewlist

    for i=1,self.size do
        list[i]:SetSprite(data[i][2])
    end
    
end