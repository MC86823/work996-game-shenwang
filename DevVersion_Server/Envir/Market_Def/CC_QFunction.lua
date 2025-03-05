require("Envir/QuestDiary/CCLua/GameInit")
UIncludes()

----------------------------------------------------------------系统触发回调函数start--------------------------------------------------------------------------

-- 玩家小退触发
function playreconnection(actor)
    --触发玩家退出游戏的事件监听
    GameEventManager.DoTriggerEvent(CommonDefine.EVENT_NAME_PLAYER_LEAVEGAME, actor) 
end

-- 玩家大退与关闭客户端触发
function playoffline(actor)
    --触发玩家退出游戏的事件监听
    GameEventManager.DoTriggerEvent(CommonDefine.EVENT_NAME_PLAYER_LEAVEGAME, actor) 
end

--跨周
local function cc_resetweek(actor)
    --清理周变量
    setplaydef(actor, CommonDefine.VAR_U_LOGINDAYS_IN_WEEK, 0)

    GameEventManager.DoTriggerEvent(CommonDefine.EVENT_NAME_PLAYER_RESETWEEK, actor) 
end

--跨天触发
function resetday(actor)
    local currweek = BF_GetWeek(os.time())
    local lastweek = getplaydef(actor, CommonDefine.VAR_U_LAST_RECORD_WEEK)
    if lastweek ~= currweek then
        setplaydef(actor, CommonDefine.VAR_U_LAST_RECORD_WEEK, currweek)
        cc_resetweek(actor)      
    end

    GameEventManager.DoTriggerEvent(CommonDefine.EVENT_NAME_PLAYER_RESETDAY, actor) 
end

--充值触发
function recharge(actor, gold, productid, moneyid, isreal, ordertime, rechargeamount, giftamount, refundamount)
    RechargeManager.DoRecharge(actor, gold, productid, moneyid, isreal, ordertime, rechargeamount, giftamount, refundamount)
end

--接收客户端消息触发
--[[
--暂时不做和客户端的独立消息处理
function handlerequest(actor, msgID, param1, param2, param3, str)
    ClientMsgProcess.DoProcess(actor, msgID, param1, param2, param3, str)
end
]]--

-- 人物属性改变时触发
function sendability(actor)
    --延迟展现战力变化，防止短时间触发多次
    delaygoto(actor, 100, "update_power_callback", 0)
end

-- 玩家升级触发
function playlevelup(actor) 
    SkillUpgrade.CheckAutoLearnSkill(actor)
    --延迟展现战力变化，防止短时间触发多次
    delaygoto(actor, 100, "update_power_callback", 0)    
end

-- 穿戴装备触发
function takeonex(actor, equipitem, pos, itemname, makeindex)
    if (actor == nil) or (equipitem == nil) or (pos == nil) then
        return
    end
    --根据装备位的强化等级 更新当前穿戴装备强化属性
    EquipPosStrengthManager.UpdateEquipStrengthLvInPos(actor, pos)    
    --根据装备位的星级 更新当前穿戴装备星级及属性 注意：强化在升星前
    EquipPosStarManager.UpdateEquipStarLvInPos(actor, pos)
    --检测加速状态
    Player.CheckSpeedUpStatus(actor)
end

-- 脱下装备触发
function takeoffex(actor, equipitem, pos, itemname, makeindex)
    if (actor == nil) or (equipitem == nil) or (pos == nil) then
        return
    end
    --清空脱掉装备的强化属性
    EquipPosStrengthManager.ClearEquipStrengthLv(actor, equipitem, pos)    
    --清空脱掉装备的星级属性
    EquipPosStarManager.ClearEquipStarLv(actor, equipitem, pos)    
    --检测加速状态
    Player.CheckSpeedUpStatus(actor)    
end

--玩家死亡 装备掉落前触发
function checkdropuseitems(actor, pos, itemidx)
    --清空脱掉装备的强化属性
    EquipPosStrengthManager.ClearEquipStrengthLvInPos(actor, pos)
    --清空脱掉装备的星级属性
    EquipPosStarManager.ClearEquipStarLvInPos(actor, pos)
    --检测加速状态
    Player.CheckSpeedUpStatus(actor)

    --暂时不改变掉落逻辑
    return true
end

--穿戴前触发 针对魂石的处理
function takeonbefore12(actor, itemobj)
    if not BF_IsNullObj(actor) and not BF_IsNullObj(itemobj) then
        local itemidx = getiteminfo(actor, itemobj, CommonDefine.ITEMINFO_ITEMIDX)
        local stdmode = getstditeminfo(itemidx, CommonDefine.STDITEMINFO_STDMODE)
        if stdmode == CommonDefine.ITEM_STDMODE_SOULSTONE then
            Player.QuickGoTo(actor, CommonDefine.QUICK_GOTO_SOULSTONE)
            Player.SendSelfMsg(actor, '请在魂石大师处进行魂石穿戴！', CommonDefine.MSG_POS_TYPE_SYS_CHANNEL)
            return false
        end
    end
    return true
end

-- 点击NPC
function clicknpc(actor, npcid)    
    GameEventManager.DoTriggerEvent(CommonDefine.EVENT_NAME_CLICK_NPC, actor, npcid)
end

-- 点击任务
function clicknewtask(actor, taskid)
    GameEventManager.DoTriggerEvent(CommonDefine.EVENT_NAME_CLICK_TASK, actor, taskid)
end

--道具进背包 这里是异步的
function addbag(actor, itemobj)
    --触发玩家道具进背包的事件监听
    GameEventManager.DoTriggerEvent(CommonDefine.EVENT_NAME_PLAYER_ADDBAGITEM, actor, itemobj)
end

--进入地图触发
function entermap(actor, mapid, x, y)
    GameEventManager.DoTriggerEvent(CommonDefine.EVENT_NAME_PLAYER_ENTERMAP, actor, mapid, x, y)
end

--离开地图触发
function leavemap(actor, mapid, x, y)
    GameEventManager.DoTriggerEvent(CommonDefine.EVENT_NAME_PLAYER_LEAVEMAP, actor, mapid, x, y)
end

--人物死亡触发
function playdie(actor, killer)
    setflagstatus(actor, CommonDefine.VAR_HUM_BITFLAG_RELIVE_DIALOGUE_FLAG, 0)
    GameEventManager.DoTriggerEvent(CommonDefine.EVENT_NAME_PLAYER_DIE, actor, killer)
    if getflagstatus(actor, CommonDefine.VAR_HUM_BITFLAG_RELIVE_DIALOGUE_FLAG) == 0 then
        local killername = ''
        if not BF_IsNullObj(killer) then
            killername = Player.GetName(killer)
        end
        local msg = '<Img|children={0,1,2,3}|a=1|x=737|y=201|reset=1|move=1|img=private/revive/bg_swfh_1.png|bg=1>'..
        '<Layout|id=0|width=348|height=200>'..
        '<Text|id=1|x=110|y=15|size=18|color='..CSS.NPC_WHITE..'|text=死亡复活>'..
        '<Text|id=2|x=85|y=55|size=16|color='..CSS.NPC_WHITE..'|text=你被 '..killername..' 杀死了！>'..        
        '<Button|id=3|x=110|y=90|pimg=public/1900000652.png|nimg=public/1900000653.png|color='..CSS.NPC_WHITE..'|size=17|text=回城复活|link=@common_relive_button>'
        Player.ShowReliveDialogue(actor, msg)
    end
end

--怪物被击杀触发  mapinfo对应地图要配置onkillmon才可以哦
function onkillmob(hitter, mon)
    GameEventManager.DoTriggerEvent(CommonDefine.EVENT_NAME_MON_KILLED, hitter, mon)    
end

--击杀玩家触发
function killplay(killer, deather)
    GameEventManager.DoTriggerEvent(CommonDefine.EVENT_NAME_KILL_PLAYER, killer, deather)
end

--任意地图击杀怪物触发
function killmon(actor, mon, killtype, monobjidstr, monname, mapidstr)
    GameEventManager.DoTriggerEvent(CommonDefine.EVENT_NAME_KILL_MON, actor, mon, killtype, monobjidstr, monname, mapidstr)    
end


----------------------------------------改名相关-----------------------------------------

--正在查询玩家名称
function queryinghumname(actor)
    Player.SendSelfMsg(actor, '正在查询请稍后。。。', CommonDefine.MSG_POS_TYPE_SYSTEM_TIPS)
end

--名称被过滤
function humnamefilter(actor)
    Player.SendSelfMsg(actor, '名称被过滤。。。', CommonDefine.MSG_POS_TYPE_SYSTEM_TIPS)
end

--长度不符合要求
function namelengthfail(actor)
    Player.SendSelfMsg(actor, '长度不符合要求', CommonDefine.MSG_POS_TYPE_SYSTEM_TIPS)
end

--名称已经存在
function humnameexists(actor)
    Player.SendSelfMsg(actor, '名称已经存在', CommonDefine.MSG_POS_TYPE_SYSTEM_TIPS)
end

--正在执行改名操作
function changeinghumname(actor)
    Player.SendSelfMsg(actor, '正在修改请稍后。。。', CommonDefine.MSG_POS_TYPE_SYSTEM_TIPS)
end

--改名成功
function changehumnameok(actor)
    local str = parsetext("你的名字修改成功，旧名称：<$USERNAME> 新名称：<$USERNEWNAME>！", actor)
    Player.SendSelfMsg(actor, str, CommonDefine.MSG_POS_TYPE_SYSTEM_TIPS)
end

--改名失败
function changehumnamefail(actor)
    Player.SendSelfMsg(actor, '修改名称失败', CommonDefine.MSG_POS_TYPE_SYSTEM_TIPS)
end

--------------------------------------------镖车功能相关----------------------
--镖车到达目标点
function carpathend(actor)    
    YunBiaoManager.OnArriveTargetPos(actor)
end

--玩家丢失镖车触发
function losercar(actor, biaoche)
    YunBiaoManager.LostBiaoChe(actor, biaoche)
