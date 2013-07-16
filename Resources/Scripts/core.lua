
scr = {}
_b = string.byte
package.path = package.path .. ';./Resources/Scripts/?.lua'
package.path = package.path .. ';./Resources/Scripts/lib/?.lua'

config = {
    SCREEN_WIDTH = 1024,
    SCREEN_HEIGHT = 768,
    TITLE = '���磺ð��֮�� dev-r3',
    VER = 'v0.01',
}

function unpack(t)
    if type(t) == 'table' then
        return table.unpack(t)
    else
        return t
    end
end

json = require ("dkjson")
require('class')
require('table_ext')
require('langs.lang')

require('sys')
require('screen_start')
require('screen_fight')
require('screen_about')
require('screen_alignment_choose')
require('screen_text')
require('screen_character')
require('screen_item')
require('screen_spell')
require('screen_game')
require('screen_msgbox')
require('screen_tip')

require('widget.widget')
require('widget.widgetset')
require('scene.scene_manager')

function theWorld_GameInit()
    theWorld:LoadFont('Resources/Fonts/wqy-microhei.ttc', 'wqyL', 40)
    theWorld:LoadFont('Resources/Fonts/wqy-microhei.ttc', 'wqy',  25)
    theWorld:LoadFont('Resources/Fonts/wqy-microhei.ttc', 'wqyS', 15)
	ScreenStart.new()
	ScreenFight.new()
	ScreenAbout.new()
    ScreenCharacter.new()
    ScreenItem.new()
	ScreenGame.new()
	theWorld:PushScreen(ScreenStart.scr)
end

sys.init()
theWorld:Init(config.TITLE, config.SCREEN_WIDTH, config.SCREEN_HEIGHT)
theWorld:InitPhysics()
theWorld_GameInit()
theWorld:StartGame()
sys.save()
