local function _Includes()
    math.randomseed(tostring(os.time()):reverse():sub(1, 7))

    --基础库
    require("Envir/QuestDiary/CCLua/LuaLibrary/string")
    require("Envir/QuestDiary/CCLua/LuaLibrary/table")
    require("Envir/QuestDiary/CCLua/LuaLibrary/Logger")    

    -- --配置表     
    -- cfg_att_score = require("Envir/QuestDiary/CCLua/GameConfig/cfg_att_score")
    -- cfg_equip = require("Envir/QuestDiary/CCLua/GameConfig/cfg_equip")
    -- cfg_item = require("Envir/QuestDiary/CCLua/GameConfig/cfg_item")
    -- cfg_magic= require("Envir/QuestDiary/CCLua/GameConfig/cfg_magic")
    -- cfg_game_data = require("Envir/QuestDiary/CCLua/GameConfig/cfg_game_data")
    
    -- cfgEquipPosStrength = require("Envir/QuestDiary/CCLua/GameConfig/cfgEquipPosStrength")
    -- cfgEquipPosUpgradeStar = require("Envir/QuestDiary/CCLua/GameConfig/cfgEquipPosStar")
    -- cfgWeaponLuck = require("Envir/QuestDiary/CCLua/GameConfig/cfgWeaponLuck")
    -- cfgRandomABCreate = require("Envir/QuestDiary/CCLua/GameConfig/cfgRandomABCreate")
    -- cfgRandomABPool = require("Envir/QuestDiary/CCLua/GameConfig/cfgRandomABPool")
    -- cfgSkillUpgrade = require("Envir/QuestDiary/CCLua/GameConfig/cfgSkillUpgrade")
    -- cfgSkillAdvanceUpgrade = require("Envir/QuestDiary/CCLua/GameConfig/cfgSkillAdvanceUpgrade")
    -- cfgEquipValidComposeList = {}
    -- cfgEquipInitGift = require("Envir/QuestDiary/CCLua/GameConfig/cfgEquipInitGift")
    -- cfgBaoZhuBossInfo = require("Envir/QuestDiary/CCLua/GameConfig/cfgBaoZhuBossInfo")
    -- cfgGuanZhi = require("Envir/QuestDiary/CCLua/GameConfig/cfgGuanZhi")
    -- cfgOfflineHuWei = require("Envir/QuestDiary/CCLua/GameConfig/cfgOfflineHuWei")
    -- cfgMoFangZhen = require("Envir/QuestDiary/CCLua/GameConfig/cfgMoFangZhen")
    -- cfgRandomBossTriggerPool = require("Envir/QuestDiary/CCLua/GameConfig/cfgRandomBossTriggerPool")
    -- cfgFreeVIP = require("Envir/QuestDiary/CCLua/GameConfig/cfgFreeVIP")
    -- cfgFreeVIPTask = require("Envir/QuestDiary/CCLua/GameConfig/cfgFreeVIPTask")
    -- cfgFunctionCtrl = require("Envir/QuestDiary/CCLua/GameConfig/cfgFunctionCtrl")
    -- cfgFirstRecharge = require("Envir/QuestDiary/CCLua/GameConfig/cfgFirstRecharge")
    -- cfgActivityNewPlayerRecharge = require("Envir/QuestDiary/CCLua/GameConfig/cfgActivityNewPlayerRecharge")
    -- cfgActivityOpenServer = require("Envir/QuestDiary/CCLua/GameConfig/cfgActivityOpenServer")
    -- cfgActivityExtendGift = require("Envir/QuestDiary/CCLua/GameConfig/cfgActivityExtendGift")
    -- cfgRecycleSetting = require("Envir/QuestDiary/CCLua/GameConfig/cfgRecycleSetting")
    -- cfgPublicBossInfo = require("Envir/QuestDiary/CCLua/GameConfig/cfgPublicBossInfo")
    -- cfgSingleBossInfo = require("Envir/QuestDiary/CCLua/GameConfig/cfgSingleBossInfo")
    -- cfgEverydayTask = require("Envir/QuestDiary/CCLua/GameConfig/cfgEverydayTask")
    -- cfgItemCompose = require("Envir/QuestDiary/CCLua/GameConfig/cfgItemCompose")
    -- cfgItemValidComposeList = {}
    -- cfgUnpackItem = require("Envir/QuestDiary/CCLua/GameConfig/cfgUnpackItem")    


    
    --通用定义
    require("Envir/QuestDiary/CCLua/Utils/CommonDefine")
    require("Envir/QuestDiary/CCLua/Utils/CSS")
    require("Envir/QuestDiary/CCLua/Utils/BaseFunction")
    require("Envir/QuestDiary/CCLua/Utils/GameEventManager")
    require("Envir/QuestDiary/CCLua/Utils/MsgDefine")

    --[[
    --网络
    ssrNetMsgCfg = require("Envir/QuestDiary/net/NetMsgCfg")
    require("Envir/QuestDiary/net/Message")
    ]]--

    -- --UI
    -- require("Envir/QuestDiary/CCLua/UI/MainUIBase")
    -- require("Envir/QuestDiary/CCLua/UI/TopIcon")
    -- require("Envir/QuestDiary/CCLua/UI/GameCurrencyUI")

    --GameObj
    require("Envir/QuestDiary/CCLua/GameObj/Item")
    require("Envir/QuestDiary/CCLua/GameObj/Bag")
    require("Envir/QuestDiary/CCLua/GameObj/Player")
    require("Envir/QuestDiary/CCLua/GameObj/Map")

    -- --GameModule
    -- require("Envir/QuestDiary/CCLua/GameModule/ClientMsgProcess")
    -- require("Envir/QuestDiary/CCLua/GameModule/RechargeManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/EquipPosStrengthManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/EquipPosStarManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/EquipRandomABManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/EquipInitGift")
    -- require("Envir/QuestDiary/CCLua/GameModule/SkillUpgrade")
    -- require("Envir/QuestDiary/CCLua/GameModule/ItemComposeManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/ItemUseManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/BaoZhuManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/BaoZhuBossManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/SoulStoneManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/GuanZhiManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/OfflineHuWeiManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/MoFangZhenManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/RandomBossManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/FreeVIPManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/TaskLineConfig")
    -- require("Envir/QuestDiary/CCLua/GameModule/TaskManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/RecycleManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/FirstRecharge")
    -- require("Envir/QuestDiary/CCLua/GameModule/ActivityNewPlayerRecharge")
    -- require("Envir/QuestDiary/CCLua/GameModule/ActivityOpenServer")
    -- require("Envir/QuestDiary/CCLua/GameModule/ActivityExtendGift")
    -- require("Envir/QuestDiary/CCLua/GameModule/PublicBossManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/SingleBossManager")
    -- require("Envir/QuestDiary/CCLua/GameModule/EverydayTask")
    -- require("Envir/QuestDiary/CCLua/GameModule/TreasureMap")
    -- require("Envir/QuestDiary/CCLua/GameModule/YunBiaoManager")

    -- --调试日志
    -- --LOGCreate()

    -- --装备位强化表
    -- for _, value in pairs(cfgEquipPosStrength) do
    --     if (value.addprop ~= nil) and (value.addprop ~= '') then    
    --         value.addprop_tab = BF_Json2Table(value.addprop)
    --         value.addprop_desctab = BF_GetPropDescTableByJson(value.addprop)
    --     else
    --         value.addprop_tab = {}
    --         value.addprop_desctab = {}
    --     end
        
    --     if (value.needitems ~= nil) and (value.needitems ~= '') then
    --         value.needitems_tab = BF_Json2Table(value.needitems)
    --     else
    --         value.needitems_tab = {}
    --     end        
    -- end

    -- --装备位升星表
    -- for _, value in pairs(cfgEquipPosUpgradeStar) do
    --     if (value.addprop ~= nil) and (value.addprop ~= '') then
    --         value.addprop_tab = BF_Json2Table(value.addprop)
    --         value.addprop_desctab = BF_GetPropDescTableByJson(value.addprop)
    --     else
    --         value.addprop_tab = {}
    --         value.addprop_desctab = {}
    --     end
    --     if (value.needitems ~= nil) and (value.needitems ~= '') then
    --         value.needitems_tab = BF_Json2Table(value.needitems)
    --     else
    --         value.needitems_tab = {}
    --     end        
    -- end 
    
    -- --装备祝福表
    -- for _, value in pairs(cfgWeaponLuck) do
    --     if (value.needitems ~= nil) and (value.needitems ~= '') then
    --         value.needitems_tab = BF_Json2Table(value.needitems)
    --     else
    --         value.needitems_tab = {}
    --     end        
    -- end 
    
    -- --装备洗炼
    -- for _, value in pairs(cfgRandomABCreate) do
    --     if (value.ABNumPool ~= nil) and (value.ABNumPool ~= '') then
    --         value.ABNumPool_Tab = BF_Json2Table(value.ABNumPool)
    --     else
    --         value.ABNumPool_Tab = {}
    --     end
        
    --     if (value.ABKindPool ~= nil) and (value.ABKindPool ~= '') then
    --         value.ABKindPool_Tab = BF_Json2Table(value.ABKindPool)
    --     else
    --         value.ABKindPool_Tab = {}
    --     end        
    -- end
    
    -- for _, value in pairs(cfgRandomABPool) do
    --     if (value.RangeValue ~= nil) and (value.RangeValue ~= '') then
    --         value.RangeValue_Tab = BF_Json2Table(value.RangeValue)
    --     else
    --         value.RangeValue_Tab = {}
    --     end       
    -- end

    -- --技能升级
    -- for _, value in pairs(cfgSkillUpgrade) do
    --     if (value.needitems ~= nil) and (value.needitems ~= '') then
    --         value.needitems_tab = BF_Json2Table(value.needitems)
    --     else
    --         value.needitems_tab = {}
    --     end        
    -- end 

    -- --强化技能升级
    -- for _, value in pairs(cfgSkillAdvanceUpgrade) do
    --     if (value.needitems ~= nil) and (value.needitems ~= '') then
    --         value.needitems_tab = BF_Json2Table(value.needitems)
    --     else
    --         value.needitems_tab = {}
    --     end        
    -- end

    -- ---------------------------------------------------------------
    -- --新道具合成        
    -- ---------------------------------------------------------------
    -- for _, value in pairs(cfgItemCompose) do
    --     if (value.needitems ~= nil) and (value.needitems ~= '') then
    --         value.needitems_tab = BF_Json2Table(value.needitems)
    --     else
    --         value.needitems_tab = {}
    --     end
    --     if (value.srcitemlist ~= nil) and (value.srcitemlist ~= '') then
    --         value.srcitemlist_tab = BF_Json2Table(value.srcitemlist)
    --     else
    --         value.srcitemlist_tab = {}
    --     end
    --     if (value.composetarginfo ~= nil) and (value.composetarginfo ~= '') then
    --         value.composetarginfo_tab = BF_Json2Table(value.composetarginfo)
    --     else
    --         value.composetarginfo_tab = {}
    --     end  
        
    --     if type(value.srcitemlist_tab) == 'table' then
    --         for _, value1 in pairs(value.srcitemlist_tab) do
    --             local type = value.composetype
    --             if cfgItemValidComposeList[type] == nil then
    --                 cfgItemValidComposeList[type] = {}
    --             end
    --             if not cfgItemValidComposeList[type][value1.id] then
    --                 cfgItemValidComposeList[type][value1.id] = true
    --             end
    --         end
    --     end
    -- end    

    -- --装备天赋
    -- for _, value in pairs(cfgEquipInitGift) do
    --     if (value.abilitypool ~= nil) and (value.abilitypool ~= '') then
    --         value.abilitypool_tab = BF_Json2Table(value.abilitypool)
    --     else
    --         value.abilitypool_tab = {}
    --     end      
    -- end  
    
    -- --灵珠BOSS
    -- for _, value in pairs(cfgBaoZhuBossInfo) do
    --     if (value.rewarditems ~= nil) and (value.rewarditems ~= '') then
    --         value.rewarditems_tab = BF_Json2Table(value.rewarditems)
    --     else
    --         value.rewarditems_tab = {}
    --     end      
    -- end

    -- --魂石羁绊
    -- for _, value in pairs(SoulStoneManager.JI_BAN_CFG_INFO) do
    --     if value.addprop_tab ~= nil then
    --         value.addprop_desctab = BF_GetPropDescTableByTab(value.addprop_tab)
    --         value.addprop_abstr = BF_GetAbilityStrByABTab(value.addprop_tab)
    --     else
    --         value.addprop_desctab = {}
    --         value.addprop_abstr = ''
    --     end
    -- end

    -- --官职
    -- for _, value in pairs(cfgGuanZhi) do
    --     if (value.addprop ~= nil) and (value.addprop ~= '') then    
    --         value.addprop_tab = BF_Json2Table(value.addprop)
    --         value.addprop_desctab = {}
    --         value.addprop_desctab[CommonDefine.JOB_Z] = BF_GetPropDescTableByJson(value.addprop, CommonDefine.JOB_Z)
    --         value.addprop_desctab[CommonDefine.JOB_F] = BF_GetPropDescTableByJson(value.addprop, CommonDefine.JOB_F)
    --         value.addprop_desctab[CommonDefine.JOB_D] = BF_GetPropDescTableByJson(value.addprop, CommonDefine.JOB_D)
    --         value.addprop_abstr = BF_GetAbilityStrByABTab(value.addprop_tab)
    --     else
    --         value.addprop_tab = {}
    --         value.addprop_desctab = {}
    --         value.addprop_desctab[CommonDefine.JOB_Z] = {}
    --         value.addprop_desctab[CommonDefine.JOB_F] = {}
    --         value.addprop_desctab[CommonDefine.JOB_D] = {}
    --         value.addprop_abstr = ''
    --     end   
    --     if (value.dayrewards ~= nil) and (value.dayrewards ~= '') then
    --         value.dayrewards_tab = BF_Json2Table(value.dayrewards)
    --     else
    --         value.dayrewards_tab = {}
    --     end          
    -- end

    -- --紫宸殿离线成长
    -- for _, value in pairs(cfgOfflineHuWei) do
    --     if (value.addprop ~= nil) and (value.addprop ~= '') then    
    --         value.addprop_tab = BF_Json2Table(value.addprop)
    --         value.addprop_desctab = BF_GetPropDescTableByJson(value.addprop)
    --         value.addprop_abstr = BF_GetAbilityStrByABTab(value.addprop_tab)
    --     else
    --         value.addprop_tab = {}
    --         value.addprop_desctab = {}
    --         value.addprop_abstr = ''
    --     end   
    --     if (value.needitems ~= nil) and (value.needitems ~= '') then
    --         value.needitems_tab = BF_Json2Table(value.needitems)
    --     else
    --         value.needitems_tab = {}
    --     end        
    -- end   

    -- --随机BOSSS触发池
    -- for _, value in pairs(cfgRandomBossTriggerPool) do
    --     if (value.bosslist ~= nil) and (value.bosslist ~= '') then
    --         value.bosslist_tab = BF_Json2Table(value.bosslist)
    --     else
    --         value.bosslist_tab = {}
    --     end

    --     if (value.rewardlist ~= nil) and (value.rewardlist ~= '') then
    --         value.rewardlist_tab = BF_Json2Table(value.rewardlist)
    --     else
    --         value.rewardlist_tab = {}
    --     end
    -- end  

    -- --FreeVIP
    -- for _, value in pairs(cfgFreeVIP) do
    --     if (value.addprop ~= nil) and (value.addprop ~= '') then
    --         value.addprop_tab = BF_Json2Table(value.addprop)
    --         value.addprop_desctab = BF_GetPropDescTableByJson(value.addprop)
    --         value.addprop_abstr = BF_GetAbilityStrByABTab(value.addprop_tab)
    --     else
    --         value.addprop_tab = {}
    --         value.addprop_desctab = {}
    --         value.addprop_abstr = ''
    --     end

    --     if (value.dayrewards ~= nil) and (value.dayrewards ~= '') then
    --         value.dayrewards_tab = BF_Json2Table(value.dayrewards)
    --     else
    --         value.dayrewards_tab = {}
    --     end
    -- end
    
    -- --FreeVIPTask
    -- for _, value in pairs(cfgFreeVIPTask) do
    --     if (value.finishrewards ~= nil) and (value.finishrewards ~= '') then
    --         value.finishrewards_tab = BF_Json2Table(value.finishrewards)
    --     else
    --         value.finishrewards_tab = {}
    --     end
    -- end 

    -- --FirstRecharge
    -- for _, value in pairs(cfgFirstRecharge) do
    --     if (value.freerewards ~= nil) and (value.freerewards ~= '') then
    --         value.freerewards_tab = BF_Json2Table(value.freerewards)
    --     else
    --         value.freerewards_tab = {}
    --     end
    --     if (value.doublerewards ~= nil) and (value.doublerewards ~= '') then
    --         value.doublerewards_tab = BF_Json2Table(value.doublerewards)
    --     else
    --         value.doublerewards_tab = {}
    --     end        
    -- end    

    -- --ActivityNewPlayerRecharge
    -- for _, value in pairs(cfgActivityNewPlayerRecharge) do
    --     if (value.rewards ~= nil) and (value.rewards ~= '') then
    --         value.rewards_tab = BF_Json2Table(value.rewards)
    --     else
    --         value.rewards_tab = {}
    --     end
    -- end  

    -- --ActivityOpenServer
    -- for _, value in pairs(cfgActivityOpenServer) do
    --     if (value.rewards ~= nil) and (value.rewards ~= '') then
    --         value.rewards_tab = BF_Json2Table(value.rewards)
    --     else
    --         value.rewards_tab = {}
    --     end
    -- end      

    -- --ActivityExtendGift
    -- for _, value in pairs(cfgActivityExtendGift) do
    --     if (value.rewards ~= nil) and (value.rewards ~= '') then
    --         value.rewards_tab = BF_Json2Table(value.rewards)
    --     else
    --         value.rewards_tab = {}
    --     end
    --     if (value.needitems ~= nil) and (value.needitems ~= '') then
    --         value.needitems_tab = BF_Json2Table(value.needitems)
    --     else
    --         value.needitems_tab = {}
    --     end        
    -- end    

    -- --RecycleManager
    -- for _, value in pairs(cfgRecycleSetting) do
    --     if (value.recycleitems ~= nil) and (value.recycleitems ~= '') then
    --         value.recycleitems_tab = BF_Json2Table(value.recycleitems)
    --     else
    --         value.recycleitems_tab = {}
    --     end

    --     if (value.stdmodelist ~= nil) and (value.stdmodelist ~= '') then
    --         value.stdmodelist_tab = BF_Json2Table(value.stdmodelist)
    --     else
    --         value.stdmodelist_tab = {}
    --     end       
    --     if (value.itemidlist ~= nil) and (value.itemidlist ~= '') then
    --         value.itemidlist_tab = BF_Json2Table(value.itemidlist)
    --     else
    --         value.itemidlist_tab = {}
    --     end        
    -- end    

    -- --EverydayTask
    -- for _, value in pairs(cfgEverydayTask) do
    --     if (value.finishrewards ~= nil) and (value.finishrewards ~= '') then
    --         value.finishrewards_tab = BF_Json2Table(value.finishrewards)
    --     else
    --         value.finishrewards_tab = {}
    --     end     
    -- end

    -- --UnpackItem
    -- for _, value in pairs(cfgUnpackItem) do
    --     if (value.fixedrewards ~= nil) and (value.fixedrewards ~= '') then
    --         value.fixedrewards_tab = BF_Json2Table(value.fixedrewards)
    --     else
    --         value.fixedrewards_tab = {}
    --     end

    --     if (value.randomrewards ~= nil) and (value.randomrewards ~= '') then
    --         value.randomrewards_tab = BF_Json2Table(value.randomrewards)
    --     else
    --         value.randomrewards_tab = {}
    --     end        
    -- end    

    -- --MoFangZhen
    -- for _, value in pairs(cfgMoFangZhen) do
    --     if (value.desc1 ~= nil) and (value.desc1 ~= '') then
    --         value.desc1_tab = string.split(value.desc1, '|')
    --         if value.desc1_tab == false then
    --             value.desc1_tab = {}
    --         end
    --     else
    --         value.desc1_tab = {}
    --     end  
        
    --     if (value.desc2 ~= nil) and (value.desc2 ~= '') then
    --         value.desc2_tab = string.split(value.desc2, '|')
    --         if value.desc2_tab == false then
    --             value.desc2_tab = {}
    --         end
    --     else
    --         value.desc2_tab = {}
    --     end        
    -- end   

    -- --部分初始化代码
    -- TaskManager.InitAddListenMon()
end

function UIncludes()
    local _,errinfo = pcall(_Includes)
    if errinfo then
        release_print("UIncludes", errinfo)
    end
    --release_print(100000000)
end
