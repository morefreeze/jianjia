
require('scene.init')

scene = Scene('影帆镇')

function scene:OnNew(scr)
    Scene.OnNew(self, scr)

    self.objs = {
        npc1 = {
            name = 'PC喵',
            prop = {
                Size = {1.9, 2.595},
                SpriteFrame = {{"Resources/Images/ch/PC01.png", 0}, {"Resources/Images/ch/PC02.png", 1}},
            },
            rchat = {
                Text.show('PC喵', '你好，我是NPC').getlist(),
                Text.show('PC喵', '嘿！站住！你存档了吗？！').getlist(),
                Text.show('PC喵', '为什么我总是要随机重复这些无聊的话？').getlist(),
                Text.show('PC喵', '红色和蓝色，你选择哪一个？').getlist(),
            },
            code = function(scr, view)
                view:PlayFrame(1, 0, 1):Loop()
            end
        },
    }
end

function scene:CollisionBegin(scr, a, b)
    if a and b then
        if a.index == flux.PHYINDEX_CHARACTER then
            if b.index == flux.PHYINDEX_TOP then
                ;
            elseif b.index == flux.PHYINDEX_RIGHT then
            	theWorld:DelayRun(wrap(function()
                    scr:LoadScene('newbie3', self.LEFT + 2, 0)
				end))
            elseif b.index == flux.PHYINDEX_BOTTOM then
                ;
            elseif b.index == flux.PHYINDEX_LEFT then
                ;
            end
        end
    end
end

return scene
