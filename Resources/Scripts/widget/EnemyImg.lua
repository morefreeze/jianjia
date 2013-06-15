
-- EnemyImg 怪物图像
-- @param scr 你懂的
-- @param pos 控件中心位置，默认为 (0,0)
-- @param enm 怪物对象，此参数可选
Widget.EnemyImg = Class(Widget.Widget, function(self, scr, pos, enm)

    -- 最后一个参数本身并无任何意义，只是让父类有个渠道知道是哪一个子类在调用父类构造函数。
    Widget.Widget._ctor(self, scr, pos, "WIDGET.ENEMYIMG")
    
    local list = self._viewlist
    list[1] = flux.TextView(ScreenFight.scr, nil, 'wqy')
    list[1]:SetSize(3, 4):SetTextColor(1, 1, 1):SetHUD(true):SetColor(0, 0, 0)

    list[2] = flux.TextView(ScreenFight.scr, nil, 'wqy')
    list[2]:SetTextColor(1, 0, 0, 0):SetHUD(true)

    self.title = list[1]

    if enm then
        self:SetEnemy(ch)
    end
    
    self:_UpdatePos()
end)

-- 设置隐藏
function Widget.EnemyImg:SetVisible(visible)
    self._visible = visible
    local alpha = 0
    if visible then
        alpha = 1
    end
    self._viewlist[1]:SetAlpha(alpha)
end

-- 设置怪物对象
-- @param enm 怪物对象
function Widget.EnemyImg:SetEnemy(enm)
    self.enm = enm
    self:Refresh()
end

function Widget.EnemyImg:HideDmg()
    local list = self._viewlist
    list[2]:SetAlpha(0)
end

function Widget.EnemyImg:ShowDmg(dmg)
    local list = self._viewlist
    if dmg > 0 then
        list[2]:SetTextColor(0, 1, 0, 0)
    else
        list[2]:SetTextColor(1, 0, 0, 0)
    end
    list[2]:SetText(tostring(dmg))
    list[2]:SetAlpha(1)
end

function Widget.EnemyImg:_UpdatePos()
    local list = self._viewlist
    list[1]:SetPosition(self.pos[1], self.pos[2])
    list[2]:SetPosition(self.pos[1], self.pos[2]+2.5)
end

-- 更新
function Widget.EnemyImg:Refresh()
    local enm = self.enm
    local list = self._viewlist    
    if not enm then return end
    list[1]:SetText(enm:GetAttr('name'))
end
