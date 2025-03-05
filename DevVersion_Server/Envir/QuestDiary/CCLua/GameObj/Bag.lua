Bag = {}

--根据makeindex返回背包道具
function Bag.GetItemByMakeindex(actor, index)
	local item_num = getbaseinfo(actor, CommonDefine.INFO_HUMBAGITEMNUM)
   	for i=0, item_num-1 do
		local itemobj = getiteminfobyindex(actor, i)
		local makeindex = getiteminfo(actor, itemobj, CommonDefine.ITEMINFO_UNIQUEID)
		if makeindex == index then
			return itemobj
		end
   	end
	return nil
end

--根据makeindex返回背包道具的itemidx
function Bag.GetItemidxByMakeindex(actor, index)
	local item_num = getbaseinfo(actor, CommonDefine.INFO_HUMBAGITEMNUM)
   	for i=0, item_num-1 do
		local itemobj = getiteminfobyindex(actor, i)
		local makeindex = getiteminfo(actor, itemobj, CommonDefine.ITEMINFO_UNIQUEID)
		if makeindex == index then
			return getiteminfo(actor, itemobj, CommonDefine.ITEMINFO_ITEMIDX)
		end
   	end
	return 0
end

--用makeidx检测背包中的是否有对应道具对象
function Bag.CheckItemInBag(actor, makeindex)
	if BF_IsNullObj(actor) then
		return false
	end
	if (makeindex==nil) or (makeindex == 0) then
		return false
	end
	if hasitem(actor, makeindex) == 1 then
		return true
	end
	return false
end

--判断背包对于物品table是否有足够空间
function Bag.IsHaveEnoughBagSpace(actor, items)
    if BF_IsNullObj(actor)  then
        return false
    end    
    if (items == nil) or (type(items) ~= 'table') then
        return true
    end

    local nNeedBagSpace = 0
    for _, value in ipairs(items) do        
        if not Item.isCurrency(value.name) then
            local leftnum = value.num
			local srcitemidx = getstditeminfo(value.name, CommonDefine.STDITEMINFO_IDX)
			local itemOverlap = getstditeminfo(value.name, CommonDefine.STDITEMINFO_OVERLAP)

			if itemOverlap == nil then
				release_print('IsHaveEnoughBagSpace itemname error:'..value.name)
			else
				if itemOverlap > 1 then
					local item_num = getbaseinfo(actor, CommonDefine.INFO_HUMBAGITEMNUM)
					for i=0, item_num-1 do
						local itemobj = getiteminfobyindex(actor, i)
						local itemidx = getiteminfo(actor, itemobj, CommonDefine.ITEMINFO_ITEMIDX)
						if srcitemidx == itemidx then
							--这里没有处理绑定的问题！！！！！！ todo.....
							--这里没有处理绑定的问题！！！！！！ todo.....
							--这里没有处理绑定的问题！！！！！！ todo.....
							--这里没有处理绑定的问题！！！！！！ todo.....
							--这里没有处理绑定的问题！！！！！！ todo.....
							local currnum = getiteminfo(actor, itemobj, CommonDefine.ITEMINFO_OVERLAP)
							leftnum = leftnum - (itemOverlap - currnum)
							if leftnum < 0 then
								leftnum = 0
								break
							end
						end
					end
	
					if leftnum > 0 then
						if leftnum % itemOverlap == 0 then
							nNeedBagSpace = nNeedBagSpace + math.floor(leftnum / itemOverlap)
						else
							nNeedBagSpace = nNeedBagSpace + math.floor(leftnum / itemOverlap) + 1
						end
					end
				end
			end
        end
    end

	if nNeedBagSpace > getbagblank(actor) then
		return false
	end
	return true
end

