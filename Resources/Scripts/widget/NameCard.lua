
-- NameCard 角色名片
-- @param scr 你懂的
-- @param pos 控件中心位置，默认为 (0,0)
-- @param character 角色
Widget.NameCard = Class(Widget.Widget, function(self, scr, pos, ch)

    -- 最后一个参数本身并无任何意义，只是让父类有个渠道知道是哪一个子类在调用父类构造函数。
    Widget.Widget._ctor(self, scr, pos, "WIDGET.NAMECARD")
    
    local list = self._viewlist

    -- board_bg
    list[1] = flux.View(self.scr)
    list[1]:SetHUD(true):SetSize(6, 3.671875):SetSprite('Resources/Images/UI/NameCard/box.png'):SetPosition(pos[1], pos[2]) --(10, -7.7)

    -- board
    list[2] = flux.View(self.scr)
    list[2]:SetHUD(true):SetSize(6, 3.671875):SetSprite('Resources/Images/UI/NameCard/content.png'):SetPosition(pos[1], pos[2]) --(10, -7.7)

    -- head
    --list[3] = flux.View(self.scr)
    --list[3]:SetHUD(true):SetSize(2, 2.5):SetColor(0,0,0):SetPosition(pos[1] - 1.7, pos[2] - 0.5) -- (8.3, -8.2) SetSprite('Resources/Images/yf_avatar.png')

    -- name rgb(84,58,63)
    list[3] = flux.TextView(self.scr, nil, "wqy", 'name')
    list[3]:SetAlign(flux.ALIGN_LEFT):SetTextColor(0.33, 0.26, 0.25):SetHUD(true):SetPosition(pos[1], pos[2] + 1.29) -- (10, -6.3)

    -- level rgb(69,65,34)
    list.lv = flux.TextView(self.scr, nil, "wqyS", 'lv')
    list.lv:SetAlign(flux.ALIGN_LEFT):SetTextColor(0.27, 0.255, 0.13):SetHUD(true):SetPosition(pos[1]+1.82, pos[2] + 1.16) -- (10, -6.3)

    -- hp_text rgb(138,58,58)
    list[5] = flux.TextView(self.scr, nil, "wqyS", 'hp')
    list[5]:SetTextColor(0.541, 0.227, 0.227):SetAlign(flux.ALIGN_LEFT):SetHUD(true):SetPosition(pos[1] + 0.1, pos[2] + 0.43) -- (9.7, -7.2)

    -- hp_bar_bg
    --list[6] = flux.View(self.scr)
    --list[6]:SetHUD(true):SetColor(0.4, 0.4, 0.4):SetSize(3, 0.2):SetPosition(pos[1] + 1.1, pos[2]) -- (11.1, -7.7)

    -- hp_bar
    list[7] = flux.View(self.scr)
    list[7]:SetHUD(true):SetSprite('Resources/Images/UI/NameCard/hp.png'):SetPaintMode(flux.PAINT_REPEAT_X):SetSize(2.3, 0.31):SetPosition(pos[1]+0.1, pos[2] + 0.01):SetAlign(flux.ALIGN_LEFT) -- (11.1, -7.7)

    -- mp_text rgb(43,102,118)
    list[8] = flux.TextView(self.scr, nil, "wqyS", 'mp')
    list[8]:SetTextColor(0.169, 0.4, 0.463):SetAlign(flux.ALIGN_LEFT):SetHUD(true):SetPosition(pos[1] + 0.1, pos[2] - 0.5078125) -- (9.7, -8.5)

    -- mp_bar_bg
    --list[9] = flux.View(self.scr)
    --list[9]:SetHUD(true):SetColor(0.4, 0.4, 0.4):SetSize(3, 0.2):SetPosition(pos[1] + 1.1, pos[2] - 1.3) -- (11.1, -9)

    -- mp_bar
    list[10] = flux.View(self.scr)
    list[10]:SetHUD(true):SetSprite('Resources/Images/UI/NameCard/mp.png'):SetPaintMode(flux.PAINT_REPEAT_X):SetSize(2.38, 0.31):SetPosition(pos[1]+0.1, pos[2] - 0.87635):SetAlign(flux.ALIGN_LEFT) -- (11.1, -9)

    -- board
    list[11] = flux.View(self.scr)
    list[11]:SetHUD(true):SetSize(6, 3.671875):SetSprite('Resources/Images/UI/NameCard/inner.png'):SetPosition(pos[1], pos[2]):SetLayer(1) --(10, -7.7)

    list.dmgnum = flux.TextView(ScreenFight.scr, nil, 'wqy')
    list.dmgnum:SetTextColor(1, 0, 0, 0):SetHUD(true):SetPosition(pos[1], pos[2]+2.7)

    if ch then
        self:SetCharacter(ch)
    end
end)

function Widget.NameCard:SetCharacter(ch)
    self.ch = ch
    self:Refresh()
end

function Widget.NameCard:HideDmg()
    local list = self._viewlist
    list.dmgnum:SetAlpha(0)
end

function Widget.NameCard:ShowDmg(dmg)
    local list = self._viewlist
    if dmg > 0 then
        list.dmgnum:SetTextColor(0, 1, 0, 0)
    else
        list.dmgnum:SetTextColor(1, 0, 0, 0)
    end
    list.dmgnum:SetText(tostring(dmg))
    list.dmgnum:SetAlpha(1)
end

-- 设置隐藏
function Widget.NameCard:SetVisible(visible)
    self._visible = visible
    local alpha = 0
    if visible then
        alpha = 1
    end
    for k,v in pairs(self._viewlist) do
        if type(k) == 'number' then
            v:SetAlpha(alpha)
        elseif k == 'lv' then
            v:SetAlpha(alpha)
        end
    end
end

function Widget.NameCard:_UpdatePos()
    local list = self._viewlist
    list[1]:SetPosition(pos[1], pos[2])
    list[2]:SetPosition(pos[1], pos[2])
    list[3]:SetPosition(pos[1] - 1.7, pos[2] - 0.5)
    list[4]:SetPosition(pos[1]      , pos[2] + 1.4)
    list[5]:SetPosition(pos[1] - 0.3, pos[2] + 0.5)
    list[6]:SetPosition(pos[1] + 1.1, pos[2])
    list[7]:SetPosition(pos[1] - 0.4, pos[2])
    list[8]:SetPosition(pos[1] - 0.3, pos[2] - 0.8)
    list[9]:SetPosition(pos[1] + 1.1, pos[2] - 1.3)
    list[10]:SetPosition(pos[1]- 0.4, pos[2] - 1.3)
    list.dmgnum:SetPosition(pos[1], pos[2] + 2.7)
end

function Widget.NameCard:Refresh()
    local ch = self.ch
    local list = self._viewlist
    if not ch then return end

    list[3]:SetText(ch:GetAttr('name'))
    list.lv:SetText(' lv.' .. ch:GetAttr('level'))

    list[5]:SetText(ch:GetAttr('hp') .. '/' .. ch:GetAttr('hp_max'))
    list[8]:SetText(ch:GetAttr('mp') .. '/' .. ch:GetAttr('mp_max'))
    
    list[7]:SetSize(2.38*ch:GetAttr('hp') / ch:GetAttr('hp_max'), 0.31)
    list[10]:SetSize(2.38*ch:GetAttr('mp') / ch:GetAttr('mp_max'), 0.31)
end
