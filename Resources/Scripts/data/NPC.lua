
NPC = Class()
npc = {}

function NPC:Add(key, name, haogan)
    npc[key] = {key=key, name=name, haogan=haogan or 50}
end

NPC:Add('pc', 'PC��', 65)
NPC:Add('cz', '�峤')
