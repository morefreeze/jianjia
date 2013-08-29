
-- SliderIcon 滑动图标，见开始页面
-- @param scr 你懂的
-- @param pos 控件中心位置，默认为 (0,0)
Widget.SliderIcon = Class(Widget.Widget, function(self, scr, pos)

    -- 最后一个参数本身并无任何意义，只是让父类有个渠道知道是哪一个子类在调用父类构造函数。
    Widget.Widget._ctor(self, scr, pos, "WIDGET.SLIDERICON")

    local list = self._viewlist
    list.pic1 = flux.View()
    list.pic1:SetSize(6, 6):SetHUD(true)
    list.pic2 = flux.View()
    list.pic2:SetSize(6, 6):SetAlpha(0):SetHUD(true)
    list.txt = flux.TextView('wqy', 40)
    list.txt:SetHUD(true)
    self:_UpdatePos()

end)

function Widget.SliderIcon:SetSel(sel)
    local list = self._viewlist
    self.sel = 1
    if self.data then
        local data = self.data[sel]

        list.txt:SetText(data[1])
        if type(data[2]) == 'table' then
        
        elseif type(data[2]) == 'string' then
            list.pic1:SetSprite(data[2])
        end
    end
end

function Widget.SliderIcon:SetData(...)
    self.data = {...}
end

-- 设置选定回调函数
-- 当对着这个项按 Z 或 Space 时会调用这个回调
function Widget.SliderIcon:SetSelectCallback(callback)
    self.sel_callback = callback
end

-- 设置回调函数
-- 在每次被选中项改变的时候被调用
function Widget.SliderIcon:SetMoveCallback(callback)
    self.move_callback = callback
end

function Widget.SliderIcon:_UpdatePos()
    local list = self._viewlist
    list.pic1:SetPosition(self.pos[1], self.pos[2]+2)
    --list.txt:SetPosition(self.pos[1], self.pos[2]-1)
    list.txt:SetPosition(self.pos[1], self.pos[2]-2)
end

-- 更新
function Widget.SliderIcon:Refresh()
    local list = self._viewlist
end

-- 按键响应
function Widget.SliderIcon:KeyInput(scr, key, state)
    local list = self._viewlist
    local function _update(step)
    
        if self.lock then
            return
        end

        self.sel = self.sel + step
        if self.sel <= 0 then
            self.sel = 1
            return
        elseif self.sel > #self.data then
            self.sel = #self.data
            return
        end
        self.lock = true
        
        if self.move_callback then
            self.move_callback(self.sel)
        end
        
        local _done = wrap(function()
            list.txt:SetText(self.data[self.sel][1])
            self.lock = nil
        end)
        
        local data = self.data[self.sel]
        if type(data[2]) == 'table' then
        
        elseif type(data[2]) == 'string' then
            list.pic2:SetSprite(data[2])
        end
        
        if step < 0 then
            list.pic1:MoveTo(0.5, self.pos[1]-30, self.pos[2]+2):AnimDo()
            list.pic2:SetPosition(self.pos[1]+30, self.pos[2]+2):SetAlpha(1)
            list.pic2:MoveTo(0.5, self.pos[1], self.pos[2]+2, _done):AnimDo()
            list.pic1, list.pic2 = list.pic2, list.pic1
        else
            list.pic1:MoveTo(0.5, self.pos[1]+30, self.pos[2]+2):AnimDo()
            list.pic2:SetPosition(self.pos[1]-30, self.pos[2]+2):SetAlpha(1)
            list.pic2:MoveTo(0.5, self.pos[1], self.pos[2]+2, _done):AnimDo()
            list.pic1, list.pic2 = list.pic2, list.pic1
        end
        
    end
    if self.sel and state == flux.GLFW_PRESS then
        if key == flux.GLFW_KEY_LEFT then
            _update(-1)
        elseif key == flux.GLFW_KEY_RIGHT then
            _update(1)
        elseif key == flux.GLFW_KEY_SPACE or key == _b'Z' or key == flux.GLFW_KEY_ENTER then
            if self.sel_callback then
                self.sel_callback(self.sel)
            end
        end
    end
end