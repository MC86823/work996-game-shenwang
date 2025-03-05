Item = {}

--检查idx是否是货币
function Item.isCurrency(idxOrName)
    local stdmode = getstditeminfo(idxOrName, CommonDefine.STDITEMINFO_STDMODE)
    return stdmode == 41
end

function Item.GetItemQualityLvByID(itemid)
    local qualitylv = CommonDefine.ITEM_QUALITY_WHITE
    if itemid == nil then
        return qualitylv
    end
    local cfgInfo = cfg_equip[itemid]
    if cfgInfo == nil then
        cfgInfo = cfg_item[itemid]
    end
    if cfgInfo == nil then
        return qualitylv
    end    
    if cfgInfo.QualityLv == nil then
        return qualitylv
    else
        qualitylv = cfgInfo.QualityLv
    end
    return qualitylv
end

--返回道具的品质
function Item.GetItemQualityLv(actor, equipitem)
    local qualitylv = CommonDefine.ITEM_QUALITY_WHITE
    if BF_IsNullObj(actor) or BF_IsNullObj(equipitem) then
        return qualitylv
    end
    local itemid = getiteminfo(actor, equipitem, CommonDefine.ITEMINFO_ITEMIDX)
    return Item.GetItemQualityLvByID(itemid)
end

--返回道具的品质颜色id
function Item.GetItemQualityColor(actor, equipitem)
    local qualitylv = Item.GetItemQualityLv(actor, equipitem)  
    return CSS.GetQualityColor(qualitylv)
end

--返回道具对应的特效，根据功能不同而区分
function Item.GetUIShowEffect(itemid, functionid)
    local effectid = 0
    if (itemid == nil) or (functionid == nil) then
        return effectid
    end

    local qualitylv = Item.GetItemQualityLvByID(itemid)
    if functionid == CommonDefine.FUNC_ID_COMPOSE then
        --先判断装备的天赋属性

        if qualitylv == CommonDefine.ITEM_QUALITY_PINK then
            return 15009
        elseif qualitylv == CommonDefine.ITEM_QUALITY_GOLD then
            return 15010
        elseif qualitylv == CommonDefine.ITEM_QUALITY_RED then
            return 15011
        end
    elseif (functionid == CommonDefine.FUNC_ID_SOUL_STONE) or (functionid == CommonDefine.FUNC_ID_BAOZHU) then
        if qualitylv == CommonDefine.ITEM_QUALITY_GREEN then
            return 15018
        elseif qualitylv == CommonDefine.ITEM_QUALITY_BLUE then
            return 15019
        elseif qualitylv == CommonDefine.ITEM_QUALITY_PURPLE then
            return 15020
        elseif qualitylv == CommonDefine.ITEM_QUALITY_PINK then
            return 15022
        elseif qualitylv == CommonDefine.ITEM_QUALITY_GOLD then
            return 15024
        elseif qualitylv == CommonDefine.ITEM_QUALITY_RED then
            return 15025
        end
    else
        if qualitylv == CommonDefine.ITEM_QUALITY_PURPLE then
            return 15061
        elseif qualitylv == CommonDefine.ITEM_QUALITY_PINK then
            return 15062
        elseif qualitylv == CommonDefine.ITEM_QUALITY_GOLD then
            return 15067
        elseif qualitylv == CommonDefine.ITEM_QUALITY_RED then
            return 15063
        end
    end
    
    return effectid
end

--[[
--检查idx是否是物品
function Item.isItem(idx)
    local stdmode = getstditeminfo(idx, ConstCfg.stditeminfo.stdmode)
    if stdmode == 41 then return end
    return not ConstCfg.stdmodewheremap[stdmode]
end

--检查idx是否是装备
function Item.isEquip(idx)
    local stdmode = getstditeminfo(idx, ConstCfg.stditeminfo.stdmode)
    if stdmode == 41 then return end
    return ConstCfg.stdmodewheremap[stdmode]
end

--获取where通过idx
function Item.getWheresByIdx(idx)
    local stdmode = getstditeminfo(idx, ConstCfg.stditeminfo.stdmode)
    return ConstCfg.stdmodewheremap[stdmode]
end

--获取idx通过where
function Item.getIdxByWhere(actor, where)
    local equipobj = linkbodyitem(actor, where)
    if equipobj == "0" then return end
    return getiteminfo(actor, equipobj, ConstCfg.iteminfo.idx)
end

--获取物品名字通过idx
function Item.getNameByIdx(idx)
    if idx == ConstCfg.money.bdjade then
        return "玉币"
    end
    return getstditeminfo(idx, ConstCfg.stditeminfo.name)
end

]]--

return Item