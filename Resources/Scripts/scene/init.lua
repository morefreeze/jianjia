
-- Scene 2013.8.6， fy
-- 场景数据类

Scene = Class(function(self, name)
    self.mapname = name
end)

-- 场景新建
function Scene:OnNew(scr)
    self.scr = scr
    self.objs = self.objs or {}
    self.objindex = {}
end

-- 场景内存被释放
function Scene:OnFree()

end

function Scene:GetInfoFromIndex(v)
    return self.objindex[v]
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

    local _
    if phyinfo.type == 'npc' then
        _ = flux.View()
        _:SetPosition(phyinfo.pos)

        for k,v in pairs(info.prop) do
            if not setval(_, k, v) then
                if not setval(_, 'Set'..k, v) then
                    print('错误: 未知的属性 ' .. k)
                end
            end
        end

        self.scr:AddView(_)

        if phyinfo.data then
            -- FLAG: 注意，这里居然会保存 _ 的引用！这可能会导致一个内存泄露问题。
            phyinfo.data.v = _
        end

        self.objindex[phyinfo.data.index] = {base=info, phy=phyinfo}
    end

    if info.code then
        info.code(self.scr, _)
    end

    return _
end

-- 场景被加载
function Scene:OnLoad()
    local scr = self.scr
    if not self.is_init then
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
    
    scr.mapname:SetText(self.mapname)
    
end

-- 碰撞开始
function Scene:CollisionBegin(scr, a, b)
    ;
end

-- 碰撞结束
function Scene:CollisionEnd(scr, a, b)
    ;
end