end
--------------------------------------------伤害计算相关----------------------
--人物攻击前触发
function attackdamage(actor, target, hitter, magicid, damage, model)  
    --BF_DebugOut('damage:'..damage)    
    
    local bTargIsPlayer = false
    if not BF_IsNullObj(target) then
        bTargIsPlayer = Player.IsPlayer(target)
    end

    if bTargIsPlayer then
        local selfLevel = getplaydef(actor, CommonDefine.VAR_U_GUANZHI_LEVEL) 
        local targLevel = getplaydef(target, CommonDefine.VAR_U_GUANZHI_LEVEL) 
        if selfLevel > targLevel then
            damage = math.floor(damage * 1.1)
        end
    end
    return damage
end

----------------------------------------------------------------系统触发回调函数end--------------------------------------------------------------------------


----------------------------------------------------------------按钮回调函数start--------------------------------------------------------------------------

function mainuibase_openpanel(actor, sid)
    MainUIBase.OpenPanel(actor, sid)
end

function topicon_openpanel(actor, sid, sparam)
    TopIcon.OpenPanel(actor, sid, sparam)
end

function topicon_dogmoper(actor, sid)
    TopIcon.DoGmOper(actor, sid)
end

function baozhuboss_button(actor, sid)
    BaoZhuBossManager.DoMapButton(actor, sid)
end

function mofangzhen_button(actor, sid)
    MoFangZhenManager.DoMapButton(actor, sid)
end

function randomboss_button(actor, sid)
    RandomBossManager.DoMapButton(actor, sid)
end

function zcdmap_button(actor, sid)
    OfflineHuWeiManager.DoMapButton(actor, sid)
end

function common_relive_button(actor)
    realive(actor)
    Player.GoHome(actor)
end

function firstrecharge_button(actor, sid)
    FirstRecharge.DoOperButton(actor, sid)
end

function newplayer_recharge_button(actor, sid, sparam)
    ActivityNewPlayerRecharge.DoOperButton(actor, sid, sparam)
end

function openserver_button(actor, sid, sparam)
    ActivityOpenServer.DoOperButton(actor, sid, sparam)
end

function extendgift_button(actor, sid, sparam)
    ActivityExtendGift.DoOperButton(actor, sid, sparam)
end

function recyclemanager_button(actor, sid)
    RecycleManager.DoOperButton(actor, sid)
end

function set_recycle_option(actor, sid)
    RecycleManager.SetRecycleOption(actor, sid)
end

function publicboss_button(actor, sid)
    PublicBossManager.DoMapButton(actor, sid)
end

function singleboss_button(actor, sid)
    SingleBossManager.DoMapButton(actor, sid)
end

function everyday_task_button(actor, sid, sparam)
    EverydayTask.DoOperButton(actor, sid, sparam)
end

function treasuremap_button(actor, sid)
    TreasureMap.DoOperButton(actor, sid)
end

function changename_button(actor, sparam)
    if BF_IsNullObj(actor) or not BF_IsNumberStr(sparam) then
        return
    end
    local id = tonumber(sparam)
    if id == 1 then    
        local needitems = {{name='角色改名卡', num=1}}
        if not Player.CheckItemsEnough(actor, needitems, '角色改名') then
            return
        end    
        local sNewName = parsetext("<$NPCINPUT(1)>", actor)   
        local nNameLen = string.len(sNewName)
        if (nNameLen < 2) or (nNameLen > 14) then
            Player.SendSelfMsg(actor, '当前名字长度态度', CommonDefine.MSG_POS_TYPE_SYS_CHANNEL)
            return
        end

        if changehumname(actor, sNewName) == 0 then
            Player.TakeItems(actor, needitems, '角色改名')        
        end
    else
        close(actor)
    end
end
----------------------------------------------------------------按钮回调函数end--------------------------------------------------------------------------


----------------------------------------------------------------玩家延迟回调start------------------------------------------------------------------------
function treasuremap_dig_callback(actor)
    --藏宝图 挖宝回调
    TreasureMap.DigCallBack(actor)
end

local function InnerUpdatePowerShow(actor)
    delbutton(actor, 101, 999)
    local currpower = Player.GetPlayerPower(actor)
    local str = '<Img|id=5010|children={5011}|x=272|y=30|img=private/cc_mainui/zhanli.png>'..
        '<Text|id=5011|text='..currpower..'|x=100|y=16|color='..CSS.NPC_WHITE..'|size=25>'
    addbutton(actor, 101, 999, str)
end

function update_power_callback(actor)
    --更新玩家的战力变化
    local currpower = Player.GetPlayerPower(actor);
    local lastpower = getplaydef(actor, CommonDefine.VAR_N_LAST_PLAYERPOWER)
    if lastpower ~= currpower then
        local diffpower = currpower - lastpower
        setplaydef(actor, CommonDefine.VAR_N_LAST_PLAYERPOWER, currpower)
        Player.SendSelfMsg(actor, '当前战力:'..currpower, CommonDefine.MSG_POS_TYPE_SYS_CHANNEL)
        InnerUpdatePowerShow(actor)    
        if (diffpower > 0) and (lastpower > 0) then
            local showstr = '+'..diffpower
            local strPanelInfo = '<Img|id=5000|children={5001}|x=220|y=-240|img=private/cc_mainui/zhanli_tip.png>'..
                '<Text|id=5001|text='..showstr..'|x=100|y=28|color='..CSS.NPC_LIGHTGREEN..'|size=25>'
            addbutton(actor, 108, 998, strPanelInfo)
            delaygoto(actor, 3000, "hide_power_callback", 0)
        end
    end    
end

function hide_power_callback(actor)
    delbutton(actor, 108, 998)
end
----------------------------------------------------------------玩家延迟回调end--------------------------------------------------------------------------


----------------------------------------------------------------系统延迟回调start------------------------------------------------------------------------
function g_delay_RandomBossManager_ClearFightingMap(sysobj, mapidstr)
    RandomBossManager.ClearFightingMap(mapidstr)
end

function g_delay_SingleBossManager_ClearFightingMap(sysobj, mapidstr)
    SingleBossManager.ClearFightingMap(mapidstr)
end
----------------------------------------------------------------系统延迟回调end---------------------------------------------------------------------------



----------------------------------------------------------------使用道具回调start------------------------------------------------------------------------

function stdmodefunc0(actor, itemobj)
    return ItemUseManager.DoUse(actor, itemobj)
end

--随机传送石
function stdmodefunc10(actor, itemobj)
    return ItemUseManager.DoUse(actor, itemobj)
end

--比奇传送石
function stdmodefunc11(actor, itemobj)
    return ItemUseManager.DoUse(actor, itemobj)
end

--盟重回城石
function stdmodefunc12(actor, itemobj)
    return ItemUseManager.DoUse(actor, itemobj)
end

--使用藏宝图
function stdmodefunc201(actor, itemobj)
    return ItemUseManager.DoUse(actor, itemobj)
end

--使用可拆解兑换的道具
function stdmodefunc202(actor, itemobj)
    return ItemUseManager.DoUse(actor, itemobj)
end

--使用槽位直升星石
function stdmodefunc203(actor, itemobj)
    return ItemUseManager.DoUse(actor, itemobj)
end

--使用改名卡
function stdmodefunc204(actor, itemobj)
    return ItemUseManager.DoUse(actor, itemobj)
end

--使用魔方阵凭证
function stdmodefunc205(actor, itemobj)
    return ItemUseManager.DoUse(actor, itemobj)
end


----------------------------------------------------------------使用道具回调end--------------------------------------------------------------------------


