

Scene = Class(function(self, mapname, name, init_func, onload_func, keyinput_func, phybegin_func, phyend_func)
    self.mapname = mapname
    self.name = name
    self.viewlist = {}
    self.isload = false
    self.init_func = init_func
    self.onload_func = onload_func
    self.keyinput_func = keyinput_func
    self.phybegin_func = phybegin_func
    self.phyend_func = phyend_func
    SceneManager.scene[mapname] = self
end)

-- 加载和初始化控件
function Scene:Load()
    if not self.isload then
        self.init_func(self, SceneManager.scr)
        self.isload = true
    end
    self.onload_func(self, SceneManager.scr)
end

-- 释放所有控件
function Scene:Free()
    self.isload = false
    self.viewlist = {}
end

-- 创建地图边界
function Scene:CreateEdge()

    local views = self.viewlist

    -- 边框
    views.edge = {
        top = flux.View(screen),
        left = flux.View(screen),
        right = flux.View(screen),
        bottom = flux.View(screen),
    }

    views.edge.top:SetSize(400, 0.1):SetPosition(3000, 3000):SetColor(1,0,0):SetAlpha(1):SetPhy(flux.b2_staticBody):PhyNewFixture(10001)
    views.edge.left:SetSize(0.1, 400):SetPosition(-3000, 3001):SetColor(1,0,0):SetAlpha(1):SetPhy(flux.b2_staticBody):PhyNewFixture(10002)
    views.edge.right:SetSize(0.1, 400):SetPosition(-3000, 3002):SetColor(1,0,0):SetAlpha(1):SetPhy(flux.b2_staticBody):PhyNewFixture(10003)
    views.edge.bottom:SetSize(400, 0.1):SetPosition(3000, 3003):SetColor(1,0,0):SetAlpha(1):SetPhy(flux.b2_staticBody):PhyNewFixture(10004)

end

-- 根据当前地图大小决定边界位置
function Scene:ResetEdge()

    local views = self.viewlist
    local pos = SceneManager.map:GetSize()

    views.edge.top:SetSize(pos.x, 0.1):SetPosition(0, pos.y/2+0.05)
    views.edge.bottom:SetSize(pos.x, 0.1):SetPosition(0, -pos.y/2-0.05)
    views.edge.left:SetSize(0.1, pos.y):SetPosition(-pos.x/2-0.05, 0)
    views.edge.right:SetSize(0.1, pos.y):SetPosition(pos.x/2+0.05, 0)
    
    theCamera:SetSize(pos.x, pos.y)

end

function Scene:LoadNPC()
    local views = self.viewlist
    local ret = require('npc.' .. self.mapname)
    if not ret then return end
    self.npc = ret

    local function setval(_, k, v)
        if _[k] then
            if type(v) == 'table' and type(v[1]) == 'table' then            
                for _k,_v in pairs(v) do
                    _[k](_, unpack(_v))
                end
            else
                _[k](_, unpack(v))
            end
            return true
        end
    end

    for name,info in pairs(ret) do
        local _ = flux.View(self.scr)
        _:SetPhy(flux.b2_staticBody)
        for k,v in pairs(info.prop) do
            if not setval(_, k, v) then
                if not setval(_, 'Set'..k, v) then
                    print('错误: 未知的属性 ' .. k)
                end
            end
        end
        if not info.nophy then
            _:SetLight()
            _:PhyNewFixture()
        end
        views[name] = _
    end
end

-- 将控件添加至窗体
-- @param scr 指定的窗体
function Scene:AddToScreen(scr)
    self:Load()
    for k,v in pairs(self.viewlist) do
        if type(v) == 'table' then
            for k,v in pairs(v) do
                scr:AddView(v)
            end
        else
            scr:AddView(v)
        end
    end
end

function Scene:KeyInput(scr, key, state)
    local views = self.viewlist
    if self.npc and state == flux.GLFW_PRESS then
        if key == _b'Z' or key == flux.GLFW_KEY_SPACE then
            for k,v in pairs(self.npc) do
                if v.rchat and SceneManager.player:CheckFacing(views[k]) then
                    RandomShowText(k, unpack(v.rchat))
                end
            end
        end
    end
    if self.keyinput_func then
        self.keyinput_func(self, scr, key, state)
    end
end

function Scene:PhyContactBegin(scr, a, b)
    if self.phybegin_func then
        self.phybegin_func(self, scr, a, b)
    end
end

function Scene:PhyContactEnd(scr, a, b)
    if self.phyend_func then
        self.phyend_func(self, scr, a, b)
    end
end

