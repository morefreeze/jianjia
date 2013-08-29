
require('scene.init')

scene = Scene()

function scene:OnNew()
  print('onnew')
end

function scene:OnLoad(scr)
    Scene:OnLoad(scr)
    print('onload')
end

function scene:OnExit(self, scr, index)
	print('onexit')
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