--[[
[@PlayOffLine]
#IF
CheckRangeHumCount 3 330 330 20 < 120
#ACT
MOVR N50 323 339
MOVR N51 323 339
mapmove 3 <$STR(N50)> <$STR(N51)>
OFFLINEPLAY 72000 100
BREAK

[@OpenSndaItemBox]
#if
CHECKRENEWLEVEL > 0
#ACT
SetSndaItemBox 1 2 8888 4 5 6 7 8 6666 9 10
SENDMSG 6 已开启
break
#elseact
SendMsg 7 你转生等级不足1转！无法使用！
break

[@OnKillMob]
;RANDOM 300
;#act
;MOV U10 <$x>
;MOV U11 <$Y>
;MOV T10 <$MAP>
;mapmove 验证3530054 28 28
;SENDMSG 6 {ぐ〖提示〗:|251:0:0}{您触发防脱机验证系统：|222:0}{请站在光圈内点击NPC!验证成功送您回原坐标点|222:0}
;SENDMSG 6 {ぐ〖提示〗:|251:0:0}{您触发防脱机验证系统：|222:0}{请站在光圈内点击NPC!验证成功送您回原坐标点|222:0}
;SENDMSG 6 {ぐ〖提示〗:|251:0:0}{您触发防脱机验证系统：|222:0}{请站在光圈内点击NPC!验证成功送您回原坐标点|222:0}
;SENDMSG 6 {ぐ〖提示〗:|251:0:0}{您触发防脱机验证系统：|222:0}{请站在光圈内点击NPC!验证成功送您回原坐标点|222:0}


[@KillPlay]
#IF
CHECKLEVELEX > 0
#act
CALCVAR HUMAN KP + 1
SAVEVAR HUMAN KP
;-----------------------------------------------------------------------------------------------------------------
[@PlayLevelUp]
#IF
CHECKLEVELEX = 50
#ACT
GIVE 快捷功能 1
GIVE 一键回收 1
GIVE 随身仓库 1
GIVE 盟重回城石 1
GIVE 随机传送石 1
break
;-----------------------------------------------------------------------------------------------------------------
[@PlayDie]
#IF
CHECKITEMW 死也不爆 1
#ACT
TakeEx 9
take 死也不爆 46
ThrowItem <$MAP> <$X> <$Y> 1 死也不爆 1|60 1 1

#IF
check [059] 1
CHECKCURRTARGETRACE = 0
#ACT
<$CURRRTARGETNAME>.GAMEGOLD + 100000
SET [059] 0
SETICON 1 -1
SendCenterMsg 250 0 战报：【<$CURRRTARGETNAME>】干掉了拥有【天神下凡】的[<$USERNAME>]获得100000元宝奖励！！ 1 3
SendCenterMsg 250 0 战报：【<$CURRRTARGETNAME>】干掉了拥有【天神下凡】的[<$USERNAME>]获得100000元宝奖励！！ 1 3
SendCenterMsg 250 0 战报：【<$CURRRTARGETNAME>】干掉了拥有【天神下凡】的[<$USERNAME>]获得100000元宝奖励！！ 1 3




#IF
KILLBYHUM
#ACT
CALCVAR HUMAN PD + 1
SAVEVAR HUMAN PD
SendCenterMsg 250 0 战报：【<$CURRRTARGETNAME>】在%m手起刀落，干掉了<$USERNAME>，兄弟们帮忙打个120急救！ 1 3
#CALL [\游戏登陆\封号系统.txt] @封号分类


#ELSEACT
SENDMSG 1 提示:怪物【<$CURRRTARGETNAME>】在:%m(%x:%y)把玩家<$USERNAME>干掉了！
BREAK




;-----------------------------------------------------------------------------------------------------------------
[@StdModeFunc17]
#IF
#ACT
give 金砖 2
BREAK

[@StdModeFunc16]
#IF
#ACT
give 金条 5
BREAK

[@StdModeFunc15]
#IF
checkgold 49000001
#ACT
give 金条 1
messagebox 提示：你身上携带的金钱太多了.无法进行兑换.
BREAK
#ELSEACT
give 金币 998000
SENDMSG 7 恭喜：增加了100W金币.
BREAK

[@STDMODEFUNC9]
#IF
gender woman
#ACT
HAIRSTYLE 1
SENDMSG 7 发型已经变更!
BREAK
#IF
gender man
#ACT
HAIRSTYLE 1
SENDMSG 7 发型已经变更!
BREAK

[@STDMODEFUNC10]
#IF
gender woman
#ACT
HAIRSTYLE 0
SENDMSG 7 发型已经变更!
BREAK
#IF
gender man
#ACT
HAIRSTYLE 0
SENDMSG 7 发型已经变更!
BREAK

[@STDMODEFUNC11]
#IF
#ACT
KILLMONEXPRATE 200 7200
Gmexecute showeffect 76
SENDMSG 0 玩家「<$USERNAME>」使用双倍卷轴，获得了2小时双倍时间。


[@STDMODEFUNC12]
#IF
#ACT
KILLMONEXPRATE 200 3600
Gmexecute showeffect 76
SENDMSG 0 玩家「<$USERNAME>」使用双倍宝典(小)，获得了1小时双倍时间。


[@STDMODEFUNC13]
#IF
#ACT
KILLMONEXPRATE 200 10800
Gmexecute showeffect 76
SENDMSG 0 玩家「<$USERNAME>」使用双倍宝典(中)，获得了3小时双倍时间。


[@STDMODEFUNC14]
#IF
#ACT
KILLMONEXPRATE 200 21600
Gmexecute showeffect 76
SENDMSG 0 玩家「<$USERNAME>」使用双倍宝典(大)，获得了6小时双倍时间。


[@StdModeFunc15]
#IF
#ACT
Gmexecute showeffect 79
SENDMSG 0 <$USERNAME>在:%m%x:%y处放烟花咯、大家快去欣赏哦。

[@StdModeFunc16]
#IF
#ACT
Gmexecute showeffect 80
SENDMSG 0 <$USERNAME>在:%m%x:%y处放烟花咯、大家快去欣赏哦。

[@StdModeFunc17]
#IF
#ACT
Gmexecute showeffect 81
SENDMSG 0 <$USERNAME>在:%m%x:%y处放烟花咯、大家快去欣赏哦。

[@StdModeFunc18]
#IF
#ACT
Gmexecute showeffect 82
SENDMSG 0 <$USERNAME>在:%m%x:%y处放烟花咯、大家快去欣赏哦。

[@StdModeFunc19]
#IF
#ACT
Gmexecute showeffect 83
SENDMSG 0 <$USERNAME>在:%m%x:%y处放烟花咯、大家快去欣赏哦。

[@StdModeFunc20]
#IF
#ACT
Gmexecute showeffect 84
SENDMSG 0 <$USERNAME>在:%m%x:%y处放烟花咯、大家快去欣赏哦。

[@StdModeFunc21]
#IF
#ACT
Gmexecute showeffect 85
SENDMSG 0 <$USERNAME>在:%m%x:%y处放烟花咯、大家快去欣赏哦。

[@StdModeFunc41]
#IF
small M3 60
#Act
INC M3 2
Gmexecute showeffect 79
Gmexecute showeffect 80
Gmexecute showeffect 81
Delaygoto 2000 @庆典蛋糕1
SENDMSG 0 <$USERNAME>在:%m%x:%y处放庆典蛋糕了!大家快去看拉
#ELSEAct
MOV M3 0

[@庆典蛋糕1]
#IF
small M3 60
#Act
INC M3 2
Gmexecute showeffect 80
Gmexecute showeffect 81
Gmexecute showeffect 82
Delaygoto 2000 @庆典蛋糕2
SENDMSG 0 <$USERNAME>在:%m%x:%y处放庆典蛋糕了!大家快去看拉
#ELSEAct
MOV M3 0

[@庆典蛋糕2]
#IF
small M3 60
#Act
INC M3 2
Gmexecute showeffect 81
Gmexecute showeffect 82
Gmexecute showeffect 83
Delaygoto 2000 @庆典蛋糕3
SENDMSG 0 <$USERNAME>在:%m%x:%y处放庆典蛋糕了!大家快去看拉
#ELSEAct
MOV M3 0

[@庆典蛋糕3]
#IF
small M3 60
#Act
INC M3 2
Gmexecute showeffect 82
Gmexecute showeffect 83
Gmexecute showeffect 84
Delaygoto 2000 @庆典蛋糕4
SENDMSG 0 <$USERNAME>在:%m%x:%y处放庆典蛋糕了!大家快去看拉
#ELSEAct
MOV M3 0

[@庆典蛋糕4]
#IF
small M3 60
#Act
INC M3 2
Gmexecute showeffect 83
Gmexecute showeffect 84
Gmexecute showeffect 85
Delaygoto 2000 @庆典蛋糕5
SENDMSG 0 <$USERNAME>在:%m%x:%y处放庆典蛋糕了!大家快去看拉
#ELSEAct
MOV M3 0

[@庆典蛋糕5]
#IF
small M3 60
#Act
INC M3 2
Gmexecute showeffect 79
Gmexecute showeffect 84
Gmexecute showeffect 85
Delaygoto 2000 @庆典蛋糕6
SENDMSG 0 <$USERNAME>在:%m%x:%y处放庆典蛋糕了!大家快去看拉
#ELSEAct
MOV M3 0

[@庆典蛋糕6]
#IF
small M3 60
#Act
INC M3 2
Gmexecute showeffect 79
Gmexecute showeffect 80
Gmexecute showeffect 85
Delaygoto 2000 @庆典蛋糕
SENDMSG 0 <$USERNAME>在:%m%x:%y处放庆典蛋糕了!大家快去看拉
#ELSEAct
MOV M3 0

[@StdModeFunc29]
#IF
#ACT
mapmove 0 326 272

[@StdModeFunc30]
#IF
#ACT
mapmove 3 330 330
SendCenterMsg 180 251 还剩余%d离开本地图. 5 0 @ExitMap
[@StdModeFunc99]

[@RevMaster]
对方想拜你为师，你是否想收此人为徒？ \ \
『<同意/@ResposeMaster>』 \
『<不同意/@ResposeMasterFail>』

[@ResposeMaster]
#IF
#ACT
master responsemaster1 ok
close

[@ResposeMasterFail]
#if
#act
master responsemaster1 fail

[@EndMaster]
#if
#act
SENDMSG 0 %s完成了拜师收徒仪式!

[@EndMasterFail]
拜师失败！\ \
〖<关闭/@exit>〗

[@RevUnMaster]
对方向你请求脱离师徒关系，你是否答应？ \ \
『<我愿意/@ResposeUnMaster>』
〖<退出/@Exit>〗

[@ResposeUnMaster]
#if
#act
unmaster REQUESTUNMASTER MASTER

[@PoseUnMasterEnd]
呵呵，你已经与徒弟脱离师徒关系了！！！ \ \
『<退出/@exit>』

[@RequestUnMasterEnd]
呵呵，你已经脱离师徒关系了！！！ \ \
『<退出/@exit>』
;-----------------------------------------------------------------------------------------------------------------
[@GroupItem0]
#IF
#ACT
SENDMSG 5 圣战套装隐藏属性被激发,攻击提升15%!

[@GroupItem1]
#IF
#ACT
SENDMSG 5 法神套装隐藏属性被激发:魔法提升15%!

[@GroupItem2]
#IF
#ACT
SENDMSG 5 天尊套装隐藏属性被激发!道术提升15%!

[@GroupItem3]
#IF
#ACT
SENDMSG 5 属性生效:头盔一顶攻击上限增加1%!

[@GroupItem4]
#IF
#ACT
SENDMSG 5 属性生效:头盔一顶魔法上限增加1%!

[@GroupItem5]
#IF
#ACT
SENDMSG 5 属性生效:头盔一顶道术上限增加1%!

[@GroupItem6]
#IF
#ACT
SENDMSG 5 衣服属性生效:攻击上限增加3%，体力恢复增加1%魔法恢复增加1%。

[@GroupItem7]
#IF
#ACT
SENDMSG 5 衣服属性生效:攻击上限增加3%，体力恢复增加1%魔法恢复增加1%。

[@GroupItem8]
#IF
#ACT
SENDMSG 5 衣服属性生效:道术上限增加3%，体力恢复增加1%魔法恢复增加1%。

[@GroupItem9]
#IF
#ACT
SENDMSG 5 衣服属性生效:道术上限增加3%，体力恢复增加1%魔法恢复增加1%。

[@GroupItem10]
#IF
#ACT
SENDMSG 5 衣服属性生效:魔法上限增加3点，HP增加20%，体力恢复增加1%魔法恢复增加1%。

[@GroupItem11]
#IF
#ACT
SENDMSG 5 衣服属性生效:魔法上限增加3点，HP增加20%，体力恢复增加1%魔法恢复增加1%。
;-----------------------------------------------------------------------------------------------------------------
[@PD001]
#if
EQUAL I66 1
#act
SetOnTimer 5 1
;SENDMSG 0 玩家[<$USERNAME>]占领激情派对一号点，经验增加30万，元宝增加20个！
BREAK

[@PD002]
#if
EQUAL I66 1
#act
SetOnTimer 5 1
;SENDMSG 0 玩家[<$USERNAME>]占领激情派对二号点，经验增加20万，元宝增加15个！
BREAK

[@PD003]
#if
EQUAL I66 1
#act
SetOnTimer 5 1
;SENDMSG 0 玩家[<$USERNAME>]占领激情派对三号点，经验增加10万，元宝增加10个！
BREAK
;-----------------------------------------------------------------------------------------------------------------
[@StorageOpenFail2]
#IF
#ACT
MESSAGEBOX 仓库二无法打开,单击确认后开启，需要元宝1000 @开启仓库二 @取消

[@开启仓库二]
#IF
CHECKGAMEGOLD > 999
#ACT
GAMEGOLD - 1000
;SETSTORAGEOPEN 20130801 20130802 20130803 20130804 2 20130806 20130807 20130808 1 20130810
CHANGESTORAGE 40;开启仓库二命令
MESSAGEBOX 仓库二已解锁
#ELSEACT
MESSAGEBOX 元宝不够

;仓库三未开启时，从该仓库取物品或存物品会失败，并且触发QF脚本字段
[@StorageOpenFail3]
#IF
#ACT
MESSAGEBOX 仓库三无法打开,单击确认后开启，需要元宝2000 @开启仓库三 @取消

[@开启仓库三]
#IF
CHECKGAMEGOLD > 1999
#ACT
GAMEGOLD - 2000
;SETSTORAGEOPEN 20130801 20130802 20130803 20130804 3 20130806 20130807 20130808 1 20130810
CHANGESTORAGE 40;开启仓库三命令
MESSAGEBOX 仓库三已解锁
#ELSEACT
MESSAGEBOX 元宝不够
;-----------------------------------------------------------------------------------------------------------------
[@QueryingHumName]
正在查询请稍后。。。\ \
<关闭/@exit>\

[@QueryHumNameOK]
查询成功，该名称可以使用\ \
<关闭/@exit>\

[@ChangeingHumName]
正在修改请稍后。。。\ \
<关闭/@exit>\

[@ChangeHumNameOK]
你的名字修改成功，旧名称：<$USERNAME> 新名称：<$USERNEWNAME>！\ \
<关闭/@exit>\

[@NameLengthFail]
名字长度不允许超过30个字符！\ \
<关闭/@exit>\

[@HumNameFilter]
该名字存在非法字符！\ \
<关闭/@exit>\

[@HumNameExists]
该名字已经被其他玩家占用，请选择其他名字\ \
<关闭/@exit>\

[@ChangeHumNameFail]
改名失败！\ \
<关闭/@exit>\
;-----------------------------------------------------------------------------------------------------------------
[@StdModeFunc69]
#if
#ACT
CHANGEEXP + 100000000
SENDMSG 6 {ぐ〖提示〗:|251:0:0}{成功获得经验值|255:0}{1亿|222:0}
BREAK
[@StdModeFunc70]
#if
#ACT
CHANGEEXP + 10000000
SENDMSG 6 {ぐ〖提示〗:|251:0:0}{成功获得经验值|255:0}{1000W|222:0}
BREAK
[@StdModeFunc71]
#if
#ACT
CHANGEEXP + 20000000
SENDMSG 6 {ぐ〖提示〗:|251:0:0}{成功获得经验值|255:0}{2000W|222:0}
BREAK
[@StdModeFunc72]
#if
#ACT
CHANGEEXP + 30000000
SENDMSG 6 {ぐ〖提示〗:|251:0:0}{成功获得经验值|255:0}{3000W|222:0}
BREAK
[@StdModeFunc73]
#if
#ACT
CHANGEEXP + 50000000
SENDMSG 6 {ぐ〖提示〗:|251:0:0}{成功获得经验值|255:0}{5000W|222:0}
BREAK
[@StdModeFunc75]
#if
#ACT
CHANGEEXP + 200000000
SENDMSG 6 {ぐ〖提示〗:|251:0:0}{成功获得经验值|255:0}{2亿经验|222:0}
BREAK
[@StdModeFunc76]
#if
#ACT
CHANGEEXP + 500000000
SENDMSG 6 {ぐ〖提示〗:|251:0:0}{成功获得经验值|255:0}{5亿经验|222:0}
BREAK
[@StdModeFunc77]
#if
#ACT
CHANGEEXP + 1000000
SENDMSG 6 {ぐ〖提示〗:|251:0:0}{成功获得经验值|255:0}{100W|222:0}
BREAK
[@StdModeFunc78]
#if
#ACT
CHANGEEXP + 2000000
SENDMSG 6 {ぐ〖提示〗:|251:0:0}{成功获得经验值|255:0}{200W|222:0}
BREAK
[@StdModeFunc79]
#if
#ACT
CHANGEEXP + 5000000
SENDMSG 6 {ぐ〖提示〗:|251:0:0}{成功获得经验值|255:0}{500W|222:0}
BREAK

[@StdModeFunc188]
#if
#ACT
CHANGEEXP + 200000
SENDMSG 6 {ぐ〖提示〗:|251:0:0}{成功获得经验值|255:0}{20W|222:0}
BREAK

[@StdModeFunc189]
#if
#ACT
CHANGEEXP + 500000
SENDMSG 6 {ぐ〖提示〗:|251:0:0}{成功获得经验值|255:0}{50W|222:0}
BREAK

[@StdModeFunc80]
#ACT
GAMEGOLD + 20
SENDMSG 7 恭喜您20元宝已到帐户中.
[@StdModeFunc81]
#ACT
GAMEGOLD + 50
SENDMSG 7 恭喜您50元宝已到帐户中.
[@StdModeFunc59]
#ACT
GAMEGOLD + 100
SENDMSG 7 恭喜您100元宝已到帐户中.
[@StdModeFunc60]
#ACT
GAMEGOLD + 200
SENDMSG 7 恭喜您200元宝已到帐户中.
[@StdModeFunc61]
#ACT
GAMEGOLD + 500
SENDMSG 7 恭喜您500元宝已到帐户中.
[@StdModeFunc62]
#ACT
GAMEGOLD + 1000
SENDMSG 7 恭喜您1000元宝已到帐户中.
[@StdModeFunc63]
#ACT
GAMEGOLD + 2000
SENDMSG 7 恭喜您2000元宝已到帐户中.
[@StdModeFunc64]
#ACT
GAMEGOLD + 5000
SENDMSG 7 恭喜您5000元宝已到帐户中.
[@StdModeFunc65]
#ACT
GAMEGOLD + 10000
SENDMSG 7 恭喜您10000元宝已到帐户中.
[@StdModeFunc66]
#ACT
GAMEGOLD + 20000
SENDMSG 7 恭喜您20000元宝已到帐户中.
[@StdModeFunc67]
#ACT
GAMEGOLD + 50000
SENDMSG 7 恭喜您50000元宝已到帐户中.
[@StdModeFunc68]
#ACT
GAMEGOLD + 100000
SENDMSG 7 恭喜您100000元宝已到帐户中.

[@StdModeFunc53]
#ACT
GAMEPOINT + 1
GAMEGIRD + 1
break

[@StdModeFunc54]
#ACT
GAMEPOINT + 5
GAMEGIRD + 5
break

[@StdModeFunc55]
#ACT
GAMEPOINT + 10
GAMEGIRD + 10
break

[@StdModeFunc74]
#IF
CheckHumInRange 3 633 278 5
#ACT
GIVE 皇宫集结令 1
SENDMSG 7 错误：沙皇宫阁楼禁止使用集结令。
BREAK


#IF
;IsOnMap 0150
HaveGuild
#ACT
MOV A91 <$GUILDNAME>
MOV A92 <$USERNAME>
Gmexecute 开始提问 @行会召唤
SENDMSG 7 集结令已放出，请等待你的援军
SENDMSG 7 集结令已放出，请等待你的援军
#ELSEACT
GIVE 皇宫集结令 1
SENDMSG 7 错误：只可以在皇宫内使用集结令，暂时无法使用集结令
BREAK

[@StdModeFunc82]
#IF
CHECKSKILL 烈火剑法 < 3 1
#ACT
SKILLLEVEL 烈火剑法 + 1 1
SENDMSG 6 烈火剑法修炼强化加1重.最高3重！

[@StdModeFunc83]
#IF
CHECKSKILL 魔法盾 < 3 1
#ACT
SKILLLEVEL 魔法盾 + 1 1
SENDMSG 6 魔法盾修炼强化加1重.最高3重！

[@StdModeFunc84]
#IF
CHECKSKILL 灵魂火符 < 3 1
#ACT
SKILLLEVEL 灵魂火符 + 1 1
SENDMSG 6 灵魂火符修炼强化加1重.最高3重！

[@StdModeFunc85]
#IF
#ACT
GAMEGIRD + 10
SENDMSG 6 灵符增加10个！！
BREAK
[@StdModeFunc86]
#IF
#ACT
GAMEGIRD + 50
SENDMSG 6 灵符增加50个！！
BREAK
[@StdModeFunc87]
#IF
#ACT
GAMEGIRD + 100
SENDMSG 6 灵符增加100个！！
BREAK
[@StdModeFunc88]
#IF
#ACT
GAMEGIRD + 500
SENDMSG 6 灵符增加500个！！
BREAK
[@StdModeFunc89]
#IF
#ACT
GAMEGIRD + 1000
SENDMSG 6 灵符增加1000个！！
BREAK

[@StdModeFunc90]
#ACT
RESTBONUSPOINT
SENDMSG 7 你的属性已还原！
break

[@StdModeFunc91]
#act
CHANGEPKPOINT = 0
SENDMSG 7 我已经帮你减轻你的罪孽！好好做人哦！
close

[@StdModeFunc92]
#act
#CALL [\游戏功能\装备回收.txt] @开始回收
GIVE 一键回收 1
BREAK

[@StdModeFunc93]
#act
#CALL [\游戏功能\快捷功能.txt] @服务功能
GIVE 快捷功能 1
BREAK

[@StdModeFunc94]
\
\
<进入随身仓库/@storage>\
<进入随身仓库/@storage>\
<进入随身仓库/@storage>\
<进入随身仓库/@storage>\
#ACT
GIVE 随身仓库 1
BREAK

[@StdModeFunc95]
#if
;CHECKITEMADDVALUE 1 3 < 7
CHECKITEMADDVALUE 1 5 < 7
#act
;CHANGEITEMADDVALUE 1 3 + 1
CHANGEITEMADDVALUE 1 5 + 1
SENDMSG 6 武器幸运最高+7点！
BREAK

[@StdModeFunc96]
#if
#act
MessageBox \ \需要收取5000元宝手续费\ \成功武器【攻击伤害几率增加1%】\ \失败武器【攻击伤害几率清零】 @确22定 @取消22


[@确22定]
#if
CHECKBAGSIZE 2
CHECKGAMEGOLD > 4999
#ACT
goto @112
#elseact
GIVE 武器精炼油 1
MESSAGEBOX 身上的空格不够2个或者你没有5000元宝！
break


[@取消22]
#if
#ACT
GIVE 武器精炼油 1
break

[@112]
#if
random 2
#act
GAMEGOLD - 5000
SetNewItemValue 1 1 = 0
MESSAGEBOX 很遗憾,失败,元素清除！
BREAK

#if
random 1
CHECKNEWITEMVALUE 1 1 < 5
#act
GAMEGOLD - 5000
SetNewItemValue 1 1 + 1
MESSAGEBOX 成功！
BREAK

[@StdModeFunc97]
#if
#act
MessageBox \ \需要收取5000元宝手续费\ \成功武器【暴击几率增加1%】\ \失败武器【暴击几率清零】 @确11定 @取消11


[@取消11]
#if
#ACT
GIVE 武器暴击油 1
break

[@确11定]
#if
CHECKBAGSIZE 2
CHECKGAMEGOLD > 4999
#ACT
goto @1121
#elseact
GIVE 武器暴击油 1
MESSAGEBOX 身上的空格不够2个或者你没有5000元宝！
break

[@1121]
#if
random 3
CHECKNEWITEMVALUE 1 0 < 10
#act
GAMEGOLD - 5000
SetNewItemValue 1 0 + 1
MESSAGEBOX 成功！
BREAK

#if
random 2
CHECKNEWITEMVALUE 1 0 < 10
#act
GAMEGOLD - 5000
SetNewItemValue 1 0 + 1
MESSAGEBOX 成功！
BREAK

#if
random 1
#act
GAMEGOLD - 5000
SetNewItemValue 1 0 = 0
MESSAGEBOX 很遗憾,失败,元素清除！
BREAK

[@StdModeFunc98]
#if
check [60] 0
#ACT
SET [60] 1
MESSAGEBOX 恭喜你成为本服的会员玩家，再次使用会员卡可查看会员功能！！
BREAK

#if
check [60] 1
#SAY
\
{                   ◆<$SERVERNAME>◆/AUTOCOLOR=209,253,254,252,215,95,252,247}\
<━━━━━━━━━━━━━━━━━━━━━━━━━━━━━/FCOLOR=58>\
<★★/FCOLOR=250><清洗红名/@清洗红名><★★/FCOLOR=250>          <★★/FCOLOR=249><装备特修/@装备特修><★★/FCOLOR=249> \ \
<★★/FCOLOR=250><每日福利/@每日福利><★★/FCOLOR=250>　        <★★/FCOLOR=250><转职变性/@转职变性><★★/FCOLOR=250>          \ \
\　            <★★/FCOLOR=250><聊天颜色/@聊天颜色><★★/FCOLOR=250>          \ \
<━━━━━━━━━━━交流群:无管理━━━━━━━━━━/FCOLOR=58>\


[@聊天颜色]
\ \
会员提供聊天字体彩色独特功能。\ \
<点击/@254><变色/FCOLOR=254>     <点击/@253><变色/FCOLOR=253>      <点击/@252><变色/FCOLOR=252>\ \
<点击/@251><变色/FCOLOR=251>     <点击/@250><变色/FCOLOR=250>      <点击/@249><变色/FCOLOR=249>\ \
<点击/@70><变色/FCOLOR=70>     <点击/@31><变色/FCOLOR=31>      <点击/@161><变色/FCOLOR=161>\ \



[@161]
#IF
#ACT
ChangeHearMsgColor 100 161

[@31]
#IF
#ACT
ChangeHearMsgColor 100 31

[@70]
#IF
#ACT
ChangeHearMsgColor 100 70


[@249]
#IF
#ACT
ChangeHearMsgColor 100 249



[@250]
#IF
#ACT
ChangeHearMsgColor 100 250


[@251]
#IF
#ACT
ChangeHearMsgColor 100 251


[@252]
#IF
#ACT
ChangeHearMsgColor 100 252



[@253]
#IF
#ACT
ChangeHearMsgColor 100 253

[@254]
#IF
#ACT
ChangeHearMsgColor 100 254




[@转职变性]
{　    ◆<$SERVERNAME>◆/AUTOCOLOR=209,253,254,252,215,95,252,247}            <转职变性会员减半/FCOLOR=254>\
<━━━━━━━━━━━━━━━━━━━━━━━━━━━━━/FCOLOR=58>\
<变成帅哥/@toman1>                        <变成美女/@towoman1>  \
<非会员2万.会员1万元宝/FCOLOR=168> \ \

<转职战士/@战士1>              <转职法师/@法师1>             <转职道士/@道士1>  \
<非会员15万.会员10万元宝/FCOLOR=253>\
<---------------------------------------------------------->\

<返回上一页/@main>             <点我关闭/@exit> \
[@道士1]
#if
check [60] 1
checkjob taoist
#Act
messagebox [错误提示]：你已经是【道士】职业。
SENDMSG 7 [错误提示]：你已经是 道士 职业。
break
#If
CHECKGAMEGOLD > 99999
#Act
GAMEGOLD - 100000
ChangeJob taoist
ADDSKILL 治愈术 3
ADDSKILL 灵魂火符 3
ADDSKILL 精神力战法 3
ADDSKILL 隐身术 3
ADDSKILL 施毒术 3
ADDSKILL 幽灵盾 3
ADDSKILL 神圣战甲术 3
ADDSKILL 群体治愈术 3
ADDSKILL 心灵启示 3
ADDSKILL 召唤神兽 3
DELNOJOBSKILL
messagebox 恭喜您：你已经转成『道士』。\防止数据出错，你已被系统自动踢下线。
SENDMSG 7 恭喜您：你已经转成『道士』。
SENDMSG 0 恭喜：<$USERNAME> 转职成为了本服的一名 道士。
kick
#ELSEACT
messagebox [错误提示]：需要100000元宝。
SENDMSG 7 [错误提示]：需要100000元宝。
break

#If
checkjob taoist
#Act
messagebox [错误提示]：你已经是【道士】职业。
SENDMSG 7 [错误提示]：你已经是 道士 职业。
break
#If
CHECKGAMEGOLD > 149999
#Act
GAMEGOLD - 150000
ChangeJob taoist
ADDSKILL 治愈术 3
ADDSKILL 灵魂火符 3
ADDSKILL 精神力战法 3
ADDSKILL 隐身术 3
ADDSKILL 施毒术 3
ADDSKILL 幽灵盾 3
ADDSKILL 神圣战甲术 3
ADDSKILL 群体治愈术 3
ADDSKILL 心灵启示 3
ADDSKILL 召唤神兽 3
DELNOJOBSKILL
messagebox 恭喜您：你已经转成『道士』。\防止数据出错，你已被系统自动踢下线。
SENDMSG 7 恭喜您：你已经转成『道士』。
SENDMSG 0 恭喜：<$USERNAME> 转职成为了本服的一名 道士。
kick
#ELSEACT
messagebox [错误提示]：需要150000元宝。
SENDMSG 7 [错误提示]：需要150000元宝。
break

[@法师1]
#If
check [60] 1
checkjob wizard
#Act
messagebox [错误提示]：你已经是【魔法师】职业。
SENDMSG 7 [错误提示]：你已经是 魔法师 职业。
break
#If
CHECKGAMEGOLD > 99999
#Act
GAMEGOLD - 100000
ChangeJob wizard
ADDSKILL 雷电术 3
ADDSKILL 火墙 3
ADDSKILL 魔法盾 3
ADDSKILL 冰咆哮 3
ADDSKILL 抗拒火环 3
ADDSKILL 疾光电影 3
ADDSKILL 诱惑之光 3
ADDSKILL 地狱雷光 3
ADDSKILL 诱惑之光 3
ADDSKILL 瞬息移动 3
ADDSKILL 圣言术 3
DELNOJOBSKILL
messagebox 恭喜您：你已经转成『魔法师』。\防止数据出错，你已被系统自动踢下线。
SENDMSG 7 恭喜您：你已经转成『魔法师』。
SENDMSG 0 恭喜：<$USERNAME> 转职成为了本服的一名 魔法师。
kick
#ELSEACT
messagebox [错误提示]：需要100000元宝。
SENDMSG 7 [错误提示]：需要100000元宝。
break

#If
checkjob wizard
#Act
messagebox [错误提示]：你已经是【魔法师】职业。
SENDMSG 7 [错误提示]：你已经是 魔法师 职业。
break
#If
CHECKGAMEGOLD > 149999
#Act
GAMEGOLD - 150000
ChangeJob wizard
ADDSKILL 雷电术 3
ADDSKILL 火墙 3
ADDSKILL 魔法盾 3
ADDSKILL 冰咆哮 3
ADDSKILL 抗拒火环 3
ADDSKILL 疾光电影 3
ADDSKILL 诱惑之光 3
ADDSKILL 地狱雷光 3
ADDSKILL 诱惑之光 3
ADDSKILL 瞬息移动 3
ADDSKILL 圣言术 3
DELNOJOBSKILL
messagebox 恭喜您：你已经转成『魔法师』。\防止数据出错，你已被系统自动踢下线。
SENDMSG 7 恭喜您：你已经转成『魔法师』。
SENDMSG 0 恭喜：<$USERNAME> 转职成为了本服的一名 魔法师。
kick
#ELSEACT
messagebox [错误提示]：需要150000元宝。
SENDMSG 7 [错误提示]：需要150000元宝。
break

[@战士1]
#If
check [60] 1
checkjob warrior
#Act
messagebox [错误提示]：你已经是【战士】职业。
SENDMSG 7 [错误提示]：你已经是 战士 职业。
break
#If
CHECKGAMEGOLD > 99999
#Act
GAMEGOLD - 100000
ChangeJob Warrior
ADDSKILL 基本剑术 3
ADDSKILL 攻杀剑术 3
ADDSKILL 刺杀剑术 3
ADDSKILL 半月弯刀 3
ADDSKILL 野蛮冲撞 3
ADDSKILL 烈火剑法 3
DELNOJOBSKILL
messagebox 恭喜您：你已经转成『战士』。\防止数据出错，你已被系统自动踢下线。
SENDMSG 7 恭喜您：你已经转成『战士』。
SENDMSG 0 恭喜：<$USERNAME> 转职成为了本服的一名 战士。
kick
#ELSEACT
messagebox [错误提示]：需要100000元宝。
SENDMSG 7 [错误提示]：需要100000元宝。
break

#If
checkjob warrior
#Act
messagebox [错误提示]：你已经是【战士】职业。
SENDMSG 7 [错误提示]：你已经是 战士 职业。
break
#If
CHECKGAMEGOLD > 149999
#Act
GAMEGOLD - 150000
ChangeJob Warrior
ADDSKILL 基本剑术 3
ADDSKILL 攻杀剑术 3
ADDSKILL 刺杀剑术 3
ADDSKILL 半月弯刀 3
ADDSKILL 野蛮冲撞 3
ADDSKILL 烈火剑法 3
DELNOJOBSKILL
messagebox 恭喜您：你已经转成『战士』。\防止数据出错，你已被系统自动踢下线。
SENDMSG 7 恭喜您：你已经转成『战士』。
SENDMSG 0 恭喜：<$USERNAME> 转职成为了本服的一名 战士。
kick
#ELSEACT
messagebox [错误提示]：需要150000元宝。
SENDMSG 7 [错误提示]：需要150000元宝。
break

[@toman1]
#IF
check [60] 1
CHECKUSEITEM 0
#ACT
messagebox [错误提示]：请把你的『衣服』脱掉。
SENDMSG 7 [错误提示]：请把你的『衣服』脱掉。
break
#IF
CHECKGAMEGOLD > 9999
#ACT
GAMEGOLD - 10000
CHANGEGENDER 0
SENDMSG 7 恭喜您：手术非常的成功，您已经变成一位男人了。
SENDMSG 0 恭喜：<$USERNAME> 变性成为了一位猛男。
messagebox 恭喜您：手术非常的成功，您已经变成一位男人了。
goto @性别转换11
break
#ELSEACT
messagebox [错误提示]：变性需要花费10000元宝。
SENDMSG 7 [错误提示]：变性需要花费10000元宝。
break

#IF
CHECKUSEITEM 0
#ACT
messagebox [错误提示]：请把你的『衣服』脱掉。
SENDMSG 7 [错误提示]：请把你的『衣服』脱掉。
break
#IF
CHECKGAMEGOLD > 19999
#ACT
GAMEGOLD - 20000
CHANGEGENDER 0
SENDMSG 7 恭喜您：手术非常的成功，您已经变成一位男人了。
SENDMSG 0 恭喜：<$USERNAME> 变性成为了一位猛男。
messagebox 恭喜您：手术非常的成功，您已经变成一位男人了。
goto @性别转换11
break
#ELSEACT
messagebox [错误提示]：变性需要花费20000元宝。
SENDMSG 7 [错误提示]：变性需要花费20000元宝。
break

[@towoman1]
#IF
check [60] 1
CHECKUSEITEM 0
#ACT
messagebox [错误提示]：请把你的『衣服』脱掉。
SENDMSG 7 [错误提示]：请把你的『衣服』脱掉。
break
#IF
CHECKGAMEGOLD > 9999
#ACT
GAMEGOLD - 10000
CHANGEGENDER 1
SENDMSG 7 恭喜您：手术非常的成功，您已经变成一位女人了。
SENDMSG 0 恭喜：<$USERNAME> 变性成为了一位美女。
messagebox 恭喜您：手术非常的成功，您已经变成一位女人了。
goto @性别转换11
break
#ELSEACT
messagebox [错误提示]：变性需要花费10000元宝。
SENDMSG 7 [错误提示]：变性需要花费10000元宝。
break

#IF
CHECKUSEITEM 0
#ACT
messagebox [错误提示]：请把你的『衣服』脱掉。
SENDMSG 7 [错误提示]：请把你的『衣服』脱掉。
break
#IF
CHECKGAMEGOLD > 19999
#ACT
GAMEGOLD - 20000
CHANGEGENDER 1
SENDMSG 7 恭喜您：手术非常的成功，您已经变成一位女人了。
SENDMSG 0 恭喜：<$USERNAME> 变性成为了一位美女。
messagebox 恭喜您：手术非常的成功，您已经变成一位女人了。
goto @性别转换11
break
#ELSEACT
messagebox [错误提示]：变性需要花费20000元宝。
SENDMSG 7 [错误提示]：变性需要花费20000元宝。
break






[@会员礼包]
\
<领取黄昏男战套/@男战套>　　　　　<领取黄昏女战套/@女战套>\
\
<领取黄昏男法套/@男法套>　　　　　<领取黄昏女法套/@女法套>\
\
<领取黄昏男道套/@男道套>　　　　　<领取黄昏女道套/@女道套>\

[@女道套]
#if
CHECKLEVELEX > 79
check [130] 0
#act
SET [130] 1
GIVE 逐日道盔 1
GIVE 逐日道链 1
GIVE 逐日道镯 2
GIVE 逐日道指 2
GIVE 逐日道勋 1
GIVE 逐日道带 1
GIVE 逐日道靴 1
GIVE 幸运斗笠 1
GIVE 幸运·盾 1
GIVE 麻痹戒指+2 1
GIVE 复活戒指+2 1
GIVE 护身戒指+2 1
GIVE 治疗宝珠② 1
GIVE 逐日道扇 1
GIVE 逐日道衣 1
GIVE 强化灵魂火符 1
GIVE 群体施毒术 1
BREAK

#if
CHECKLEVELEX < 80
check [130] 0
#act
SET [130] 1
CHANGELEVEL = 80
GIVE 逐日道盔 1
GIVE 逐日道链 1
GIVE 逐日道镯 2
GIVE 逐日道指 2
GIVE 逐日道勋 1
GIVE 逐日道带 1
GIVE 逐日道靴 1
GIVE 幸运斗笠 1
GIVE 幸运·盾 1
GIVE 麻痹戒指+2 1
GIVE 复活戒指+2 1
GIVE 护身戒指+2 1
GIVE 治疗宝珠② 1
GIVE 逐日道扇 1
GIVE 逐日道衣 1
GIVE 强化灵魂火符 1
GIVE 群体施毒术 1
#ELSEACT
MESSAGEBOX 错误：你已经领取过会员礼包了！
BREAK

[@男道套]
#if
CHECKLEVELEX > 79
check [130] 0
#act
SET [130] 1
GIVE 逐日道盔 1
GIVE 逐日道链 1
GIVE 逐日道镯 2
GIVE 逐日道指 2
GIVE 逐日道勋 1
GIVE 逐日道带 1
GIVE 逐日道靴 1
GIVE 幸运斗笠 1
GIVE 幸运·盾 1
GIVE 麻痹戒指+2 1
GIVE 复活戒指+2 1
GIVE 护身戒指+2 1
GIVE 治疗宝珠② 1
GIVE 逐日道扇 1
GIVE 逐日道甲 1
GIVE 强化灵魂火符 1
GIVE 群体施毒术 1
BREAK

#if
CHECKLEVELEX < 80
check [130] 0
#act
SET [130] 1
CHANGELEVEL = 80
GIVE 逐日道盔 1
GIVE 逐日道链 1
GIVE 逐日道镯 2
GIVE 逐日道指 2
GIVE 逐日道勋 1
GIVE 逐日道带 1
GIVE 逐日道靴 1
GIVE 幸运斗笠 1
GIVE 幸运·盾 1
GIVE 麻痹戒指+2 1
GIVE 复活戒指+2 1
GIVE 护身戒指+2 1
GIVE 治疗宝珠② 1
GIVE 逐日道扇 1
GIVE 逐日道甲 1
GIVE 强化灵魂火符 1
GIVE 群体施毒术 1
#ELSEACT
MESSAGEBOX 错误：你已经领取过会员礼包了！
BREAK

[@女法套]
#if
CHECKLEVELEX > 79
check [130] 0
#act
SET [130] 1
GIVE 逐日魔盔 1
GIVE 逐日魔链 1
GIVE 逐日魔镯 2
GIVE 逐日魔指 2
GIVE 逐日魔勋 1
GIVE 逐日魔带 1
GIVE 逐日魔靴 1
GIVE 幸运斗笠 1
GIVE 幸运·盾 1
GIVE 麻痹戒指+2 1
GIVE 复活戒指+2 1
GIVE 护身戒指+2 1
GIVE 治疗宝珠② 1
GIVE 逐日魔杖 1
GIVE 逐日魔衣 1
GIVE 强化魔法盾 1
GIVE 群体雷电术 1
BREAK

#if
CHECKLEVELEX < 80
check [130] 0
#act
SET [130] 1
CHANGELEVEL = 80
GIVE 逐日魔盔 1
GIVE 逐日魔链 1
GIVE 逐日魔镯 2
GIVE 逐日魔指 2
GIVE 逐日魔勋 1
GIVE 逐日魔带 1
GIVE 逐日魔靴 1
GIVE 幸运斗笠 1
GIVE 幸运·盾 1
GIVE 麻痹戒指+2 1
GIVE 复活戒指+2 1
GIVE 护身戒指+2 1
GIVE 治疗宝珠② 1
GIVE 逐日魔杖 1
GIVE 逐日魔衣 1
GIVE 强化魔法盾 1
GIVE 群体雷电术 1
#ELSEACT
MESSAGEBOX 错误：你已经领取过会员礼包了！
BREAK

[@男法套]
#if
CHECKLEVELEX > 79
check [130] 0
#act
SET [130] 1
GIVE 逐日魔盔 1
GIVE 逐日魔链 1
GIVE 逐日魔镯 2
GIVE 逐日魔指 2
GIVE 逐日魔勋 1
GIVE 逐日魔带 1
GIVE 逐日魔靴 1
GIVE 幸运斗笠 1
GIVE 幸运·盾 1
GIVE 麻痹戒指+2 1
GIVE 复活戒指+2 1
GIVE 护身戒指+2 1
GIVE 治疗宝珠② 1
GIVE 逐日魔杖 1
GIVE 逐日魔甲 1
GIVE 强化魔法盾 1
GIVE 群体雷电术 1
BREAK

#if
CHECKLEVELEX < 80
check [130] 0
#act
SET [130] 1
CHANGELEVEL = 80
GIVE 逐日魔盔 1
GIVE 逐日魔链 1
GIVE 逐日魔镯 2
GIVE 逐日魔指 2
GIVE 逐日魔勋 1
GIVE 逐日魔带 1
GIVE 逐日魔靴 1
GIVE 幸运斗笠 1
GIVE 幸运·盾 1
GIVE 麻痹戒指+2 1
GIVE 复活戒指+2 1
GIVE 护身戒指+2 1
GIVE 治疗宝珠② 1
GIVE 逐日魔杖 1
GIVE 逐日魔甲 1
GIVE 强化魔法盾 1
GIVE 群体雷电术 1
#ELSEACT
MESSAGEBOX 错误：你已经领取过会员礼包了！
BREAK

[@女战套]
#if
CHECKLEVELEX > 79
check [130] 0
#act
SET [130] 1
GIVE 逐日战盔 1
GIVE 逐日战链 1
GIVE 逐日战镯 2
GIVE 逐日战指 2
GIVE 逐日战勋 1
GIVE 逐日战带 1
GIVE 逐日战靴 1
GIVE 幸运斗笠 1
GIVE 幸运·盾 1
GIVE 麻痹戒指+2 1
GIVE 复活戒指+2 1
GIVE 护身戒指+2 1
GIVE 治疗宝珠② 1
GIVE 逐日战刃 1
GIVE 逐日战衣 1
GIVE 强化烈火剑法 1
GIVE 逐日剑法 1
BREAK

#if
CHECKLEVELEX < 80
check [130] 0
#act
SET [130] 1
CHANGELEVEL = 80
GIVE 逐日战盔 1
GIVE 逐日战链 1
GIVE 逐日战镯 2
GIVE 逐日战指 2
GIVE 逐日战勋 1
GIVE 逐日战带 1
GIVE 逐日战靴 1
GIVE 幸运斗笠 1
GIVE 幸运·盾 1
GIVE 麻痹戒指+2 1
GIVE 复活戒指+2 1
GIVE 护身戒指+2 1
GIVE 治疗宝珠② 1
GIVE 逐日战刃 1
GIVE 逐日战衣 1
GIVE 强化烈火剑法 1
GIVE 逐日剑法 1
#ELSEACT
MESSAGEBOX 错误：你已经领取过会员礼包了！
BREAK

[@男战套]
#if
CHECKLEVELEX > 79
check [130] 0
#act
SET [130] 1
GIVE 逐日战盔 1
GIVE 逐日战链 1
GIVE 逐日战镯 2
GIVE 逐日战指 2
GIVE 逐日战勋 1
GIVE 逐日战带 1
GIVE 逐日战靴 1
GIVE 幸运斗笠 1
GIVE 幸运·盾 1
GIVE 麻痹戒指+2 1
GIVE 复活戒指+2 1
GIVE 护身戒指+2 1
GIVE 治疗宝珠② 1
GIVE 逐日战刃 1
GIVE 逐日战甲 1
GIVE 强化烈火剑法 1
GIVE 逐日剑法 1
BREAK

#if
CHECKLEVELEX < 80
check [130] 0
#act
SET [130] 1
CHANGELEVEL = 80
GIVE 逐日战盔 1
GIVE 逐日战链 1
GIVE 逐日战镯 2
GIVE 逐日战指 2
GIVE 逐日战勋 1
GIVE 逐日战带 1
GIVE 逐日战靴 1
GIVE 幸运斗笠 1
GIVE 幸运·盾 1
GIVE 麻痹戒指+2 1
GIVE 复活戒指+2 1
GIVE 护身戒指+2 1
GIVE 治疗宝珠② 1
GIVE 逐日战刃 1
GIVE 逐日战甲 1
GIVE 强化烈火剑法 1
GIVE 逐日剑法 1
#ELSEACT
MESSAGEBOX 错误：你已经领取过会员礼包了！
BREAK

[@每日福利]
#IF
checknamelist ..\questdiary\临时数据\每日福利.txt
#act
messagebox 错误：今天你已经领取过福利了
break
#IF
equal U22 5
#act
addnamelist ..\questdiary\临时数据\每日福利.txt
GAMEGOLD + 200000
SENDMSG 7 领取会员福利200000元宝！
BREAK
#IF
equal U22 4
#act
addnamelist ..\questdiary\临时数据\每日福利.txt
GAMEGOLD + 100000
SENDMSG 7 领取会员福利100000元宝！
BREAK
#IF
equal U22 3
#act
addnamelist ..\questdiary\临时数据\每日福利.txt
GAMEGOLD + 30000
SENDMSG 7 领取会员福利30000元宝！
BREAK
#IF
equal U22 2
#act
addnamelist ..\questdiary\临时数据\每日福利.txt
GAMEGOLD + 10000
SENDMSG 7 领取会员福利10000元宝！
BREAK
#IF
equal U22 1
#act
addnamelist ..\questdiary\临时数据\每日福利.txt
GAMEGOLD + 5000
SENDMSG 7 领取会员福利5000元宝！
BREAK


[@UserCmd2]
#OR
equal U22 5
equal U22 4
equal U22 3
equal U22 2
equal U22 1
#SAY
\
{                   ◆<$SERVERNAME>◆/AUTOCOLOR=209,253,254,252,215,95,252,247}\ \
\
<★★/FCOLOR=250><清洗红名/@清洗红名><★★/FCOLOR=250>          <★★/FCOLOR=249><装备特修/@装备特修><★★/FCOLOR=249> \ \
<★★/FCOLOR=250><每日福利/@每日福利><★★/FCOLOR=250>　        <★★/FCOLOR=250><转职变性/@转职变性><★★/FCOLOR=250>          \ \
\　                  <★★/FCOLOR=250><聊天颜色/@聊天颜色><★★/FCOLOR=250>          \ \
\
#ACT
#ELSEACT
MESSAGEBOX 错误：你还不是会员！！
BREAK


[@装备特修]
#IF
#ACT
ACTREPAIRALL
#ACT
SENDMSG 7 你的装备修好了
BREAK

[@清洗红名]
#act
CHANGEPKPOINT = 0
SENDMSG 7 我已经帮你减轻你的罪孽！好好做人哦！
BREAK
;-----------------------------------------------------------------------------------------------------------------
[@MagicStruck]
#IF
#ACT
#CALL [\游戏功能\无视伤害.txt] @无视伤害a
BREAK

[@Struck]
#IF
#ACT
#CALL [\游戏功能\无视伤害.txt] @无视伤害a
BREAK
;-----------------------------------------------------------------------------------------------------------------
[@离开]
#IF
#ACT
mapmove 3 330 330
BREAK
;-----------------------------------------------------------------------------------------------------------------

[@TakeOn2]
#IF
CHECKITEMW 1.5倍爆率勋章 1
#ACT
MOV N2 0
#CALL [\游戏功能\装备爆率.txt] @装备爆率
BREAK

[@TakeOff2]
#IF
#ACT
MOV N2 0
#CALL [\游戏功能\装备爆率.txt] @装备爆率
BREAK

[@TakeOn1]
#IF
#ACT
MOV N1 0
#CALL [\游戏功能\装备吸血.txt] @吸血设置
BREAK

[@TakeOff1]
#IF
#ACT
MOV N1 0
#CALL [\游戏功能\装备吸血.txt] @吸血设置
BREAK


[@TakeOn3]
#IF
CHECKITEMW  暴风噬血链 1
#ACT
MOV N1 0
#CALL [\游戏功能\装备吸血.txt] @吸血设置
BREAK

#IF
CHECKITEMW  点点噬血链 1
#ACT
MOV N1 0
#CALL [\游戏功能\装备吸血.txt] @吸血设置
BREAK

[@TakeOn14]
#IF
#ACT
MOV N1 0
#CALL [\游戏功能\装备吸血.txt] @吸血设置
BREAK

[@TakeOff14]
#IF
#ACT
MOV N1 0
#CALL [\游戏功能\装备吸血.txt] @吸血设置
BREAK

[@TakeOn15]
#IF
#ACT
MOV N1 0
#CALL [\游戏功能\装备吸血.txt] @吸血设置
BREAK

[@TakeOff15]
#IF
#ACT
MOV N1 0
#CALL [\游戏功能\装备吸血.txt] @吸血设置
BREAK

[@TakeOff3]
#IF
CheckTakeOffItem  暴风噬血链 1
#ACT
MOV N1 0
#CALL [\游戏功能\装备吸血.txt] @吸血设置
BREAK

#IF
CheckTakeOffItem 点点噬血链 1
#ACT
MOV N1 0
#CALL [\游戏功能\装备吸血.txt] @吸血设置
BREAK
;-----------------------------------------------------------------------------------------------------------------
[@StartMyShop]
#if
ISDUPMODE
#ACT
MESSAGEBOX 不能与人重叠在一起！
ForbidMyShop
BREAK


#if
CheckLevelEx < 50
#ACT
MESSAGEBOX 50级才可以使用摆摊功能！！
ForbidMyShop
BREAK

#OR
CheckHumInRange 3 285 330 11
CheckHumInRange 3 308 331 11
#ACT
#ELSEACT
MESSAGEBOX 当前不在盟重左边安全区域内，不能使用摆摊功能！
ForbidMyShop
BREAK


;-----------------------------------------------------------------------------------------------------------------


[@StdModeFunc111]
#IF
random 16
#ACT
GAMEGOLD + 1889
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{1889元宝|56:9}
BREAK

#IF
random 14
#ACT
GAMEGOLD + 1589
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{1589元宝|56:9}
BREAK

#IF
random 12
#ACT
GAMEGOLD + 1189
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{1189元宝|56:9}
BREAK

#IF
random 10
#ACT
GAMEGOLD + 889
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{889元宝|56:9}
BREAK

#IF
random 9
#ACT
GAMEGOLD + 689
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{689元宝|56:9}
BREAK

#IF
random 7
#ACT
GAMEGOLD + 289
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{289元宝|56:9}
BREAK

#IF
random 6
#ACT
GAMEGOLD + 389
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{389元宝|56:9}
BREAK

#IF
random 5
#ACT
GAMEGOLD + 489
SENDMSG 6 {ぐ<$USERNAME>:|251:0:0}{打开了红包，里边竟然有|56:9}{489元宝|56:9}
BREAK

#IF
random 4
#ACT
GAMEGOLD + 189
SENDMSG 6 {ぐ<$USERNAME>:|251:0:0}{打开了红包，里边竟然有|56:9}{189元宝|56:9}
BREAK

#IF
random 3
#ACT
GAMEGOLD + 589
SENDMSG 6 {ぐ<$USERNAME>:|251:0:0}{打开了红包，里边竟然有|56:9}{589元宝|56:9}
BREAK

#IF
random 2
#ACT
GAMEGOLD + 189
SENDMSG 6 {ぐ<$USERNAME>:|251:0:0}{打开了红包，里边竟然有|56:9}{189元宝|56:9}
BREAK

#IF
random 1
#ACT
GAMEGOLD + 89
SENDMSG 6 {ぐ<$USERNAME>:|251:0:0}{打开了红包，里边竟然有|56:9}{89元宝|56:9}
BREAK
;-----------------------------------------------------------------------------------------------------------------
[@StdModeFunc112]
#IF
random 16
#ACT
GAMEGOLD + 11889
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{11889元宝|56:9}
BREAK

#IF
random 14
#ACT
GAMEGOLD + 11589
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{11589元宝|56:9}
BREAK

#IF
random 12
#ACT
GAMEGOLD + 11189
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{11189元宝|56:9}
BREAK

#IF
random 10
#ACT
GAMEGOLD + 9889
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{9889元宝|56:9}
BREAK

#IF
random 9
#ACT
GAMEGOLD + 8889
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{8889元宝|56:9}
BREAK

#IF
random 8
#ACT
GAMEGOLD + 7889
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{7889元宝|56:9}
BREAK

#IF
random 7
#ACT
GAMEGOLD + 6689
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{6689元宝|56:9}
BREAK

#IF
random 6
#ACT
GAMEGOLD + 5889
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{5889元宝|56:9}
BREAK

#IF
random 5
#ACT
GAMEGOLD + 4889
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{4889元宝|56:9}
BREAK

#IF
random 4
#ACT
GAMEGOLD + 3889
SENDMSG 6 {ぐ<$USERNAME>:|251:0:0}{打开了红包，里边竟然有|56:9}{3889元宝|56:9}
BREAK

#IF
random 3
#ACT
GAMEGOLD + 2889
SENDMSG 6 {ぐ<$USERNAME>:|251:0:0}{打开了红包，里边竟然有|56:9}{2889元宝|56:9}
BREAK

#IF
random 2
#ACT
GAMEGOLD + 1889
SENDMSG 6 {ぐ<$USERNAME>:|251:0:0}{打开了红包，里边竟然有|56:9}{1889元宝|56:9}
BREAK

#IF
random 1
#ACT
GAMEGOLD + 1889
SENDMSG 6 {ぐ<$USERNAME>:|251:0:0}{打开了红包，里边竟然有|56:9}{1889元宝|56:9}
BREAK


;-----------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------
[@StdModeFunc113]
#IF
random 16
#ACT
GAMEGOLD + 111889
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{111889元宝|56:9}
BREAK

#IF
random 14
#ACT
GAMEGOLD + 101589
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{101589元宝|56:9}
BREAK

#IF
random 12
#ACT
GAMEGOLD + 91189
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{91189元宝|56:9}
BREAK

#IF
random 10
#ACT
GAMEGOLD + 89889
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{89889元宝|56:9}
BREAK

#IF
random 9
#ACT
GAMEGOLD + 78889
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{78889元宝|56:9}
BREAK

#IF
random 8
#ACT
GAMEGOLD + 67889
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{67889元宝|56:9}
BREAK

#IF
random 7
#ACT
GAMEGOLD + 56689
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{56689元宝|56:9}
BREAK

#IF
random 6
#ACT
GAMEGOLD + 45889
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{45889元宝|56:9}
BREAK

#IF
random 5
#ACT
GAMEGOLD + 34889
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了红包，里边竟然有|56:9}{34889元宝|56:9}
BREAK

#IF
random 4
#ACT
GAMEGOLD + 38889
SENDMSG 6 {ぐ<$USERNAME>:|251:0:0}{打开了红包，里边竟然有|56:9}{38889元宝|56:9}
BREAK

#IF
random 3
#ACT
GAMEGOLD + 28889
SENDMSG 6 {ぐ<$USERNAME>:|251:0:0}{打开了红包，里边竟然有|56:9}{28889元宝|56:9}
BREAK

#IF
random 2
#ACT
GAMEGOLD + 18889
SENDMSG 6 {ぐ<$USERNAME>:|251:0:0}{打开了红包，里边竟然有|56:9}{18889元宝|56:9}
BREAK

#IF
random 1
#ACT
GAMEGOLD + 18889
SENDMSG 6 {ぐ<$USERNAME>:|251:0:0}{打开了红包，里边竟然有|56:9}{18889元宝|56:9}
BREAK


;-----------------------------------------------------------------------------------------------------------------
[@StdModeFunc114]
#IF
#ACT
give 洗髓丹 50
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了洗髓丹[包]，里边竟然有|56:9}{50个洗髓丹|56:9}
BREAK

