
Text = {
    -- 显示文本，格式 TEXT name txt
    INS_TEXT   = 1,
    -- 执行自函数，格式 FUNC func
    INS_FUNC   = 2,
    -- 音效，格式 SOUND sound_id
    INS_SOUND  = 3,
    --停止命令
    INS_PAUSE  = 4,
    --中止命令
    INS_QUIT   = 5,

    -- 设置对话框背景，格式 SET_TEXT_BG bg_pic
    INS_SET_TEXTBOX_BG = 51,

    textbox_bg = 'Resources/Images/textbg.png',
    run_list = {},

    color = {
        Name = flux.Color(0.18, 0.62, 0.34),
        UnRead = flux.Color(0.8, 0.8, 0.71),
        IsRead = flux.Color(0.55, 0.55, 0.48), --139 139 122
        SwitchCase = flux.Color(0.42, 0.57, 0.14),
    }

}

ScreenText:lua_Init(wrap(function(scr)

    local self = ScreenText
    local size = theWorld:GetSize()
    
    self.bg = flux.View()
    self.bg:SetSize(size.x*0.9, size.y*0.3):SetPosition(0, -size.y*0.3):SetAlpha(0.8):SetHUD(true)
    self.bg:SetSprite(Text.textbox_bg)

    self.name = flux.TextView('wqy', 20)
    self.name:SetAnchor(self.bg)
    self.name:SetAlign(flux.ALIGN_TOPLEFT)
    self.name:SetTextColor(Text.color.Name):SetHUD(true):SetPosition(-size.x*0.41, 2.6)

    self.text = flux.TextView('wqy', 20)
    self.text:SetAnchor(self.bg)
    self.text:SetAlign(flux.ALIGN_TOPLEFT):SetHUD(true)
    self.text:SetTextColor(Text.color.UnRead):SetTextAreaWidth(21.5) --:SetLineSpacing(15)
    self.text:SetPosition(-size.x*0.41, 1.5)

    self:AddView(self.bg)
    self:AddView(self.name)
    self:AddView(self.text)

    self:RegKey(flux.GLFW_KEY_SPACE)
    self:RegKey(flux.GLFW_KEY_ENTER)
    self:RegKey(_b'Z')

end))

ScreenText:lua_OnResize(wrap(function(scr)

    local self = ScreenText
    local size = theWorld:GetSize()
    self.bg:SetSize(size.x*0.9, size.y*0.3):SetPosition(0, -size.y*0.3)
    self.name:SetPosition(-size.x*0.41, 2.6)
    self.text:SetPosition(-size.x*0.41, 1.5)

end))

ScreenText:lua_KeyInput(wrap(function(scr, key, scancode, action, mods)

    if action == flux.GLFW_PRESS then
        if not Text:HandleKeyInput(key, scancode, action, mods) then
            theWorld:PopScreen()
        end
    end

end))

function Text.set_textbox_bg(name, txt)
    local self = Text
    table.insert(self.run_list, {self.INS_SET_TEXTBOX_BG, bg_pic})
    return self
end

function Text.show(name, txt)
    local self = Text
    table.insert(self.run_list, {self.INS_TEXT, name, txt})
    return self
end

function Text.run(func)
    local self = Text
    table.insert(self.run_list, {self.INS_FUNC, func})
    return self
end

function Text.sound(sound_id)
    local self = Text
    table.insert(self.run_list, {self.INS_SOUND, sound_id})
    return self
end

function Text.go()
    local player = ScreenGame.player
    Utils:PlayerStop()

    theWorld:PushScreen(ScreenText.scr, flux.SCREEN_APPEND)
    Text:_execute()
end

function Text.getlist()
    local lst = Text.run_list
    Text.run_list = {}
    return lst    
end

function Text:_execute()
    if #self.run_list ~= 0 then
        local one = table.remove(self.run_list, 1)
        if one[1] == self.INS_TEXT then
            ScreenText.name:SetText(one[2])
            ScreenText.text:SetText(one[3])
            return true
        elseif one[1] == self.INS_FUNC then
            one[2]()
        elseif one[1] == self.INS_SOUND then
            theSound:PlaySound(one[2])
        elseif one[1] == self.INS_SET_TEXTBOX_BG then
            self.textbox_bg = one[2]
            ScreenText.bg:SetSprite(Text.textbox_bg)
        end
    else
        return true
    end
end

function Text:HandleKeyInput(key, scancode, action, mods)
    if #self.run_list ~= 0 then
        repeat
            local ret = Text:_execute()
        until ret
        return true
    end
    return false
end

-- 随机对话函数
-- 传入一组指令列表，随机选择其中一套进行执行，以实现 NPC 的随机对话功能
function Text:random_show(name, tbl)
    local self = Text
    local index = math.random(1, #tbl)
    if self.last_name == name then
        while self.last[index] do
            index = math.random(1, #tbl)
        end
        self.last[index] = true

        if table.length(self.last) == #tbl then
            self.last = {}
        end
    else
        self.last = {}
    end
    self.run_list = table.copy(tbl[index])
    self.last_name = name
    self.go()
end
