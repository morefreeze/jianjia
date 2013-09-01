
scr = {}
_b = string.byte
package.path = package.path .. ';./Resources/Scripts/?.lua'
package.path = package.path .. ';./Resources/Scripts/lib/?.lua'

config = {
    SCREEN_WIDTH = 800,
    SCREEN_HEIGHT = 600,
    TITLE = '蒹葭：冒险之旅 dev-r4',
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

require('screen.init')
require('screen.screen_game')
require('screen.screen_start')
--require('sys')

require('widget.widget')
require('widget.widgetset')

function theWorld_GameInit()
    theWorld:LoadFont('Resources/Fonts/wqy-microhei.ttc', 'wqy')
	theWorld:PushScreen(ScreenStart.scr)
end

--sys.init()
theWorld:Init(config.TITLE, config.SCREEN_WIDTH, config.SCREEN_HEIGHT)
theWorld_GameInit()
theWorld:StartGame()
--sys.save()