[@StdModeFunc115]
#IF
#ACT
give 恶魔令牌 50
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了恶魔令牌[包]，里边竟然有|56:9}{50个恶魔令牌|56:9}
BREAK

[@StdModeFunc116]
#IF
#ACT
give 血龙魄珠 50
SENDMSG 6 {ぐ<$USERNAME>:|56:9:0}{打开了血龙魄珠[包]，里边竟然有|56:9}{50个血龙魄珠|56:9}
BREAK


[@StdModeFunc50]
#IF
#ACT
GAMEDIAMOND + 1
SENDMSG 5 恭喜您的人民币点+1！
BREAK

[@StdModeFunc51]
#IF
#ACT
GAMEDIAMOND + 2
SENDMSG 5 恭喜您的人民币点+2！
BREAK

[@StdModeFunc52]
#IF
#ACT
GAMEDIAMOND + 5
SENDMSG 5 恭喜您的人民币点+5！
BREAK

[@StdModeFunc53]
#IF
#ACT
GAMEDIAMOND + 10
SENDMSG 5 恭喜您的人民币点+10！
BREAK

[@StdModeFunc54]
#IF
#ACT
GAMEDIAMOND + 50
SENDMSG 5 恭喜您的人民币点+50！
BREAK


[@StdModeFunc55]
#IF
#ACT
GAMEDIAMOND + 100
SENDMSG 5 恭喜您的人民币点+100！
BREAK


