
-- Screen and Scene 2013.8.5， fy
-- 窗口与场景机制。场景机制由引擎内置。
-- 一个窗口可以有多个场景，引擎会渲染默认场景加上一个命名场景，每个场景里各有一套控件(Views)
-- 我们可以将主角放在默认场景中（因为他总是出现），让NPC分属若干不同场景以便于随时进行切换。

-- 这里主要实现了三个功能：
-- 1. 保存控件的引用，因为引擎不会做这件事情，所以我们要确保控件不会被GC回收
-- 2. 使得不同场景中可以使用同名控件。这个有点复杂，你只要记住 scr:LoadScene('a') 之后，scr.npc 和 scr:LoadScene('b') 后的 scr.npc 不是同一个东西就行了。
-- 3. 智能回收用的少的场景

Screen = Class(function(self)
    self.scr = flux.Screen()
    self.__scenes = {}
end)

function Screen.LoadScene(self, name, x, y)
    self.__scenename = name
    if name then
        scene = self.__scenes[name]
        self.scr:LoadScene(name or '')

        if not scene then
            scene = require('scene.' .. name)
            self.__scenes[name] = scene
            scene:OnNew(self)
        end

        self.scene = scene
        self.scr:LoadScene(name or '')

        -- 地图
        if self.map then
			self.phy:ClearTmx()
            self.map:Load('Resources/Maps/' .. name .. '.tmx')
            self.phy:AAA(self.scr)
            self.phy:LoadTmx(self.map)
            local pos = self.map:GetSize()
            theCamera:SetSize(pos.x, pos.y)
        end
        
        scene:OnLoad(self)
        if x and y then
            self.phy:SetPos(self.player, x, y)
        end

    end
end

function Screen.RemoveScene(self, name)
    if name then
        if name == self.__scenename then
            self.__scenename = nil
        end
        self.__scenes[name] = nil
    end
    return self.scr:RemoveScene(name)
end

function Screen.__index(t, k)
    local function testscene()
        local scenename = rawget(t, '__scenename')
        if scenename then
            local scenes = rawget(t, '__scenes')
            return scenes[scenename][k]
        end
    end
    
    local function testswigobj()
        if t.scr[k] then
            return function (tbl, ...)
                return t.scr[k](tbl.scr, ...)
            end
        end
    end

    return Screen[k] or testscene() or testswigobj()
end

function Screen.__newindex(t, k, v)
    local scenename = rawget(t, '__scenename')
    if scenename and type(v) == 'userdata' then
        local scenes = rawget(t, '__scenes')
        scenes[scenename][k] = v
    else
        rawset(t,k,v)
    end
end

ScreenStart = Screen()
ScreenGame = Screen()
