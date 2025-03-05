require("Envir/QuestDiary/CCLua/GameInit")
UIncludes()

--[[
function cc_print(msg)
	BF_DebugOut(msg)	
	release_print(11111)
end
]]--


-- local teamManager = require("//QuestDiary//Lua//teamManager")

-- -- teamManager_create 角色名 角色ID+时间戳
-- function teamManager_create(play,p1,p2)
	-- local myTeam = teamManager:createTeam()
	-- myTeam:addMember(p1)
	-- return 1
-- end


-- function teamManager_getTeam(play,p1)
	-- -- 查找对应队伍
	-- local aliceTeam = teamManager:getTeam(p1)

	
-- end
-- -- 删除队伍
-- teamManager:removeTeam(myTeam)



-- 根据游戏ID读取gamekey
function getgamekey(gameid)
	local gamekey_arr = {
		["1"] = 'c4ca4238a0b923820dcc509a6f75849b', --工具服
		["3268"] = '2e4a3341612d56e05abb66d5021fea80', --3268
		["5226"] = '8726bb30dc7ce15023daa8ff8402bcfd', --5226
		["6015"] = '0aae4dc379357f437bd5e48ed0387ea4', --6015
		["6681"] = '65586803f1435736f42a541d3a924595', --6681
		["7706"] = 'c2e7b5bb0ec8bb7e2aaf8a5516ca5387', --7706
	}
	
	return gamekey_arr[gameid]
end

function get_str_md5(play,str,var)
	-- local result = md5.sumhexa(str);
	-- setplaydef(play,var,result)
	return 1
end



-- 获取刀魂等级
-- get_daohun_lv 装备位置
function get_daohun_lv(play,pos)
	local link_item = linkbodyitem(play,pos)
	local item_data_json = getcustomitemprogressbar(play,link_item,0)
	local item_data_table = json2tbl(item_data_json)
	return item_data_table["level"]
end

-- 获取所在行会人数
-- get_guild_humcount 结果保存变量
function get_guild_humcount(play,var)
	local count = getguildmembercount(play)
	setplaydef(play,var,count)
end


-- json.decode()
-- get_post_data 结果保存变量
function get_post_data(play,Var,jsonstr)

	local in_data = json2tbl(jsonstr)
	
	local out_data = {}
	
	out_data["gameid"] = getconst(play,"$Gameid")
	out_data["servername"] = getconst(play,"$Servername")
	out_data["userid"] = getconst(play,"$useraccount")
	out_data["roleid"] = getbaseinfo(play,2)
	out_data["username"] = getbaseinfo(play,1)
	out_data["key"] = getgamekey(getconst(play,"$Gameid"))	-- 判断gamekey

	-- 合并两个table
	for k,v in pairs(in_data) do  
		out_data[k] = v
	end

	-- 输出json到变量
	setplaydef(play,Var,tbl2json(out_data))
	return 1
end


-- 时间加减计算 date_calc 2022-1-1 (+/-) 秒数 S$返回的时间
function date_calc(play,dates,calc,sec,var,p5)
	local change_data
	datas_table = split(dates,"-")
	
	change_data = os.time({year = datas_table[1], month = datas_table[2], day = datas_table[3], hour = datas_table[4], minute = datas_table[5], second = datas_table[6]})
	if calc == "+" then
		change_data = change_data + sec
	elseif calc == "-" then
		change_data = change_data - sec
	end
	
	-- 判断返回时间还是时间戳
	if string.upper(p5) == string.upper("time") then
		setplaydef(play,var,os.date("%Y-%m-%d",change_data))
	else
		setplaydef(play,var,change_data)
	end
	
	return 1
end


-- 分割字符串 返回一个表
function split( str,reps )
    local resultStrList = {}
    string.gsub(str,'[^'..reps..']+',function ( w )
        table.insert(resultStrList,w)
    end)
    return resultStrList
end



-- 便捷运算赋值
-- VAR_CHECK <$STR(N$ID)> > 0 100 0 N$判断
-- VAR_CHECK p1 p2 p3 p4 p5 p6
-- 如果P1为空，则直接取false值，除了接受变量其他变量必须传入变量值，不能传变量名
function var_check(play,p1,p2,p3,p4,p5,p6,p7)
	local word,w1
	local c_count,j_count = 0,0
	local rus = p5 --默认取false值
	
	-- 分割多个变量
	for word in string.gmatch(p1, '([^,]+)') do
	
		-- release_print(type(word),type(p3),word,p3)
		-- 转换类型
		if type(p3) == "string" then
			w1 = tostring(word)
		else
			w1 = tonumber(word)
		end
		
		-- 容错，如果字符串转为数字失败，则赋值为0，避免堆栈异常
		if w1 == nil then w1 = 0 end
		
		-- release_print(type(w1),type(p3),w1,p3)
		
		-- 满足条件次数+1
		if p2 == ">" then
			if w1 > p3 then c_count = c_count + 1 end
		end
		
		if p2 == "<" then
			if w1 < p3 then c_count = c_count + 1 end
		end
		
		if p2 == "=" then
			if w1 == p3 then c_count = c_count + 1 end
		end
		
		if p2 == "?" then
			if w1 >= p3 then c_count = c_count + 1 end
		end
		
		if p2 == "!=" then
			if w1 ~= p3 then c_count = c_count + 1 end
		end
		
		-- 循环次数
		j_count = j_count + 1
	end
	
	-- 空参数容错
	if type(p7) ~= 'string' then p7 = 'and' end
	
	-- 判断多条件 与或
	if string.upper(p7) == string.upper("or") then
		if c_count > 0 then rus = p4 end
	else
		if c_count == j_count then rus = p4 end
	end
	
	-- 如果变量等于空，则直接取false值
	if p1 == "" then rus = p5 end
	
	setplaydef(play,p6,rus)
	return 1