[@主界面按钮设置]
#CALL [\基础按钮\主界面基础按钮QF.txt] @基础按钮QF

[@伸缩]
#IF
Equal <$CLIENTFLAG> 2
#ACT
delbutton 102 2
MOV S$图标2 <Button|x=-230|a=3|y=35|rotate=180|nimg=official/top/1900012531.png|link=@展开>
addbutton 102 2 <$STR(S$图标2)>


[@展开]
#IF
Equal <$CLIENTFLAG> 2
#ACT
delbutton 102 2
MOV S$图标2 <Button|x=-230|y=35|nimg=official/top/1900012531.png|link=@伸缩>

INC S$图标2 <Button|x=-320|y=35|nimg=official/top/1900012611.png|link=@建议>
INC S$图标2 <Button|x=-400|y=35|nimg=official/top/1900012607.png|link=@首充>
INC S$图标2 <Button|x=-480|y=35|nimg=official/top/1900012601.png|link=@活动>
INC S$图标2 <Button|x=-560|y=35|nimg=official/top/1900012602.png|link=@飞鞋>
addbutton 102 2 <$STR(S$图标2)>
break


[@管理模式]
#IF
#ACT
#Call [\Mobile\特殊NPC\系统管理员.txt] @GM


[@刷新]
#IF
#ACT
REFRESHBAG



