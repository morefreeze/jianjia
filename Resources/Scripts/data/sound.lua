
Sound = Class()

function Sound:Load(data)
    if data.tid == 1 then
        theSound:LoadMusic(data.id, data.path)
    end
end

Sound.BGM = {
    JinZhao = {id=1, name='������', txt='������������', path="Resources/Sounds/bgm-1.mid", tid=1},
    Newbie = {id=2, name='', txt='���ִ屳������', path="Resources/Sounds/bgm-2.mid", tid=1},
}

Sound.SE = {}

Sound.VOICE = {}
