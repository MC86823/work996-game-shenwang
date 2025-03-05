require("Envir/QuestDiary/CCLua/GameInit")
UIncludes()


----------------------------------------------------------------触发回调函数start--------------------------------------------------------------------------
-- 引擎启动触发
function startup(sysobj)  
    --自定义系统变量，暂时不考虑这个方案
    --inisysvar("integer","系统变量_1",0)  --声明合区时 保留主区
    --inisysvar("integer","系统变量_2",1)  --声明合区时 保留副区
    --inisysvar("integer","系统变量_3",2)  --声明合区时 取大
    --inisysvar("integer","系统变量_4",3)  --声明合区时 取小
    --inisysvar("integer","系统变量_5",4)  --声明合区时 相加
    --inisysvar("string","系统变量_6",5)   --声明合区时 相连
    --inisysvar("string","系统变量_7",6)   --声明合区时 删除    

    --老代码转化 功能？？？
    --[[
    local randnum = math.random(12, 16)
    setsysvar("G130", randnum)
    randnum = math.random(13, 17)
    setsysvar("G131", randnum)    
    ]]--
end

-- 角色登陆触发
function login(actor)
    --自定义玩家变量初始化，这个的管理不是太方便，暂时不使用
    --iniplayvar(actor, "integer", "HUMAN", "玩家变量_1")
    --iniplayvar(actor, "string", "HUMAN", "玩家变量_2")    
    -- #CALL [\游戏登陆\登陆脚本.txt] @登陆设置
    -- #CALL [\游戏登陆\封号系统.txt] @封号分类
    -- #CALL [\二级密码\二级密码.txt] @登录检测
    -- #CALL [\元宝捐款\元宝捐款数据.txt] @刷新
    -- #CALL [\元宝捐款\元宝捐款奖励.txt] @奖励
    -- #CALL [\游戏功能\装备吸血.txt] @吸血设置
    -- #CALL [\游戏功能\装备爆率.txt] @装备爆率      
    --[[
    --上线判断是否触发新手的自动升级
    if Player.GetLevel(actor) < CommonDefine.PLAYER_AUTO_ADDEXP_MAXLV then
        setontimer(actor, 0, 1)
    end
    --上线判断是否在激情泡点
    if Player.GetMapIDStr(actor) == CommonDefine.MAPNAME_JQPD then
        setontimer(actor, 5, 1)
    end
    ]]--

    
    --界面初始化
    TopIcon.InitUI(actor)
    GameCurrencyUI.InitUI(actor)
    MainUIBase.InitUI(actor)

    --玩家是否进行新手初始化
    Player.InitNewPlayer(actor)    

    --触发玩家上线的事件监听
    GameEventManager.DoTriggerEvent(CommonDefine.EVENT_NAME_PLAYER_ENTERGAME, actor)

    --检测加速状态
    Player.CheckSpeedUpStatus(actor)        

    recalcabilitys(actor)

    --更新战力信息
    local currpower = Player.GetPlayerPower(actor);
    setplaydef(actor, CommonDefine.VAR_N_LAST_PLAYERPOWER, currpower);
    Player.SendSelfMsg(actor, '当前战力:'..currpower, CommonDefine.MSG_POS_TYPE_SYS_CHANNEL)
    local str = '<Img|id=5010|children={5011}|x=272|y=30|img=private/cc_mainui/zhanli.png>'..
        '<Text|id=5011|text='..currpower..'|x=100|y=16|color='..CSS.NPC_WHITE..'|size=25>'
    addbutton(actor, 101, 999, str)    

    --上线处理称号相关逻辑
    --上线处理称号相关逻辑
    --上线处理称号相关逻辑
    --上线处理称号相关逻辑
    --上线处理称号相关逻辑 todo......
end

----------------------------------------------------------------触发回调函数end--------------------------------------------------------------------------


----------------------------------------------------------------ontimer个人定时器start--------------------------------------------------------------------------
--[[
---新手快速自动升级到50
function ontimer0(actor)
    if (Player.GetLevel(actor) < CommonDefine.PLAYER_AUTO_ADDEXP_MAXLV) and (Player.GetMapIDStr(actor) == CommonDefine.MAPNAME_NEWREN) then
        changeexp(actor, '+', 20000, false)
    end
end

--激情泡点
function ontimer5(actor)
    local nFlag = getsysvar('I66');
    if nFlag ~= 1 then
        return
    end

    local distance = BF_GetDistanceFromMapPoint(actor, CommonDefine.MAPNAME_JQPD, 23, 26);
    if distance <= 1 then
        changemoney(actor, CommonDefine.ITEMID_GOLD, '+', 20, '泡点', true)
        changeexp(actor, '+', 300000, true)     --激情泡点经验加聚灵珠上
    elseif distance <= 2 then
        changemoney(actor, CommonDefine.ITEMID_GOLD, '+', 15, '泡点', true)
        changeexp(actor, '+', 200000, true)     --激情泡点经验加聚灵珠上
    elseif distance <= 3 then
        changemoney(actor, CommonDefine.ITEMID_GOLD, '+', 10, '泡点', true)
        changeexp(actor, '+', 100000, true)     --激情泡点经验加聚灵珠上
    end 
end
]]--

--魔方阵
function ontimer11(actor)
    MoFangZhenManager.OnTimerCheck(actor)
end

--topicon的小红点
function ontimer12(actor)
    TopIcon.CheckRedPoint(actor)
end

--快捷前往的提示
function ontimer13(actor)
    TopIcon.CheckQuickInfoTip(actor)
end

----------------------------------------------------------------ontimer个人定时器end--------------------------------------------------------------------------
