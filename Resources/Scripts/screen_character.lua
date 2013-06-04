--[[
bar_name = {}
ctr_view.bar_view_max = {}
ctr_view.bar_view = {}
ctr_view.bar_mark = {}

ctr_view.attr_name = {}
attr_num = {}

]]--

-- show character board of given character
show_character = function(ctr)

    ScreenCharacter.new()
    theWorld:PushScreen(ScreenCharacter.scr, flux.SCREEN_APPEND)
end
-- save local language for every elem
attr_text = {strength=_"力量", agility=_"敏捷", intelligence=_"智力", 
    spellpower=_"魔能", endurance=_"耐力", will=_"意志",}
na_text = _"N/A"

bar_text = {hp=_"生命", mp=_"魔法", exp=_"经验",}
bar_order = {
    "hp",
    "hp_max",
    "mp",
    "mp_max",
    "exp",
    "exp_max",
}
attr_order = {
    "strength",
    "agility",
    "intelligence",
    "spellpower",
    "endurance",
    "will",
}
bar_color = {
    {1,0,0}, -- red
    {0,0,1}, -- blue
    {0.92,0.92,0.06}, -- gold
}
-- hp,mp,exp bar position
bar_box = {
    x=-8, y=6, w=6, h=1,
}
-- 6 attribute position
attr_box = {
    x=6, y=6,
}

local function CreateCharacterBoard(ctr)
    local ctr_view = {}
    function ctr_view.new(ctr)

        ctr_view.bg = flux.View(this)
        ctr_view.bg:SetHUD(true):SetSize(32, 24)
        ScreenCharacter.scr:AddView(ctr_view.bg)
        
        ctr_view.bar_name = {}
        ctr_view.bar_view_max = {}
        ctr_view.bar_view = {}
        ctr_view.bar_mark = {}
        for i = 1,#bar_order,2 do
            local k = bar_order[i]
            local v = ctr.data[k]
            local k_max = bar_order[i+1]
            local v_max = ctr.extra[k_max]
            -- show bar name
            if bar_text[k] then
                ctr_view.bar_name[(i+1)/2] = flux.TextView(ScreenCharacter.scr, nil, "wqyL", bar_text[k])
            else
                ctr_view.bar_name[(i+1)/2] = flux.TextView(ScreenCharacter.scr, nil, "wqyL", na_text)
            end
            ctr_view.bar_name[(i+1)/2]:SetTextColor(1,0,0):SetPosition(bar_box.x, bar_box.y - i*1):SetHUD(true)
            ScreenCharacter.scr:AddView(ctr_view.bar_name[(i+1)/2])
            local bar_x = bar_box.x + 2
            -- show the whole bar
            ctr_view.bar_view_max[(i+1)/2] = flux.View(ScreenCharacter.scr, nil)
            ctr_view.bar_view_max[(i+1)/2]:SetSize(bar_box.w, bar_box.h):SetAlign(flux.ALIGN_LEFT)
            ctr_view.bar_view_max[(i+1)/2]:SetColor(bar_color[(i+1)/2][1], bar_color[(i+1)/2][2], bar_color[(i+1)/2][3], 0.3)
            ctr_view.bar_view_max[(i+1)/2]:SetPosition(bar_x, bar_box.y-i*1):SetHUD(true)
            ScreenCharacter.scr:AddView(ctr_view.bar_view_max[(i+1)/2])
            -- show the current bar
            ctr_view.bar_view[(i+1)/2] = flux.View(ScreenCharacter.scr, nil)
            ctr_view.bar_view[(i+1)/2]:SetSize(bar_box.w*(v/v_max), bar_box.h):SetAlign(flux.ALIGN_LEFT)
            ctr_view.bar_view[(i+1)/2]:SetColor(bar_color[(i+1)/2][1], bar_color[(i+1)/2][2], bar_color[(i+1)/2][3], 0.7)
            ctr_view.bar_view[(i+1)/2]:SetPosition(bar_x, bar_box.y-i*1):SetHUD(true)
            ScreenCharacter.scr:AddView(ctr_view.bar_view[(i+1)/2])
            ctr_view.bar_mark[(i+1)/2] = flux.View(ScreenCharacter.scr, nil)
            ctr_view.bar_mark[(i+1)/2]:SetSize(0.1, bar_box.h):SetAlign(flux.ALIGN_LEFT)
            ctr_view.bar_mark[(i+1)/2]:SetColor(0,0,0)
            ctr_view.bar_mark[(i+1)/2]:SetPosition(bar_x+bar_box.w*(v/v_max), bar_box.y-i*1):SetHUD(true)
            ScreenCharacter.scr:AddView(ctr_view.bar_mark[(i+1)/2])
        end
        --ctr_view.attr_tit_name = flux.TextView(ScreenCharacter.scr, nil, "wqyL", _"属性")
        --ctr_view.attr_tit_name:SetTextColor(1,0,0):SetPosition(attr_box.x, attr_box.y):SetHUD(true)
        --ScreenCharacter.scr:AddView(ctr_view.attr_tit_name)
        -- 6 character attribute
        ctr_view.attr_name = {}
        ctr_view.attr_num = {}
        for i = 1,#attr_order,1 do
            local k = attr_order[i]
            local v = ctr.data[k]
            if attr_text[k] then
                ctr_view.attr_name[i] = flux.TextView(ScreenCharacter.scr, nil, "wqyL", attr_text[k])
            else
                ctr_view.attr_name[i] = flux.TextView(ScreenCharacter.scr, nil, "wqyL", na_text)
            end
            
            v = tostring(v)
            if v then 
                ctr_view.attr_num[i] = flux.TextView(ScreenCharacter.scr, nil, "wqyL", v)
            else
                ctr_view.attr_num[i] = flux.TextView(ScreenCharacter.scr, nil, "wqyL", na_text)
            end
            ctr_view.attr_name[i]:SetTextColor(1,0,0):SetPosition(attr_box.x, attr_box.y - i*2):SetHUD(true)
            ctr_view.attr_num[i]:SetTextColor(0,0,1):SetPosition(attr_box.x + 2, attr_box.y - i*2):SetHUD(true)
            ScreenCharacter.scr:AddView(ctr_view.attr_name[i])
            ScreenCharacter.scr:AddView(ctr_view.attr_num[i])
        end
        -- show add points
        ctr_view.points_name = flux.TextView(ScreenCharacter.scr, nil, "wqyL", _"属性点")
        ctr_view.points_name:SetTextColor(1,0,0):SetPosition(attr_box.x, attr_box.y):SetHUD(true)
        ctr_view.points_num = flux.TextView(ScreenCharacter.scr, nil, "wqyL", tostring(ctr.data['points']))
        ctr_view.points_num:SetTextColor(0,0,1):SetPosition(attr_box.x+3, attr_box.y):SetHUD(true)
        ScreenCharacter.scr:AddView(ctr_view.points_name)
        ScreenCharacter.scr:AddView(ctr_view.points_num)
        if ctr.data['points'] > 0 then
            ctr_view.points = {}
            ctr_view.select_pos = 1
            ctr_view.select_box = flux.View(ScreenCharacter.scr)
            ctr_view.select_box:SetHUD(true):SetSize(1,1):SetPosition(attr_box.x + 4, attr_box.y - ctr_view.select_pos*2)
            ctr_view.select_box:SetColor(0,1,1)
            ScreenCharacter.scr:AddView(ctr_view.select_box)
        end
        collectgarbage('collect')
    end

    ctr_view.new(ctr)
    return ctr_view
