Player = {}

--返回名字
function Player.GetName(actor)
    local name = getbaseinfo(actor, CommonDefine.INFO_NAME)
    return name
end

--返回playerid
function Player.GetPlayerID(actor)
    local name = getbaseinfo(actor, CommonDefine.INFO_USERID)
    return name
end

--如果是怪物，返回配置中的真实名字
function Player.GetMonConfigName(mon)
    local configname = getbaseinfo(mon, CommonDefine.INFO_NAME, 1)
    return configname
end

--对象是否为玩家
function Player.IsPlayer(actor)
    return getbaseinfo(actor, -1)
end

--对象是否死亡
function Player.IsDead(obj)
    local flag = getbaseinfo(obj, 0)
    return flag
end    

--返回等级
function Player.GetLevel(actor)
    local level = getbaseinfo(actor, CommonDefine.INFO_LEVEL)
    return level
end

--设置等级
function Player.SetLevel(actor, level)
    changelevel(actor, '=', level)
    Player.FullHPMP(actor)
end

--返回职业
function Player.GetJob(actor)
    local level = getbaseinfo(actor, CommonDefine.INFO_JOB)
    return level
end

--返回性别
function Player.GetGender(actor)
    local gender = getbaseinfo(actor, CommonDefine.INFO_GENDER)
    return gender
end

--返回行会名
function Player.GetGuildName(actor)
    local guildname = getbaseinfo(actor, CommonDefine.INFO_GUILDNAME)
    return guildname
end

--返回所在地图ID[小写的字符串]
function Player.GetMapIDStr(actor)
    local mapstr = getbaseinfo(actor, CommonDefine.INFO_MAPSTR)
    return mapstr
end

--设置对象满血满蓝
function Player.FullHPMP(actor)
    addhpper(actor, '=', 100)
    addmpper(actor, '=', 100)
end

--返回安全区 满血满蓝
function Player.GoHome(actor)
    gohome(actor)
    Player.FullHPMP(actor)
end

--返回比奇安全区 满血满蓝
function Player.GoBQHome(actor)
    mapmove(actor, '0', 326, 272, 3)
    Player.FullHPMP(actor)
end

--返回盟重安全区 满血满蓝
function Player.GoMZHome(actor)
    mapmove(actor, '3', 330, 330, 3)
    Player.FullHPMP(actor)
end

--返回所在地图的坐标
function Player.GetMapXY(actor)
    local currx = getbaseinfo(actor, CommonDefine.INFO_MAPX)
    local curry = getbaseinfo(actor, CommonDefine.INFO_MAPY)
    return currx, curry
end

--返回monid
function Player.GetMonIdx(actor)
    local monid = getbaseinfo(actor, CommonDefine.INFO_MONIDX)
    return monid
end

--返回对象的血量百分比
function Player.GetCurHPPercent(actor)
    if getbaseinfo(actor, 0) then
        return 0
    else
        local curhp = getbaseinfo(actor, CommonDefine.INFO_CURRHP)
        local maxhp = getbaseinfo(actor, CommonDefine.INFO_MAXHP)
        local percent = math.floor(curhp / maxhp * 100)
        return percent
    end
end

--返回是否是PC客户端
function Player.IsPCClient(actor)
    local sFlag = parsetext("<$CLIENTFLAG>", actor);
    return sFlag == '1'
end

--返回玩家战力
function Player.GetPlayerPower(actor)
    return tonumber(parsetext("<$PLAYERPOWER>", actor));
end

--自动达到目标，不在同地图就飞，在同地图就寻路
function Player.AutoGoToTargMapXY(actor, mapidstr, x, y)
    if BF_IsNullObj(actor) then
        return
    end

    local currmapidstr = Player.GetMapIDStr(actor)
    if (mapidstr==nil) or (currmapidstr == mapidstr) then
        gotonow(actor, x, y)
    else
        map(actor, mapidstr)
        gotonow(actor, x, y)
    end
end

--返回通用进入专属地图后，原地复活需要的消耗
function Player.GetCommonLocalReliveNeedItems(relivetimes)
    if relivetimes <= 0 then
        relivetimes = 1
    elseif relivetimes > #CommonDefine.COMMON_LOCAL_RELIVE_NEED_ITEMS then
        relivetimes = #CommonDefine.COMMON_LOCAL_RELIVE_NEED_ITEMS
    end
    return CommonDefine.COMMON_LOCAL_RELIVE_NEED_ITEMS[relivetimes]
end

