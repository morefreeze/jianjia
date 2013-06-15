
-- InfoCard 右上信息板
-- @param scr 你懂的
-- @param pos 控件中心位置，默认为 (0,0)
Widget.InfoCard = Class(Widget.Widget, function(self, scr, pos)

    -- 最后一个参数本身并无任何意义，只是让父类有个渠道知道是哪一个子类在调用父类构造函数。
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

-- 更新
function Widget.InfoCard:Refresh()
    local list = self._viewlist    
    list.mapname:SetText(SceneManager.now.txt[1])
    --list[1]:SetText(enm:GetAttr('name'))
end
