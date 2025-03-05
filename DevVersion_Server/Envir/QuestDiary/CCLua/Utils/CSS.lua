CSS = {
    --装备品质颜色
    QUALITY_WHITE = 161,
    QUALITY_GREEN = 215,
    QUALITY_BLUE = 146,
    QUALITY_PURPLE = 241,
    QUALITY_PINK = 253,
    QUALITY_ORANGE = 116,
    QUALITY_RED = 22,
    
    --NPC文本颜色
    NPC_WHITE = 161,
    NPC_LIGHTGREEN = 215,
    NPC_YELLOW = 151,
    NPC_RED = 58,
    NPC_ORANGE = 70,
    NPC_BLUE = 146,
    NPC_PURPLE = 241,
    NPC_PINK = 245,
    NPC_BLUE_LINE = 154,
    NPC_DARKRED = 42,
    NPC_GRAY = 82,

    --聊天框颜色
    CHAT_WHITE = 255,
    CHAT_BLACK = 18,
    CHAT_RED = 56,
    CHAT_BLUE = 167,
    CHAT_YELLOW = 151,
    CHAT_ORANGE = 70,

    --游戏功能相关颜色定义
    CUSTOM_AB_GROUP_COLOR = 161,    --自定义属性的title

    --NPC文本间距定义
    NPC_LEFT_START_X = 30,    
    NPC_TOP_START_Y = 20,    
    NPC_CENTER_START_X = 220,
}

function CSS.GetQualityColor(qualitylv)
    if qualitylv == CommonDefine.ITEM_QUALITY_WHITE then
        return CSS.QUALITY_WHITE
    elseif qualitylv == CommonDefine.ITEM_QUALITY_GREEN then
        return CSS.QUALITY_GREEN
    elseif qualitylv == CommonDefine.ITEM_QUALITY_BLUE then
        return CSS.QUALITY_BLUE
    elseif qualitylv == CommonDefine.ITEM_QUALITY_PURPLE then
        return CSS.QUALITY_PURPLE
    elseif qualitylv == CommonDefine.ITEM_QUALITY_PINK then
        return CSS.QUALITY_PINK
    elseif qualitylv == CommonDefine.ITEM_QUALITY_GOLD then
        return CSS.QUALITY_ORANGE
    elseif qualitylv == CommonDefine.ITEM_QUALITY_RED then
        return CSS.QUALITY_RED
    else
        return CSS.QUALITY_WHITE
    end
end

return CSS