
-- 新手村

local function OnInit(self, scr)

    local views = self.viewlist
    views.bg = flux.View(scr)
    views.bg:SetSize(theWorld:GetSize()):SetHUD(true)
    Sound:Load(Sound.BGM.JinZhao)

end

local function OnLoad(self, scr)

    -- 新玩家
    theWorld:DelayRun(wrap(function()
        scr:SetPlayer(SceneManager.player)
        SceneManager.player:Reset()
        theSound:SetBGM(Sound.BGM.JinZhao.id)
        ShowText(0, {
            {'项目组', '亲爱的玩家们，当你们看到这段话的时候，证明你们成功的进入了游戏。这里是《蒹葭：冒险之旅》工程版本r3'},
            {'项目组', '我们决定使用不断发布工程版本，然后向后迭代的方式来进行游戏开发。'},
            {'项目组', '因此，你们会看到一些很挫的东西出现在游戏里面，不必介怀。'},
            {'项目组', '若干个版本以后，他们自会消失。'},
            {'项目组', '做游戏不是一件容易的事情，需要长久的时间和大量的精力，以及必不可少的齐心协力。'},
            {'项目组', '这会是一段漫长的时间。我们会聆听你们的意见和建议，也请谅解等待。我们会竭尽所能。'},
            '游戏有存档功能，但目前只会在游戏关闭的时候自动保存。',
            '==================',
            '我转过身来，眼前是汩汩流淌的逝水河。',
            '逝水近海，逐浪而奔流。',
            '身后是影帆镇，过去的三个月中我生活的地方。',
            '三个月之前，失去意识的我被小镇的居民救起，而在醒来之后，我发现自己失去了记忆。',
            '最初我感到难以言表的惶惑，终于我意识到了，除了“伊方”这个名字之外，我已经一无所有。',
            '就像眼前的河水在沼泽与丛林和宁静的田园小镇之间一裁两半，属于我的过往与现在的我一刀两断。',
            '我被命运所流放了。',
            '大概，是时候踏上旅程了吧。',
        }, nil, nil, function()
            SceneManager:Load('newbie_a3', 20, -11.5)
        end)
    end), 1)

end

local function KeyInput(self, scr, key, state)

    local views = self.viewlist

end

local function PhyContactBegin(self, scr, a, b)

end

local function PhyContactEnd(self, scr, a, b)
    
end

Scene('newbie_start', '开始场景', OnInit, OnLoad, KeyInput, PhyContactBegin, PhyContactEnd)
