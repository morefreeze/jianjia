
require('scene.init')

scene = Scene('影帆镇')

function scene:CollisionBegin(scr, a, b)
    if a and b then
        if a.index == flux.PHYINDEX_CHARACTER then
            if b.index == flux.PHYINDEX_TOP then
                ;
            elseif b.index == flux.PHYINDEX_RIGHT then
                ;
            elseif b.index == flux.PHYINDEX_BOTTOM then
                ;
            elseif b.index == flux.PHYINDEX_LEFT then
            	theWorld:DelayRun(wrap(function()
                    scr:LoadScene('newbie2', self.RIGHT - 2, 0)
				end))
            end
        end
    end
end

return scene