--返回背包中[min,max]的指定 stdmode和shape 的道具ID字符串  ,  分割
--返回是否已搜索完毕的标记
function Bag.GetBagItemIDInStdmodeStr(actor, stdmode, shape, min, max)
	local strItemList = ''
	local bFinished = true
	if BF_IsNullObj(actor) then
		return strItemList, bFinished	
	end

	local currValidItemIDList = {}
	local nValidItemCounter = 0
	local item_num = getbaseinfo(actor, CommonDefine.INFO_HUMBAGITEMNUM)
   	for i=0, item_num-1 do
		local itemobj = getiteminfobyindex(actor, i)
		if not BF_IsNullObj(itemobj) then
			local itemidx = getiteminfo(actor, itemobj, CommonDefine.ITEMINFO_ITEMIDX)
			local itemStdmode = getstditeminfo(itemidx, CommonDefine.STDITEMINFO_STDMODE)
			local itemShape = getstditeminfo(itemidx, CommonDefine.STDITEMINFO_SHAPE)
			if ((stdmode==0) or (itemStdmode==stdmode)) and ((shape==0) or (itemShape==shape)) then
				nValidItemCounter = nValidItemCounter + 1
				if nValidItemCounter >= min then
					if nValidItemCounter > max then
						bFinished = false
						break
					end					
					if not currValidItemIDList[itemidx] then
						currValidItemIDList[itemidx] = true
						if strItemList ~= '' then
							strItemList = strItemList..','
						end
						strItemList = strItemList..itemidx						
					end	
				end
			end		
		end
   	end
	return strItemList, bFinished
end

--[[

--检查物品数量
function Bag.checkItemNumByIdx(actor, idx, num)
	num = num or 1
	local count = Bag.getItemNumByIdx(actor, idx)
	return count >= num
end

--获取背包空格数量
function Bag.getBagEmptyNum(actor)
	local item_num = getbaseinfo(actor, ConstCfg.gbase.bag_num)
	return ConstCfg.bagcellnum - item_num
end

--检查背包空格数量
function Bag.checkBagEmptyNum(actor, num)
	local empty_num = Bag.getBagEmptyNum(actor)
	return empty_num >= num
end

--检查背包是否足够给予物品 items
function Bag.checkBagEmptyItems(actor, items)
	local bagEmptyNum = Bag.getBagEmptyNum(actor)
	local needEmptyNum = 0
	for _,item in ipairs(items) do
        local idx,num = item[1],item[2]
        if not Item.isCurrency(idx) then    --物品 装备
			needEmptyNum = needEmptyNum + 1
        end
    end
	return bagEmptyNum >= needEmptyNum
end

--获取背包中某件物品对象
function Bag.getItemObjByIdx(actor, idx)
	local item_num = getbaseinfo(actor, ConstCfg.gbase.bag_num)
	for i=0, item_num-1 do
		local itemobj = getiteminfobyindex(actor, i)
		local itemidx = getiteminfo(actor, itemobj, ConstCfg.iteminfo.idx)
		if itemidx == idx then
			return itemobj
		end
	end
end

--获取背包中某件物品唯一id
function Bag.getItemMakeIdByIdx(actor, idx)
	local itemobj = Bag.getItemObjByIdx(actor, idx)
	if not itemobj then return end
	return getiteminfo(actor, itemobj, ConstCfg.iteminfo.id)
end

--检查背包是否有某件物品的数量通过唯一id
function Bag.checkItemNumByMakeIndex(actor, makeindex, num)
	num = num or 1

	local item_num = getbaseinfo(actor, ConstCfg.gbase.bag_num)
	for i=0, item_num-1 do
		local itemobj = getiteminfobyindex(actor, i)
		local itemmakeid = getiteminfo(actor, itemobj, ConstCfg.iteminfo.id)
		if itemmakeid == makeindex then
			if num > 1 then
				local overlap = getiteminfo(actor, itemobj, ConstCfg.iteminfo.overlap)
				if overlap < num then return false end
			end
			return true
		end
	end

	return false
end

--获取背包中某件物品对象通过唯一ID
function Bag.getItemObjByMakeIndex(actor, makeindex)
	local item_num = getbaseinfo(actor, ConstCfg.gbase.bag_num)
	for i=0, item_num-1 do
		local itemobj = getiteminfobyindex(actor, i)
		local itemmakeindex = getiteminfo(actor, itemobj, ConstCfg.iteminfo.id)
		if itemmakeindex == makeindex then
			return itemobj
		end
	end
end

]]--
return Bag