end

--检查字符串在键值对中排名多少
-- list_check 键值文本 字符串 返回变量
function list_check(play,p1,p2,p3)

	local sort = nil
	-- 找字符串
	s,e = string.find(p1,p2)
	
	-- 找到了字符串分割来 找不到直接返回0
	if e then
		local var = string.sub(p1,1,e)
		var,sort = string.gsub(var, "=", "+")
		var = nil --释放掉不要的
	else
		sort = 0
	end
	
	setplaydef(play,p3,sort)
	return 1
end

-- 扩展命令，自动判断是不是货币，调用不同命令给与
function give_ex(play,p1,p2)

	if p1 == '' or p2 == '' then
		return 0
	end
	
	local idxs = getstditeminfo(p1,0)
	
	if idxs > 100 then
		giveitem(play,p1,p2)
	else
		changemoney(play,idxs,"+",p2,p3,true)
	end

	return 1
end

-- 扩展命令，自动判断是不是货币，调用不同命令收走
function take_ex(play,p1,p2)

	local idxs = getstditeminfo(p1,0)
	if idxs > 100 then
		takeitem(play,p1,p2)
	else
		changemoney(play,idxs,"-",p2,p3,true)
	end

	return 1
end


-- 连续赋值变量为1个值 耗时比txt脚本高3-5倍左右
function mov_ex(play,p1,...)

	local vars = {...}
	if p1 == 0 then p1 = nil end
	for i,k in ipairs(vars) do
		if #k > 0 then
			-- release_print(i,k)
			setplaydef(play,k,p1)
		end
	end
	
	return 1
end


-- 检查一个整数，返回给到对比数里最大的（智能对检测数字）
-- var_check_num 整数 对比数（2,15,965,1231） 对应变量(N1,N2,N3,N4) 匹配赋值 不匹配赋值 匹配结果保存的变量
function var_check_num(play,p1,p2,p3,p4,p5,p6)
	local table1 = {}
	local table2 = {}

	local nums,word
	for nums in string.gmatch(p2, '([^,]+)') do
		table.insert(table1, nums)
	end
	for word in string.gmatch(p3, '([^,]+)') do
		table.insert(table2, word)
		setplaydef(play,word,p5) -- 默认取false值
	end
	
	-- release_print(word)
	for key = 1,#table1 do
	
		if type(table1[key]) ~= "number" then table1[key] = tonumber(table1[key]) end
		if type(table1[key]) ~= "number" then table1[key] = 0 end
		
		if p1 >= table1[key] then
			setplaydef(play,table2[key],p4)
			setplaydef(play,p6,table1[key])
			return 1
		end
	end

	return 0
end


-- var_check_has 字符串1 字符串2 包含赋值 不包含赋值 赋值的变量
function var_check_has(play,p1,p2,p3,p4,p5,p6)
	-- 如果字符串1是空的 自己返回不包含
	if p1 == nil then
		setplaydef(play,p5,p4)
		return 1
	end


	if p1:find(p2) ~= nil then
		setplaydef(play,p5,p3)
	else
		setplaydef(play,p5,p4)
	end
	
	return 1
end

-- 检测是否有称号，并赋值
function check_title(play,arg1,arg2,arg3,arg4)
	local rus = arg3
	if checktitle(play,arg1) then
		rus = arg2
	end
	
	setplaydef(play,arg4,rus)
	return 1
end

-- 绑定自定义属性
-- 参数：装备位置，属性位置，颜色，属性表，显示表，百分比，显示位置，是否显示，组ID
function abil_ex_bind(play,pos,exindex,show_color,att_id,show_id,per,show_pos,show,groups)
	local item_obj = linkbodyitem(play,pos)
	if item_obj then
		changecustomitemabil(play,item_obj,exindex,0,show_color,groups)
		changecustomitemabil(play,item_obj,exindex,1,att_id,groups)
		changecustomitemabil(play,item_obj,exindex,2,show_id,groups)
		changecustomitemabil(play,item_obj,exindex,3,per,groups)
		changecustomitemabil(play,item_obj,exindex,4,show_pos,groups)
		changecustomitemabil(play,item_obj,exindex,5,show,groups)
	else
		release_print("关联物品失败")
	end
	
	refreshitem(play,item_obj)
	return 1
end

-- 修改自定义属性
function abil_ex_change(play)


	return 1
end

-- 清理自定义属性
function abil_ex_clear(play,pos,group_id)
	local item_obj = linkbodyitem(play,pos)
	if item_obj then
		clearitemcustomabil(play,item_obj,group_id)
	else
		release_print("关联物品失败")
	end
	
	refreshitem(play,item_obj)
	return 1
end

-- 预留
function lua_run_func(play, ...)
	return 1
end
-- 预留1
function lua_run_func1(play, ...)
	return 1
end
-- 预留2
function lua_run_func2(play, ...)
	return 1
end