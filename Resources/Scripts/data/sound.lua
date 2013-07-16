
Sound = Class()

function Sound:Load(data)
    if data.tid == 1 then
        theSound:LoadMusic(data.id, data.path)
    end
end

Sound.BGM = {
    JinZhao = {id=1, name='还看今朝', txt='开场背景音乐', path="Resources/Sounds/bgm-1.mid", tid=1},
    Newbie = {id=2, name='', txt='新手村背景音乐', path="Resources/Sounds/bgm-2.mid", tid=1},
}

Sound.SE = {}

Sound.VOICE = {}