--按照玩家的职业和性别，通用过滤table
function Player.FilterTable(actor, srctab)
    if BF_IsNullObj(actor) then
        return srctab
    end
    local targtab = {}
    local job = Player.GetJob(actor)
    local gender = Player.GetGender(actor)
    for _, singleitem in pairs(srctab) do
        if singleitem then
            local bIsValid = true
            if singleitem.job and (singleitem.job ~= CommonDefine.JOB_ALL) and (singleitem.job ~= job) then
                bIsValid = false
            end
            if singleitem.gender and (singleitem.gender ~= gender) then
                bIsValid = false
            end

            if bIsValid then
                targtab[#targtab+1] = singleitem
            end
        end
    end
    return targtab
end

--弹出玩家复活框
function Player.ShowReliveDialogue(actor, msg)    
    say(actor, msg)
    setflagstatus(actor, CommonDefine.VAR_HUM_BITFLAG_RELIVE_DIALOGUE_FLAG, 1)
end

--给界面元素增加小红点
function Player.AddRedPoint(actor, winid, buttonid, x, y)
    if not BF_IsNullObj(actor) then
        reddot(actor, winid, buttonid, x, y, 0, 'res/private/cc_common/redpoint.png')
    end
end

--删除界面元素的小红点，主要针对的是主界面
function Player.DelRedPoint(actor, winid, buttonid)
    if not BF_IsNullObj(actor) then
        reddel(actor, winid, buttonid)
    end
end

--检查货币数量
function Player.CheckMoneyNum(actor, moneytype, num)
    local moneynum = querymoney(actor, moneytype)
    --[[
    绑定元宝计算元宝
    if moneytype == ConstCfg.money.bdyb then
        moneynum = moneynum + querymoney(actor, ConstCfg.money.yb)
    end
    ]]--
    return moneynum >= num
end

--返回玩家背包中的物品或者虚拟货币数量
function Player.GetItemNumInBag(actor, nameOrIdx)
    if (actor == nil) or (nameOrIdx == nil) then
        return 0, ''
    end

    local itemidx = getstditeminfo(nameOrIdx, CommonDefine.STDITEMINFO_IDX)
    local itemname = getstditeminfo(nameOrIdx, CommonDefine.STDITEMINFO_NAME)
    if (itemidx==nil) or (itemname=='') or (itemidx==0) or (itemname=='') then
        return 0, ''
    end

    if Item.isCurrency(itemidx) then     
        --虚拟货币   
        return querymoney(actor, itemidx), itemname
    else  
        --道具和装备
        return getbagitemcount(actor, itemname), itemname
    end
end

--检查 物品 货币 装备是否满足数量 items = {[1]={name="XX", id=999, num=1}}  name 和 id 有一个就行
function Player.CheckItemsEnough(actor, checkitems, notifyreason, multiple)
    if (actor == nil) or (checkitems == nil) then
        return false
    end

    for _, checkitem in pairs(checkitems) do
        local nameOrIdx = checkitem.name
        if nameOrIdx == nil then
            nameOrIdx = checkitem.id
        end
        if nameOrIdx == nil then
            return false
        end
            
        local itemnum = checkitem.num
        if multiple then 
            itemnum = itemnum * multiple
        end

        local bagItemNum, needitemname = Player.GetItemNumInBag(actor, nameOrIdx);
        if bagItemNum < itemnum then
            if notifyreason and (notifyreason~='') and (needitemname~=nil) then
                Player.SendSelfMsg(actor, notifyreason..'所需的'..needitemname..'不足！', CommonDefine.MSG_POS_TYPE_SYS_CHANNEL)
            end
            return false
        end
    end

    return true
end

--拿走物品
function Player.TakeItems(actor, needitems, desc, multiple)
    if BF_IsNullObj(actor) or (needitems == nil) or (type(needitems) ~= 'table') then
        return
    end

    for _, item in pairs(needitems) do
        local nameOrIdx = item.name
        if nameOrIdx == nil then
            nameOrIdx = item.id
        end
        if nameOrIdx == nil then
            return
        end

        local itemnum = item.num
        if multiple then 
            itemnum = itemnum * multiple
        end

        local itemidx = getstditeminfo(nameOrIdx, CommonDefine.STDITEMINFO_IDX)
        local itemname = getstditeminfo(nameOrIdx, CommonDefine.STDITEMINFO_NAME)
        if (itemidx == 0) or (itemname == '') then
            return
        end

        if Item.isCurrency(itemidx) then       
            --虚拟货币 
            changemoney(actor, itemidx, "-", itemnum, desc, true)
        else
            --物品 装备
            takeitem(actor, itemname, itemnum)
        end
    end
end

--给与道具，背包不足进邮件
function Player.GiveItemsToBagOrMail(actor, rewarditems, desc)
    if BF_IsNullObj(actor) or (rewarditems == nil) or (type(rewarditems) ~= 'table') or (#rewarditems == 0) then
        BF_DebugOut('奖励为空：'..desc)
        return
    end

    local itemstr = '';
    for _, value in ipairs(rewarditems) do
        if itemstr ~= '' then
            itemstr = itemstr..'&'
        end
        --这里处理绑定状态！！！！！
        --这里处理绑定状态！！！！！
        --这里处理绑定状态！！！！！
        --这里处理绑定状态！！！！！
        --这里处理绑定状态！！！！！
        itemstr = itemstr..value.name..'#'..value.num
    end 
    if Bag.IsHaveEnoughBagSpace(actor, rewarditems) then
        --这里还是测试确认，如果背包满，但道具可以叠加的情况下，是否能给予成功！！！！！！！
        --这里还是测试确认，如果背包满，但道具可以叠加的情况下，是否能给予成功！！！！！！！
        --这里还是测试确认，如果背包满，但道具可以叠加的情况下，是否能给予成功！！！！！！！
        --这里还是测试确认，如果背包满，但道具可以叠加的情况下，是否能给予成功！！！！！！！
        --这里还是测试确认，如果背包满，但道具可以叠加的情况下，是否能给予成功！！！！！！！
        --这里还是测试确认，如果背包满，但道具可以叠加的情况下，是否能给予成功！！！！！！！
        --这里还是测试确认，如果背包满，但道具可以叠加的情况下，是否能给予成功！！！！！！！
        gives(actor, itemstr, desc)
    else
        local playerid = Player.GetPlayerID(actor)
        sendmail(playerid, CommonDefine.MAIL_ID_BAGFULL, "背包空间不足", desc, itemstr)
    end    
end

--给玩家发放道具邮件
function Player.GiveItemsByMail(actor, rewarditems, mailtitle, maildesc)
    if BF_IsNullObj(actor) or (rewarditems == nil) or (type(rewarditems) ~= 'table') or (#rewarditems == 0) then
        BF_DebugOut('奖励为空：'..mailtitle)
        return
    end

    local itemstr = '';
    for _, value in ipairs(rewarditems) do
        if itemstr ~= '' then
            itemstr = itemstr..'&'
        end
        --这里处理绑定状态！！！！！
        --这里处理绑定状态！！！！！
        --这里处理绑定状态！！！！！
        --这里处理绑定状态！！！！！
        --这里处理绑定状态！！！！！
        itemstr = itemstr..value.name..'#'..value.num
    end 

    local playerid = Player.GetPlayerID(actor)
    sendmail(playerid, CommonDefine.MAIL_ID_BAGFULL, mailtitle, maildesc, itemstr)    
    Player.SendSelfMsg(actor, '请查收邮件:'..mailtitle, CommonDefine.MSG_POS_TYPE_SYS_CHANNEL)
end

--返回玩家身上装备最低品质
function Player.GetAllEquipmentMinQualityLv(actor)
    if BF_IsNullObj(actor) then
        return -1
    end

    local minquality = 999
    for i = 1, #CommonDefine.BASE_EQUIPMENT_POS, 1 do
        local equipitem = linkbodyitem(actor, CommonDefine.BASE_EQUIPMENT_POS[i])
        if BF_IsNullObj(equipitem) then
            minquality = -1
            break
        end
        local itemquality = Item.GetItemQualityLv(actor, equipitem)
        if itemquality < minquality then
            minquality = itemquality
        end
    end
    if minquality == 999 then
        minquality = -1
    end
    return minquality
end

--判断玩家功能是否开启
function Player.IsFunctionOpen(actor, funcid, bNotify)
    if BF_IsNullObj(actor) then
        return false, 0
    end
    local currlv = Player.GetLevel(actor)
    for _, value in pairs(cfgFunctionCtrl) do
        if value.id == funcid then
            if currlv >= value.needlv then
                return true, 0
            else
                if bNotify == true then
                    local tempCurrX = CSS.NPC_LEFT_START_X
                    local tempCurrY = CSS.NPC_TOP_START_Y                    
                    local msg = '<Text|text=开启功能['..value.name..']，需要达到'..value.needlv..'级！|x='..(tempCurrX+100)..'|y='..(tempCurrY+100)..'|color='..CSS.NPC_WHITE..'>'
                    BF_NPCSayExt(actor, msg)
                end
                return false, value.needlv
            end
        end
    end
    return true, 0
end

--给个人发送消息
function Player.SendSelfMsg(actor, msg, postype,fcolor,bcolor)
    if (actor == nil) or (msg == nil) or (postype == nil) then
        return
    end
    local fontcolor = CSS.CHAT_RED
    if fcolor then
        fontcolor = fcolor
    end
    local backcolor = CSS.CHAT_WHITE
    if bcolor then
        backcolor = bcolor
    end
    sendmsg(actor, 1, '{"Msg":"'..msg..'","Type":'..postype..',"FColor":'..fontcolor..',"BColor":'..backcolor..'}')
end

--给全服发送消息
function Player.SendServerMsg(actor, msg, postype,fcolor,bcolor)
    if (actor == nil) or (msg == nil) or (postype == nil) then
        return
    end
    if fcolor==nil or bcolor==nil then
        sendmsg(actor, 2, '{"Msg":"'..msg..'","Type":'..postype..'}')
    else
        sendmsg(actor, 2, '{"Msg":"'..msg..'","Type":'..postype..',"FColor":'..fcolor..',"BColor":'..bcolor..'}')
    end
end

--给行会发送消息
function Player.SendGuildMsg(actor, msg, postype,fcolor,bcolor)
    if (actor == nil) or (msg == nil) or (postype == nil) then
        return
    end
    local fontcolor = CSS.CHAT_WHITE
    if fcolor then
        fontcolor = fcolor
    end
    local backcolor = CSS.CHAT_BLUE
    if bcolor then
        backcolor = bcolor
    end    
    sendmsg(actor, 3, '{"Msg":"'..msg..'","Type":'..postype..',"FColor":'..fontcolor..',"BColor":'..backcolor..'}')
end

--给地图发送消息
function Player.SendMapMsg(actor, msg, postype)
    if (actor == nil) or (msg == nil) or (postype == nil) then
        return
    end
    sendmsg(actor, 4, '{"Msg":"'..msg..'","Type":'..postype..'}')
end

--给组队发送消息
function Player.SendTeamMsg(actor, msg, postype)
    if (actor == nil) or (msg == nil) or (postype == nil) then
        return
    end
    sendmsg(actor, 5, '{"Msg":"'..msg..'","Type":'..postype..'}')
end

--初始化新玩家
function Player.InitNewPlayer(actor)
    if BF_IsNullObj(actor) then
        return
    end
    
    if getflagstatus(actor, CommonDefine.VAR_HUM_BITFLAG_NEW_PLAYER_INIT_FLAG) == 0 then
        setplaydef(actor, CommonDefine.VAR_J_DAY_MOFANG_LEFT_FREETIMES, CommonDefine.DAY_FREE_ENTER_MOFANGZHEN_TIMES)        
        setflagstatus(actor, CommonDefine.VAR_HUM_BITFLAG_NEW_PLAYER_INIT_FLAG, 1)

        --设置首次登录日期
        local currday = BF_GetDay(os.time())
        setplaydef(actor, CommonDefine.VAR_U_FIRST_LOGIN_DAY, currday)        

        --穿戴初始装备
        local job = Player.GetJob(actor)
        local gender = Player.GetGender(actor)
        if job == CommonDefine.JOB_Z then
            giveonitem(actor, CommonDefine.EQUIPPOS_WEAPON, '破损的锈铁刀', 1, 1, '出生给与')
            if gender == CommonDefine.GENDER_MAN then
                giveonitem(actor, CommonDefine.EQUIPPOS_DRESS, '破旧的粗布衣(男)', 1, 1, '出生给与')
            else
                giveonitem(actor, CommonDefine.EQUIPPOS_DRESS, '破旧的粗布衣(女)', 1, 1, '出生给与')
            end
        elseif job == CommonDefine.JOB_F then
            giveonitem(actor, CommonDefine.EQUIPPOS_WEAPON, '破损的木法杖', 1, 1, '出生给与')
            if gender == CommonDefine.GENDER_MAN then
                giveonitem(actor, CommonDefine.EQUIPPOS_DRESS, '破旧的纱布衣(男)', 1, 1, '出生给与')
            else
                giveonitem(actor, CommonDefine.EQUIPPOS_DRESS, '破旧的纱布衣(女)', 1, 1, '出生给与')
            end
        elseif job == CommonDefine.JOB_D then
            giveonitem(actor, CommonDefine.EQUIPPOS_WEAPON, '破损的木灵剑', 1, 1, '出生给与')
            if gender == CommonDefine.GENDER_MAN then
                giveonitem(actor, CommonDefine.EQUIPPOS_DRESS, '破旧的兽皮衣(男)', 1, 1, '出生给与')
            else
                giveonitem(actor, CommonDefine.EQUIPPOS_DRESS, '破旧的兽皮衣(女)', 1, 1, '出生给与')
            end
        end

        giveitem(actor, '随机传送石', 1, 1, '出生给与')
        giveitem(actor, '比奇传送石', 1, 1, '出生给与')
        giveitem(actor, '盟重回城石', 1, 1, '出生给与')
        giveitem(actor, '强化石', 200, 1, '出生给与')
        giveitem(actor, '太阳水', 50, 1, '出生给与')
        Player.SetLevel(actor, 1)
        SkillUpgrade.CheckAutoLearnSkill(actor)        

        Player.FullHPMP(actor)                
        TaskManager.AddNewTask(actor, CommonDefine.TASK_LINE_ID_MAIN, 0)

        --Player.GoMZHome(actor)
        mapmove(actor, '0', 651, 628, 3)
    end
end

function Player.TestSuperInitPlayer(actor)    
    if BF_IsNullObj(actor) then
        return
    end

    local QUICK_WEAR_EQUIPMENT = {
        [CommonDefine.JOB_Z] = {
            [CommonDefine.GENDER_MAN] = {'无双的冰霜巨剑', '无双的冰霜战甲(男)', '无双的冰霜头盔(战)', '无双的冰霜项链(战)', '无双的冰霜左戒指(战)', '无双的冰霜右戒指(战)', 
                                        '无双的冰霜左手镯(战)', '无双的冰霜右手镯(战)', '无双的冰霜腰带(战)', '无双的冰霜长靴(战)'},
            [CommonDefine.GENDER_WOMAN] = {'无双的冰霜巨剑', '无双的冰霜战甲(女)', '无双的冰霜头盔(战)', '无双的冰霜项链(战)', '无双的冰霜左戒指(战)', '无双的冰霜右戒指(战)',
                                        '无双的冰霜左手镯(战)', '无双的冰霜右手镯(战)', '无双的冰霜腰带(战)', '无双的冰霜长靴(战)'},
        },
        [CommonDefine.JOB_F] = {
            [CommonDefine.GENDER_MAN] = {'无双的冰霜法杖', '无双的冰霜战衣(男)', '无双的冰霜头盔(法)', '无双的冰霜项链(法)', '无双的冰霜左戒指(法)', '无双的冰霜右戒指(法)',
                                        '无双的冰霜左手镯(法)', '无双的冰霜右手镯(法)', '无双的冰霜腰带(法)', '无双的冰霜长靴(法)'},
            [CommonDefine.GENDER_WOMAN] = {'无双的冰霜法杖', '无双的冰霜战衣(女)', '无双的冰霜头盔(法)', '无双的冰霜项链(法)', '无双的冰霜左戒指(法)', '无双的冰霜右戒指(法)', 
                                        '无双的冰霜左手镯(法)', '无双的冰霜右手镯(法)', '无双的冰霜腰带(法)', '无双的冰霜长靴(法)'},
        },
        [CommonDefine.JOB_D] = {
            [CommonDefine.GENDER_MAN] = {'无双的冰霜灵剑', '无双的冰霜道衣(男)', '无双的冰霜头盔(道)', '无双的冰霜项链(道)', '无双的冰霜左戒指(道)', '无双的冰霜右戒指(道)', 
                                        '无双的冰霜左手镯(道)', '无双的冰霜右手镯(道)', '无双的冰霜腰带(道)', '无双的冰霜长靴(道)'},
            [CommonDefine.GENDER_WOMAN] = {'无双的冰霜灵剑', '无双的冰霜道衣(女)', '无双的冰霜头盔(道)', '无双的冰霜项链(道)', '无双的冰霜左戒指(道)', '无双的冰霜右戒指(道)', 
                                        '无双的冰霜左手镯(道)', '无双的冰霜右手镯(道)', '无双的冰霜腰带(道)', '无双的冰霜长靴(道)'},
        },
    }    

    --设置等级
    Player.SetLevel(actor, 80)

    --穿戴装备
    local job = Player.GetJob(actor)
    local gender = Player.GetGender(actor)
    local equiplist = QUICK_WEAR_EQUIPMENT[job][gender]
    if equiplist and #equiplist > 0 then
        for _, equipname in ipairs(equiplist) do
            local pos = BF_GetEquipPosByNameOrID(equipname)
            local newitem = giveitem(actor, equipname, 1, 0, 'GM测试')
            if newitem then
                EquipRandomABManager.InitEquipRandomAB(actor, newitem, math.random(1,2))
                local uniqueid = getiteminfo(actor, newitem, CommonDefine.ITEMINFO_UNIQUEID)
                takeonitem(actor, pos, uniqueid)
            end
        end
    end    
    Player.FullHPMP(actor)                 
end

--快捷前往
function Player.QuickGoTo(actor, gotoid)
    if BF_IsNullObj(actor) then
        return
    end

    --todo...................
    --todo...................
    --todo...................这里对于npc的引导需要换一个实现

    local currlv = Player.GetLevel(actor)
    if gotoid == CommonDefine.QUICK_GOTO_UPGRADE_LEVEL then
        --升级
        opennpcshowex(actor, 211, 3, 3)
    elseif gotoid == CommonDefine.QUICK_GOTO_INCREASE_POWER then
        --涨战力
        if currlv <= 40 then
            --强化大师
            opennpcshowex(actor, 200, 3, 3)
        elseif currlv <= 55 then
            --升星大师
            opennpcshowex(actor, 201, 3, 3)
        elseif currlv <= 60 then
            --洗炼大师
            opennpcshowex(actor, 203, 3, 3)
        elseif currlv <= 70 then
            --魂石大师
            opennpcshowex(actor, 208, 3, 3)
        else
            --灵玉尊者
            opennpcshowex(actor, 206, 3, 3)
        end        
    elseif gotoid == CommonDefine.QUICK_GOTO_KILL_RANDOMBOSS then
        --击杀战力boss
        opennpcshowex(actor, 212, 3, 3)
    elseif gotoid == CommonDefine.QUICK_GOTO_KILL_BAOZHUBOSS then
        --击杀宝珠【灵玉】boss
        opennpcshowex(actor, 207, 3, 3)
    elseif gotoid == CommonDefine.QUICK_GOTO_ENTER_MOFANGZHEN then
        --进入魔方阵
        opennpcshowex(actor, 211, 3, 3)
    elseif gotoid == CommonDefine.QUICK_GOTO_UPGRADE_EQUIPSTAR then
        --装备升星
        opennpcshowex(actor, 201, 3, 3)             
    elseif gotoid == CommonDefine.QUICK_GOTO_EQUIP_STRENGTH then
        --装备强化
        opennpcshowex(actor, 200, 3, 3)
    elseif gotoid == CommonDefine.QUICK_GOTO_EQUIP_QUALITY then
        --装备品质
        opennpcshowex(actor, 211, 3, 3)
    elseif gotoid == CommonDefine.QUICK_GOTO_EQUIP_RANDOMAB then
        --装备洗炼
        opennpcshowex(actor, 203, 3, 3)
    elseif gotoid == CommonDefine.QUICK_GOTO_EQUIP_COMPOSE then
        --装备合成
        opennpcshowex(actor, 205, 3, 3)           
    elseif gotoid == CommonDefine.QUICK_GOTO_SOULSTONE then
        --魂石系统
        opennpcshowex(actor, 208, 3, 3)
    elseif gotoid == CommonDefine.QUICK_GOTO_BAOZHU then
        --宝珠【灵玉】系统
        opennpcshowex(actor, 206, 3, 3)  
    elseif gotoid == CommonDefine.QUICK_GOTO_FREEVIP then
        --免费VIP系统
        opennpcshowex(actor, 213, 3, 3)
    elseif gotoid == CommonDefine.QUICK_GOTO_RECHARGE then
        --充值系统
        openhyperlink(actor, 26)
    elseif gotoid == CommonDefine.QUICK_GOTO_SINGLEBOSS then
        --个人首领
        opennpcshowex(actor, 223, 3, 3)
    elseif gotoid == CommonDefine.QUICK_GOTO_PUBLICBOSS then
        --野外首领
        opennpcshowex(actor, 224, 3, 3)
    elseif gotoid == CommonDefine.QUICK_GOTO_YUNBIAO then
        --运镖
        opennpcshowex(actor, 225, 3, 3)
    elseif gotoid == CommonDefine.QUICK_GOTO_TREASUREMAP then
        --藏宝图
        --????
    elseif gotoid == CommonDefine.QUICK_GOTO_GUANZHI then
        --官职
        opennpcshowex(actor, 209, 3, 3)
    elseif gotoid == CommonDefine.QUICK_GOTO_ZCD then
        --紫宸殿 离线护卫
        opennpcshowex(actor, 210, 3, 3)
    end          
end

--检测玩家装备，设置玩家的加速状态
function Player.CheckSpeedUpStatus(actor)
    if BF_IsNullObj(actor) then
        return
    end

    local FIRST_RECHARGE_SPEEDUP_WEAPON_ID = 15001
    local FIRST_RECHARGE_SPEEDUP_WEAPON_ADDNUM = 100

    local nSpeedUp = 0
    for i = 1, #CommonDefine.BASE_EQUIPMENT_POS, 1 do
        local equipitem = linkbodyitem(actor, CommonDefine.BASE_EQUIPMENT_POS[i])
        if not BF_IsNullObj(equipitem) then
            --判断首充道具
            local itemid = getiteminfo(actor, equipitem, CommonDefine.ITEMINFO_ITEMIDX)
            if itemid == FIRST_RECHARGE_SPEEDUP_WEAPON_ID then
                nSpeedUp = nSpeedUp + FIRST_RECHARGE_SPEEDUP_WEAPON_ADDNUM
            end

            --判断装备的天赋的加速属性
            local naddnum = getitemintparam(actor, -2, CommonDefine.ITEM_INTVAR_ATTACK_SPEEDUP_INITGIFT, equipitem)
            if naddnum ~= nil then 
                nSpeedUp = nSpeedUp + naddnum
            end
        end
    end

    changespeedex(actor, 2, nSpeedUp)
    changespeedex(actor, 3, nSpeedUp)
end

--[[
--获取创建角色天数
function Player.getCreateActorDay(actor)
    local openday = grobalinfo(ConstCfg.global.openday)
    local create_actor_openday = getplaydef(actor, VarCfg.U_create_actor_openday)
    local create_actor_day = openday - create_actor_openday + 1
    return create_actor_day
end

--检查 物品 货币 装备是否满足数量(数量不足返回不足物品的名字)
function Player.checkItemNumByTable(actor, t, multiple)
    for _,item in ipairs(t) do
        local idx,num = item[1],item[2]
        if multiple then num=num*multiple end

        local name = idx==ConstCfg.money.bdyb and "元宝" or getstditeminfo(idx, ConstCfg.stditeminfo.name)
        if Item.isCurrency(idx) then        --货币
            if not Player.checkMoneyNum(actor, idx, num) then
                return name, num
            end
        else                                    --物品 装备
            if not Bag.checkItemNumByIdx(actor, idx, num) then
                return name, num
            end
        end
    end
end

--描述：根据玩家guid与名字（name）获取物品数量
--luo获取玩家物品数量 1.guid 2.itemname 3.是否判断装备栏 返回值number 否则返回nil
function Player.libcheckItemNumByTableEx(actor, name, boolean)
    local idx = getstditeminfo(name, 0)  --根据name获取idx
    if idx ~= 0 then
        local count = 0
        local item_num = getbaseinfo(actor, ConstCfg.gbase.bag_num)   --获取背包物品数量
        for i=0, item_num-1 do
            local itemobj = getiteminfobyindex(actor, i)
            local itemidx = getiteminfo(actor, itemobj, ConstCfg.iteminfo.idx)  --获取背包物品idx
            if itemidx == idx then   --匹配idx
                local item_mun = getiteminfo(actor, itemobj, ConstCfg.iteminfo.overlap)  --注意堆叠
                if item_mun == 0 then   --堆叠为0 为不堆叠 数量为1
                    item_mun = 1
                end
                count = count + item_mun
            end
        end
        if boolean then  --是否包括装备栏
            local stdmode = getstditeminfo(idx, ConstCfg.stditeminfo.stdmode)  --获取装备类型
            local where = ConstCfg.stdmodewheremap[stdmode]   --获取装备位置
            local equipobj = linkbodyitem(actor, where)
            if equipobj ~= "0" then
                local equipidx = getiteminfo(actor, equipobj, ConstCfg.iteminfo.idx)
                if equipidx == idx then
                    count = count + 1
                end
            end

        end
        return count
    end
    return
end

-- local moneynum = querymoney(actor, moneytype)
--     if moneytype == ConstCfg.money.bdyb then
--         moneynum = moneynum + querymoney(actor, ConstCfg.money.yb)
--     end
--     return moneynum >= num

--拿走物品
function Player.takeItemByTable(actor, t, desc, multiple)
    for _,item in ipairs(t) do
        local idx,num = item[1],item[2]
        if multiple then num=num*multiple end
        if Item.isCurrency(idx) then        --货币
            if idx == 4 then  --游戏设定 绑定元宝不足扣除正常元宝
                local bdyb = querymoney(actor, 4)  
                if num > bdyb then    --所需元宝大于绑定元宝时
                    changemoney(actor, 4, "-", bdyb, desc, true)   --首先扣除所有绑定元宝
                    changemoney(actor, 2, "-", (num-bdyb), desc, true)  --正常元宝补充不足元宝
                end
            end
            changemoney(actor, idx, "-", num, desc, true)
        else                                    --物品 装备
            local name = getstditeminfo(idx, ConstCfg.stditeminfo.name)
            takeitem(actor, name, num)
        end
    end
end

--给物品
function Player.giveItemByTable(actor, t, desc, multiple, isbind)
    multiple = multiple or 1         --倍数

    for _,item in ipairs(t) do
        local idx,num,bind = item[1],item[2],item[3]
        if Item.isCurrency(idx) then        --货币
            changemoney(actor, idx, "+", num * multiple, desc, true)
        else                                    --物品 装备
            local name = getstditeminfo(idx, ConstCfg.stditeminfo.name)
            if bind or isbind then
                giveitem(actor, name, num * multiple, ConstCfg.binding)
            else
                giveitem(actor, name, num * multiple)
            end
        end
    end
end

--给物品盒子
function Player.giveItemBoxByIdx(actor, idx)
    local name = getstditeminfo(idx, ConstCfg.stditeminfo.name)
    giveitem(actor, name)
end

--获取当前穿戴装备的唯一id数组通过idx
function Player.getEquipIdsByIdx(actor, idx)
    if not Item.isEquip(idx) then return {} end

    local equipids = {}
    local wheres = Item.getWheresByIdx(idx)
    for _,where in ipairs(wheres) do
        local equipobj = linkbodyitem(actor, where)
        if equipobj ~= "0" then
            local equipidx = getiteminfo(actor, equipobj, ConstCfg.iteminfo.idx)
            if equipidx == idx then
                local equipmakeindex = getiteminfo(actor, equipobj, ConstCfg.iteminfo.id)
                table.insert(equipids, equipmakeindex)
            end
        end
    end
    return equipids
end

--获取装备位idx
function Player.getEquipPosIdx(actor, pos)
    local itemobj = linkbodyitem(actor, pos)
    if itemobj=="0" then return end
    local idx = getiteminfo(actor, itemobj, ConstCfg.iteminfo.idx)
    return idx
end


--更新属性
local _addrs = {}
function Player.updateAddr(actor, loginattrs)
    --引擎属性
    for attridx=1,250 do
        _addrs[attridx] = 0
    end

    for _,addr in ipairs(loginattrs) do
        for _,v in ipairs(addr) do
            local attridx = v[1]
            _addrs[attridx] = _addrs[attridx] + v[2]
        end
    end

    --附加引擎属性
    for attridx,value in ipairs(_addrs) do
        if value > 0 then
            changehumnewvalue(actor, attridx, _addrs[attridx], ConstCfg.attrtime)
        end
    end
end

--更新部分属性
function Player.updateSomeAddr(actor, cur_attr, next_attr)
    local newattr = {}
    if cur_attr then
        for _,attr in ipairs(cur_attr) do
            local attridx, attrvalue = attr[1], attr[2]
            newattr[attridx] = newattr[attridx] or gethumnewvalue(actor, attridx)
            newattr[attridx] = newattr[attridx] - attrvalue
            if newattr[attridx] < 0 then newattr[attridx] = 0 end
        end
    end

    -- LOGDump(newattr)

    if next_attr then
        for _,attr in ipairs(next_attr) do
            local attridx, attrvalue = attr[1], attr[2]
            newattr[attridx] = newattr[attridx] or gethumnewvalue(actor, attridx)
            newattr[attridx] = newattr[attridx] + attrvalue
        end
    end

    -- LOGDump(newattr)

    --cfg_att_score.xls 属性
    for attridx,attrvalue in pairs(newattr) do
        changehumnewvalue(actor, attridx, attrvalue, ConstCfg.attrtime)
    end
end

]]--

return Player