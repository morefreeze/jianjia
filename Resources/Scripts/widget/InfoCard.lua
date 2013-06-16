
-- InfoCard 右上信息板
-- @param scr 你懂的
-- @param pos 控件中心位置，默认为 (0,0)
Widget.InfoCard = Class(Widget.Widget, function(self, scr, pos)

    -- 最后一个参数本身并无任何意义，只是让父类有个渠道知道是哪一个子类在调用父类构造函数。
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

-- 更新
function Widget.InfoCard:Refresh()
    local list = self._viewlist    
    list.mapname:SetText(SceneManager.now.txt[1])
    
    local amtext
    if data.player.alignment == 1 then
        amtext = '守序善良'
    elseif data.player.alignment == 2 then
        amtext = '善良'
    elseif data.player.alignment == 3 then
        amtext = '无阵营(中立)'
    elseif data.player.alignment == 4 then
        amtext = '邪恶'
    elseif data.player.alignment == 5 then
        amtext = '混乱邪恶'
    end
    if amtext then
        list.alignment:SetText('行为倾向:' .. amtext)
    else
        list.alignment:SetText('')
    end
end
