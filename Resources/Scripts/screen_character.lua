--[[
bar_name = {}
bar_view_max = {}
bar_view = {}
bar_mark = {}

attr_name = {}
attr_num = {}

]]--

-- show character board of given character
show_character = function(ctr)


    ScreenCharacter.new()
    --[[
    collectgarbage('collect')
    print(ctr_view)
    for i = 1, 1 do
        --screenCharacter.bar_name[1] = flux.TextView(ScreenCharacter.scr, nil, "wqyL", bar_text[bar_order[1] ])
        --ScreenCharacter.scr:AddView(ScreenCharacter.bar_name)
        ctr_view.bar_name = flux.TextView(ScreenCharacter.scr, nil, "wqyL", bar_text[bar_order[1] ])
    print(ctr_view.bar_name)
        ScreenCharacter.scr:AddView(ctr_view.bar_name)
    end
    for i = 1,#bar_order,2 do
        local k = bar_order[i]
        local v = ctr[k]
        local k_max = bar_order[i+1]
        local v_max = ctr[k_max]
        -- show bar name
        if bar_text[k] then
            bar_name[(i+1)/2] = flux.TextView(ScreenCharacter.scr, nil, "wqyL", bar_text[k])
        else
            bar_name[(i+1)/2] = flux.TextView(ScreenCharacter.scr, nil, "wqyL", _"N/A")
        end
        bar_name[(i+1)/2]:SetTextColor(1,0,0):SetPosition(bar_box.x, bar_box.y - i*1):SetHUD(true)
        ScreenCharacter.scr:AddView(bar_name[(i+1)/2])
        local bar_x = bar_box.x + 2
        -- show the whole bar
        bar_view_max[(i+1)/2] = flux.View(ScreenCharacter.scr, nil)
        bar_view_max[(i+1)/2]:SetSize(bar_box.w, bar_box.h):SetAlign(flux.ALIGN_LEFT)
        bar_view_max[(i+1)/2]:SetColor(bar_color[(i+1)/2][1], bar_color[(i+1)/2][2], bar_color[(i+1)/2][3], 0.3)
        bar_view_max[(i+1)/2]:SetPosition(bar_x, bar_box.y-i*1):SetHUD(true)
        ScreenCharacter.scr:AddView(bar_view_max[(i+1)/2])
        -- show the current bar
        bar_view[(i+1)/2] = flux.View(ScreenCharacter.scr, nil)
        bar_view[(i+1)/2]:SetSize(bar_box.w*(v/v_max), bar_box.h):SetAlign(flux.ALIGN_LEFT)
        bar_view[(i+1)/2]:SetColor(bar_color[(i+1)/2][1], bar_color[(i+1)/2][2], bar_color[(i+1)/2][3], 0.7)
        bar_view[(i+1)/2]:SetPosition(bar_x, bar_box.y-i*1):SetHUD(true)
        ScreenCharacter.scr:AddView(bar_view[(i+1)/2])
        bar_mark[(i+1)/2] = flux.View(ScreenCharacter.scr, nil)
        bar_mark[(i+1)/2]:SetSize(0.1, bar_box.h):SetAlign(flux.ALIGN_LEFT)
        bar_mark[(i+1)/2]:SetColor(0,0,0)
        bar_mark[(i+1)/2]:SetPosition(bar_x+bar_box.w*(v/v_max), bar_box.y-i*1):SetHUD(true)
        ScreenCharacter.scr:AddView(bar_mark[(i+1)/2])
    end
    local attr_tit_name = flux.TextView(ScreenCharacter.scr, nil, "wqyL", _"属性")
    attr_tit_name:SetTextColor(1,0,0):SetPosition(6, 6):SetHUD(true)
    ScreenCharacter.scr:AddView(attr_tit_name)

    for i = 1,#attr_order,1 do
        local k = attr_order[i]
        local v = ctr[k]
        if attr_text[k] then
            attr_name[(i+1)/2] = flux.TextView(ScreenCharacter.scr, nil, "wqyL", attr_text[k])
        else
            attr_name[(i+1)/2] = flux.TextView(ScreenCharacter.scr, nil, "wqyL", _"N/A")
        end
        
        if v then 
            attr_num[(i+1)/2] = flux.TextView(ScreenCharacter.scr, nil, "wqyL", v)
        else
            attr_num[(i+1)/2] = flux.TextView(ScreenCharacter.scr, nil, "wqyL", "N/A")
        end
        attr_name[(i+1)/2]:SetTextColor(1,0,0):SetPosition(attr_box.x, attr_box.y - i*2):SetHUD(true)
        attr_num[(i+1)/2]:SetTextColor(0,0,1):SetPosition(attr_box.x+2, attr_box.y - i*2):SetHUD(true)
        ScreenCharacter.scr:AddView(attr_name[(i+1)/2])
        ScreenCharacter.scr:AddView(attr_num[(i+1)/2])
    end
    ]]--
    theWorld:PushScreen(ScreenCharacter.scr, flux.SCREEN_APPEND)