[@飞鞋]
#IF
#ACT
#Call [\Mobile\特殊NPC\传送员.txt] @Settings_cs


[@StartAutoPlayGame]
#if
#ACT
SENDMSG 7 开始挂机触发

#if
equal <$CLIENTFLAG> 2
#act
DELBUTTON 104 6
MOV S$主界面按钮 <Button|x=-127|y=-374|color=251|mimg=private\main\Skill\1900012709.png|size=16|nimg=private\main\Skill\1900012709.png|pimg=private\main\Skill\1900012709.png|link=@停止挂机>
ADDBUTTON 104 6 <$STR(S$主界面按钮)>



[@StopAutoPlayGame] 
#if
#ACT
SENDMSG 7 关闭挂机触发

#if
equal <$CLIENTFLAG> 2
#act
DELBUTTON 104 6
MOV S$主界面按钮 <Button|x=-127|y=-374|color=251|mimg=private\main\Skill\1900012708.png|size=16|nimg=private\main\Skill\1900012708.png|pimg=private\main\Skill\1900012708.png|link=@开始挂机>
ADDBUTTON 104 6 <$STR(S$主界面按钮)>





----------------------------------------------------------------通用函数--------------------------------------------------------------------------
----------------------------------------------------------------通用函数--------------------------------------------------------------------------


]]--