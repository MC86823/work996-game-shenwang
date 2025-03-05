require("Envir/QuestDiary/CCLua/GameInit")
UIncludes()

--[[
function cc_print(msg)
	BF_DebugOut(msg)	
	release_print(11111)
end
]]--


-- local teamManager = require("//QuestDiary//Lua//teamManager")

-- -- teamManager_create ��ɫ�� ��ɫID+ʱ���
-- function teamManager_create(play,p1,p2)
	-- local myTeam = teamManager:createTeam()
	-- myTeam:addMember(p1)
	-- return 1
-- end


-- function teamManager_getTeam(play,p1)
	-- -- ���Ҷ�Ӧ����
	-- local aliceTeam = teamManager:getTeam(p1)

	
-- end
-- -- ɾ������
-- teamManager:removeTeam(myTeam)



-- ������ϷID��ȡgamekey
function getgamekey(gameid)
	local gamekey_arr = {
		["1"] = 'c4ca4238a0b923820dcc509a6f75849b', --���߷�
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



-- ��ȡ����ȼ�
-- get_daohun_lv װ��λ��
function get_daohun_lv(play,pos)
	local link_item = linkbodyitem(play,pos)
	local item_data_json = getcustomitemprogressbar(play,link_item,0)
	local item_data_table = json2tbl(item_data_json)
	return item_data_table["level"]
end

-- ��ȡ�����л�����
-- get_guild_humcount ����������
function get_guild_humcount(play,var)
	local count = getguildmembercount(play)
	setplaydef(play,var,count)
end


-- json.decode()
-- get_post_data ����������
function get_post_data(play,Var,jsonstr)

	local in_data = json2tbl(jsonstr)
	
	local out_data = {}
	
	out_data["gameid"] = getconst(play,"$Gameid")
	out_data["servername"] = getconst(play,"$Servername")
	out_data["userid"] = getconst(play,"$useraccount")
	out_data["roleid"] = getbaseinfo(play,2)
	out_data["username"] = getbaseinfo(play,1)
	out_data["key"] = getgamekey(getconst(play,"$Gameid"))	-- �ж�gamekey

	-- �ϲ�����table
	for k,v in pairs(in_data) do  
		out_data[k] = v
	end

	-- ���json������
	setplaydef(play,Var,tbl2json(out_data))
	return 1
end


-- ʱ��Ӽ����� date_calc 2022-1-1 (+/-) ���� S$���ص�ʱ��
function date_calc(play,dates,calc,sec,var,p5)
	local change_data
	datas_table = split(dates,"-")
	
	change_data = os.time({year = datas_table[1], month = datas_table[2], day = datas_table[3], hour = datas_table[4], minute = datas_table[5], second = datas_table[6]})
	if calc == "+" then
		change_data = change_data + sec
	elseif calc == "-" then
		change_data = change_data - sec
	end
	
	-- �жϷ���ʱ�仹��ʱ���
	if string.upper(p5) == string.upper("time") then
		setplaydef(play,var,os.date("%Y-%m-%d",change_data))
	else
		setplaydef(play,var,change_data)
	end
	
	return 1
end


-- �ָ��ַ��� ����һ����
function split( str,reps )
    local resultStrList = {}
    string.gsub(str,'[^'..reps..']+',function ( w )
        table.insert(resultStrList,w)
    end)
    return resultStrList
end



-- ������㸳ֵ
-- VAR_CHECK <$STR(N$ID)> > 0 100 0 N$�ж�
-- VAR_CHECK p1 p2 p3 p4 p5 p6
-- ���P1Ϊ�գ���ֱ��ȡfalseֵ�����˽��ܱ��������������봫�����ֵ�����ܴ�������
function var_check(play,p1,p2,p3,p4,p5,p6,p7)
	local word,w1
	local c_count,j_count = 0,0
	local rus = p5 --Ĭ��ȡfalseֵ
	
	-- �ָ�������
	for word in string.gmatch(p1, '([^,]+)') do
	
		-- release_print(type(word),type(p3),word,p3)
		-- ת������
		if type(p3) == "string" then
			w1 = tostring(word)
		else
			w1 = tonumber(word)
		end
		
		-- �ݴ�����ַ���תΪ����ʧ�ܣ���ֵΪ0�������ջ�쳣
		if w1 == nil then w1 = 0 end
		
		-- release_print(type(w1),type(p3),w1,p3)
		
		-- ������������+1
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
		
		-- ѭ������
		j_count = j_count + 1
	end
	
	-- �ղ����ݴ�
	if type(p7) ~= 'string' then p7 = 'and' end
	
	-- �ж϶����� ���
	if string.upper(p7) == string.upper("or") then
		if c_count > 0 then rus = p4 end
	else
		if c_count == j_count then rus = p4 end
	end
	
	-- ����������ڿգ���ֱ��ȡfalseֵ
	if p1 == "" then rus = p5 end
	
	setplaydef(play,p6,rus)
	return 1
end

--����ַ����ڼ�ֵ������������
-- list_check ��ֵ�ı� �ַ��� ���ر���
function list_check(play,p1,p2,p3)

	local sort = nil
	-- ���ַ���
	s,e = string.find(p1,p2)
	
	-- �ҵ����ַ����ָ��� �Ҳ���ֱ�ӷ���0
	if e then
		local var = string.sub(p1,1,e)
		var,sort = string.gsub(var, "=", "+")
		var = nil --�ͷŵ���Ҫ��
	else
		sort = 0
	end
	
	setplaydef(play,p3,sort)
	return 1
end

-- ��չ����Զ��ж��ǲ��ǻ��ң����ò�ͬ�������
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

-- ��չ����Զ��ж��ǲ��ǻ��ң����ò�ͬ��������
function take_ex(play,p1,p2)

	local idxs = getstditeminfo(p1,0)
	if idxs > 100 then
		takeitem(play,p1,p2)
	else
		changemoney(play,idxs,"-",p2,p3,true)
	end

	return 1
end


-- ������ֵ����Ϊ1��ֵ ��ʱ��txt�ű���3-5������
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


-- ���һ�����������ظ����Ա��������ģ����ܶԼ�����֣�
-- var_check_num ���� �Ա�����2,15,965,1231�� ��Ӧ����(N1,N2,N3,N4) ƥ�丳ֵ ��ƥ�丳ֵ ƥ��������ı���
function var_check_num(play,p1,p2,p3,p4,p5,p6)
	local table1 = {}
	local table2 = {}

	local nums,word
	for nums in string.gmatch(p2, '([^,]+)') do
		table.insert(table1, nums)
	end
	for word in string.gmatch(p3, '([^,]+)') do
		table.insert(table2, word)
		setplaydef(play,word,p5) -- Ĭ��ȡfalseֵ
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


-- var_check_has �ַ���1 �ַ���2 ������ֵ ��������ֵ ��ֵ�ı���
function var_check_has(play,p1,p2,p3,p4,p5,p6)
	-- ����ַ���1�ǿյ� �Լ����ز�����
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

-- ����Ƿ��гƺţ�����ֵ
function check_title(play,arg1,arg2,arg3,arg4)
	local rus = arg3
	if checktitle(play,arg1) then
		rus = arg2
	end
	
	setplaydef(play,arg4,rus)
	return 1
end

-- ���Զ�������
-- ������װ��λ�ã�����λ�ã���ɫ�����Ա���ʾ���ٷֱȣ���ʾλ�ã��Ƿ���ʾ����ID
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
		release_print("������Ʒʧ��")
	end
	
	refreshitem(play,item_obj)
	return 1
end

-- �޸��Զ�������
function abil_ex_change(play)


	return 1
end

-- �����Զ�������
function abil_ex_clear(play,pos,group_id)
	local item_obj = linkbodyitem(play,pos)
	if item_obj then
		clearitemcustomabil(play,item_obj,group_id)
	else
		release_print("������Ʒʧ��")
	end
	
	refreshitem(play,item_obj)
	return 1
end

-- Ԥ��
function lua_run_func(play, ...)
	return 1
end
-- Ԥ��1
function lua_run_func1(play, ...)
	return 1
end
-- Ԥ��2
function lua_run_func2(play, ...)
	return 1
end