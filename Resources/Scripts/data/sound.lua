
Sound = Class()

function Sound:Load(data)
    if data.tid == 1 then
        theSound:LoadMusic(data.id, data.path)
    end
end

Sound.BGM = {
    Newbie1 = {id=1, txt='���ִ屳������', path="Resources/Sounds/bgm-1.mid", tid=1},
}

Sound.SE = {}

Sound.VOICE = {}
