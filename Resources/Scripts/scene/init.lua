
-- Scene 2013.8.6， fy
-- 场景数据类

Scene = Class()

-- 场景新建
function Scene:OnNew(scr)
    self.scr = scr
    self.objs = self.objs or {}
end

-- 场景内存被释放
function Scene:OnFree()

end


function Scene:LoadOBJ(name, info, phyinfo)
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

    local _ = flux.View()
    _:SetPosition(phyinfo.pos)

    for k,v in pairs(info.prop) do
        if not setval(_, k, v) then
            if not setval(_, 'Set'..k, v) then
                print('错误: 未知的属性 ' .. k)
            end
        end
    end

    self.scr:AddView(_)
    if info.code then
        info.code(self.scr, _)
    end
    if phyinfo.data then
        phyinfo.data.v = _
    end
    return _
end


-- 场景被加载
function Scene:OnLoad()
    if not self.is_init then
        local scr = self.scr

        local infomap = scr.phy:GetObjectInfo()
        for k,v in pairs(self.objs) do 
            if infomap:has_key(k) then
                info = infomap:get(k)
                self:LoadOBJ(k, v, info)
            end
        end

        local area = scr.map:GetSize()
        self.WIDTH = area.x
        self.HEIGHT = area.y
        self.LEFT = - area.x / 2
        self.RIGHT = area.x / 2
        self.TOP = area.y / 2
        self.BOTTOM = - area.y / 2
        
        self.is_init = true
    end
end

-- 即将离开场景
function Scene:OnExit(scr, index)
	;
end

-- 碰撞开始
function Scene:CollisionBegin(scr, a, b)
    ;
end

-- 碰撞结束
function Scene:CollisionEnd(scr, a, b)
    ;
end
