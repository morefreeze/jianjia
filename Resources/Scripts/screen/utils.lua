
-- 杂项函数  fy 2013.9.5
-- 主要放置一些会被反复重用的连续操作

Utils = {}

-- 停止动画并让 player 的图像表现出正确朝向
function Utils:PlayerResetAnim()
    local player = ScreenGame.player
    local dir = player:GetDir()

    player:AnimCancel()
    if dir == flux.TD_LEFT then
        player:SetFrame(0)
    elseif dir == flux.TD_RIGHT then
        player:SetFrame(4)
    elseif dir == flux.TD_UP then
        player:SetFrame(12)
    elseif dir == flux.TD_DOWN then
        player:SetFrame(8)
    end
end

-- 停止 player 的移动，并让其图像表现出正确的面朝方向
function Utils:PlayerStop()
    local scr = ScreenGame    
    local player = scr.player

    self:PlayerResetAnim()
    player:Stop()
    thePhy:Stop(player)
end