end

ScreenCharacter = {

new = function()
if ScreenCharacter.scr then return end
        -- 基础设定
        ScreenCharacter.scr = flux.Screen()
        
        -- OnPush 事件
        ScreenCharacter.scr:lua_OnPush(wrap(function(this)
            ScreenCharacter.splash:FadeOut(0.9):AnimDo()
        end))
        -- 按键响应
        ScreenCharacter.scr:lua_KeyInput(wrap(function(this, key, state)
            ctr = data.ch[1]
            if state == flux.GLFW_PRESS then
                if key == flux.GLFW_KEY_ESC then
                    theWorld:PopScreen()
                elseif key == flux.GLFW_KEY_UP then
                    if ctr.data['points'] > 0 then
                        local n = #attr_order
                        ScreenCharacter.ctr_view.select_pos = 
                            (ScreenCharacter.ctr_view.select_pos + n - 2) % n + 1
                        ScreenCharacter.ctr_view.select_box:SetPosition(attr_box.x + 4, 
                            attr_box.y - ScreenCharacter.ctr_view.select_pos * 2)
                    end
                end
                elseif key == flux.GLFW_KEY_DOWN then
                    if ctr.data['points'] > 0 then
                        local n = #attr_order
                        ScreenCharacter.ctr_view.select_pos = 
                            (ScreenCharacter.ctr_view.select_pos) % n + 1
                        ScreenCharacter.ctr_view.select_box:SetPosition(attr_box.x + 4, 
                            attr_box.y - ScreenCharacter.ctr_view.select_pos * 2)
                    end
                elseif key == flux.GLFW_KEY_SPACE then
                    if ctr.data['points'] > 0 then
                        local select_pos = ScreenCharacter.ctr_view.select_pos
                        if (0 < select_pos and select_pos <= #attr_order) then
                            ctr.data['points'] = ctr.data['points'] - 1
                            ctr.data[attr_order[select_pos]] = ctr.data[attr_order[select_pos]] + 1
                            ScreenCharacter.ctr_view.points_num:SetText(tostring(ctr.data['points']))
                            ScreenCharacter.ctr_view.attr_num[select_pos]:SetText(
                                tostring(ctr.data[attr_order[select_pos]])):SetTextColor(1,0,0)
                        end
                    end
            end
            end))
        -- 初始化控件事件
        ScreenCharacter.scr:lua_Init(wrap(function(this)

            -- 生成控件
            --ScreenCharacter.bg = flux.View(this):SetHUD(true):SetSize(32, 24)

            ScreenCharacter.splash = flux.View(this)
            ScreenCharacter.splash:SetSize(32, 24):SetColor(0,0,0)

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
            ScreenCharacter.ctr_view = CreateCharacterBoard(data.ch[1])

            end))

        end,

    }
