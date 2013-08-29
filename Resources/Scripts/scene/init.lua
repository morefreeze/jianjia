
-- Scene 2013.8.6， fy
-- 场景数据类

Scene = Class()

-- 场景新建
function Scene:OnNew()

end

-- 场景内存被释放
function Scene:OnFree()

end

-- 场景被加载
function Scene:OnLoad(scr)
    local area = scr.map:GetSize()
    self.WIDTH = area.x
    self.HEIGHT = area.y
    self.LEFT = - area.x / 2
    self.RIGHT = area.x / 2
    self.TOP = area.y / 2
    self.BOTTOM = - area.y / 2
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