end

local function CreateCharacterBoard(ctr)
    local ctr_view = {}
    function ctr_view.new()
        
        -- save local language for every elem
        local attr_text = {strength=_"力量", agility=_"敏捷", intelligence=_"智力", 
            spellpower=_"魔能", endurance=_"耐力", will=_"意志",}

        local bar_text = {hp=_"生命", mp=_"魔法", exp=_"经验",}
        local bar_order = {
            "hp",
            "hp_max",
            "mp",
            "mp_max",
            "exp",
            "exp_max",
        }
        print('2')
        local attr_order = {
            "strength",
            "agility",
            "intelligence",
            "spellpower",
            "endurance",
            "will",
        }
        local bar_color = {
            {1,0,0}, -- red
            {0,0,1}, -- blue
            {0.92,0.92,0.06}, -- yellow
        }
        local bar_box = {
            x=-4, y=10, w=6, h=1,
        }
        local attr_box = {
            x=6, y=6,
        }

        ctr_view.bg = flux.View(this)
        ctr_view.bg:SetHUD(true):SetSize(32, 24)
        ScreenCharacter.scr:AddView(ctr_view.bg)

        ctr_view.bar_name = flux.TextView(ScreenCharacter.scr, nil, "wqyL", bar_text[bar_order[1] ])
        ctr_view.bar_name:SetHUD(true)
        ctr_view.bar_name:SetSize(2, 2.5)
        --ctr_view.bar_name:SetColor(0, 0, 0)
        ctr_view.bar_name:SetPosition(0,-2)
        ScreenCharacter.scr:AddView(ctr_view.bar_name)
        
        print('1')
        collectgarbage('collect')
        print('3')
    end
    ctr_view.new()
    print(ctr_view)
    return ctr_view
end

ScreenCharacter = {

    new = function()
        if ScreenCharacter.scr then return end
        -- 基础设定
        ScreenCharacter.scr = flux.Screen()
        
        -- OnPush 事件
        ScreenCharacter.scr:lua_OnPush(wrap(function(this)
            --ScreenCharacter.splash:FadeOut(0.9):AnimDo()
            print("on push")
        end))
        -- 按键响应
        ScreenCharacter.scr:lua_KeyInput(wrap(function(this, key, state)
            if state == flux.GLFW_PRESS then
                if key == flux.GLFW_KEY_ESC then
                    theWorld:PopScreen()
                end
            end
        end))
        -- 初始化控件事件
        ScreenCharacter.scr:lua_Init(wrap(function(this)

            -- 生成控件
            --ScreenCharacter.bg = flux.View(this):SetHUD(true):SetSize(32, 24)

            --ScreenCharacter.splash = flux.View(this)
            --ScreenCharacter.splash:SetSize(32, 24):SetColor(0,0,0)

            -- 注册按键
            -- this:RegKey(_b'Z')
            this:RegKey(flux.GLFW_KEY_ESC)
            this:RegKey(flux.GLFW_KEY_SPACE)
            this:RegKey(flux.GLFW_KEY_LEFT)
            this:RegKey(flux.GLFW_KEY_RIGHT)
            this:RegKey(flux.GLFW_KEY_UP)
            this:RegKey(flux.GLFW_KEY_DOWN)

            --this:AddView(ScreenCharacter.bg)
            -- this:AddView(ScreenCharacter.splash)
            CreateCharacterBoard(data.ch[1])

        end))

    end,

}
