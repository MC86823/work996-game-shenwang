CommonDefine = {
    --调试模式  0表示正常  1表示调试模式
    DEBUG_MODE = 1,

    --职业
    JOB_Z = 0,
    JOB_F = 1,
    JOB_D = 2,
    JOB_ALL = 3,

    --性别
    GENDER_MAN = 0,
    GENDER_WOMAN = 1,

    --基础道具ID
    ITEMID_GOLD = 1,        --金币
    ITEMID_YB = 2,          --元宝
    ITEMID_BINDGOLD = 3,    --绑定金币
    ITEMID_BINDYB = 4,      --绑定元宝
    ITEMID_JINGANGSHI = 5,  --金刚石
    ITEMID_EXP = 6,         --经验
    ITEMID_MOFANGZHEN_JIFEN = 20,   --魔方阵积分
    ITEMID_XINYUNFU = 208,  --幸运符
    ITEMID_BAODIFU = 209,   --保底符

    --道具的Stdmode
    ITEM_STDMODE_SOULSTONE = 53,    --魂石的stdmode

    --装备位
    EQUIPPOS_DRESS = 0,
    EQUIPPOS_WEAPON = 1,
    EQUIPPOS_MEDAL = 2,
    EQUIPPOS_NECKLACE = 3,
    EQUIPPOS_HELMET = 4,
    EQUIPPOS_ARMRING_R = 5,
    EQUIPPOS_ARMRING_L = 6,
    EQUIPPOS_RING_R = 7,
    EQUIPPOS_RING_L = 8,
    EQUIPPOS_BELT = 10,
    EQUIPPOS_BOOTS = 11,

    --装备位【首饰盒】
    EQUIPPOS_SSH_1 = 30,
    EQUIPPOS_SSH_2 = 31,
    EQUIPPOS_SSH_3 = 32,
    EQUIPPOS_SSH_4 = 33,
    EQUIPPOS_SSH_5 = 34,
    EQUIPPOS_SSH_6 = 35,
    EQUIPPOS_SSH_7 = 36,
    EQUIPPOS_SSH_8 = 37,
    EQUIPPOS_SSH_9 = 38,
    EQUIPPOS_SSH_10 = 39,
    EQUIPPOS_SSH_11 = 40,
    EQUIPPOS_SSH_12 = 41,

    --装备位对应的名称
    EQUIPPOS_NAME = {},
    --基础装备位
    BASE_EQUIPMENT_POS = {},

    --消息位置类型
    MSG_POS_TYPE_SYS_CHANNEL = 1,           --系统频道
    MSG_POS_TYPE_GUILD_CHANNEL = 2,         --行会频道
    MSG_POS_TYPE_TEAM_CHANNEL = 3,          --组队频道
    MSG_POS_TYPE_TOP_ROLL = 4,              --顶部跑马灯
    MSG_POS_TYPE_ALL_ROLL = 5,              --屏幕跑马灯公告,可控制Y轴
    MSG_POS_TYPE_CHATBOX_TOP = 6,           --聊天上方公告
    MSG_POS_TYPE_FIX_CHAT = 8,              --固定聊天
    MSG_POS_TYPE_SYSTEM_TIPS = 9,           --系统提示区域
    MSG_POS_TYPE_XY_BROADCAST = 10,         --可控制xy坐标广播
    --12=系统频道 带超链;
    --13=系统公告缩放    

    --攻击模式
    ATTACK_MODE_ALL = 0,                 --全体攻击
    ATTACK_MODE_PEACE = 1,               --和平攻击
    ATTACK_MODE_COUPLE = 2,              --夫妻攻击
    ATTACK_MODE_SHITU = 3,               --师徒攻击
    ATTACK_MODE_GROUP = 4,               --编组攻击
    ATTACK_MODE_GUILD = 5,               --行会攻击
    ATTACK_MODE_REDNAME = 6,             --红名攻击
    ATTACK_MODE_NATION = 7,              --国家攻击
    ATTACK_MODE_ZHENYIN = 8,             --阵营攻击

    --对象信息属性
    INFO_NAME = 1,
    INFO_USERID = 2,
    INFO_MAPSTR = 3,
    INFO_MAPX = 4,
    INFO_MAPY = 5,
    INFO_LEVEL = 6,
    INFO_JOB = 7,
    INFO_GENDER = 8,
    INFO_CURRHP = 9,
    INFO_MAXHP = 10,
    INFO_CURRMP = 11,
    INFO_MAXMP = 12,
    INFO_EXP = 13,
    INFO_LEVELMAXEXP = 14,
    INFO_HUMBAGITEMNUM = 34,             --玩家背包中的物品数量
    INFO_GUILDNAME = 36,                 --玩家行会名
    INFO_SLAVECOUNT = 38,                --宝宝数量
    INFO_MONIDX = 55,                    --怪物的Idx
    INFO_NAMECOLOR = 56,                 --名字颜色
    INFO_BAGCOUNT = 63,                  --背包大小

    --标准物品信息
    STDITEMINFO_IDX = 0,                 --物品ID
    STDITEMINFO_NAME = 1,                --物品名
    STDITEMINFO_STDMODE = 2,             --StdMode  大类
    STDITEMINFO_SHAPE = 3,               --Shape    小类
    STDITEMINFO_WEIGHT = 4,              --重量
    STDITEMINFO_ANICOUNT = 5,            --AniCount
    STDITEMINFO_MAXDURA = 6,             --最大持久
    STDITEMINFO_OVERLAP = 7,             --叠加数量
    STDITEMINFO_SELLPRICE = 8,           --价格
                                         --
    STDITEMINFO_NEEDLV = 10,             --使用等级
    STDITEMINFO_PARAM1 = 11,             --自定义变量1
    STDITEMINFO_PARAM2 = 12,             --自定义变量2

    --实体道具信息
    ITEMINFO_UNIQUEID = 1,               --唯一ID
    ITEMINFO_ITEMIDX = 2,                --物品ID
    ITEMINFO_CURRDURA = 3,               --剩余持久
    ITEMINFO_MAXDURA = 4,                --最大持久
    ITEMINFO_OVERLAP = 5,                --叠加数量
    ITEMINFO_BIND = 6,                   --绑定状态
    ITEMINFO_SRCNAME = 7,                --物品名称(引擎64_23.08.30新增)
    ITEMINFO_CHGEDNAME = 8,              --物品改名后的名称(引擎64_24.08.07新增)   

    --道具品质
    ITEM_QUALITY_WHITE = 0,               --白色
    ITEM_QUALITY_GREEN = 1,               --绿色
    ITEM_QUALITY_BLUE = 2,                --蓝色
    ITEM_QUALITY_PURPLE = 3,              --紫色
    ITEM_QUALITY_PINK = 4,                --粉色
    ITEM_QUALITY_GOLD = 5,                --金色
    ITEM_QUALITY_RED = 6,                 --红色

    ITEM_QUALITY_COLORNAME = {},          --道具的品质颜色名字

    --怪物颜色  这个和游戏逻辑有关
    MON_NAME_COLOR_WHITE = 255,           --白色
    MON_NAME_COLOR_GOLD = 116,            --橙色
    MON_NAME_COLOR_RED = 22,              --红色
    
    --道具 additemvalue type=1时 position=0~49的定义
    ITEMADDVALUE_TYPE1_AC = 0,           --物防
    ITEMADDVALUE_TYPE1_MAC = 1,          --魔防
    ITEMADDVALUE_TYPE1_DC = 2,           --攻击
    ITEMADDVALUE_TYPE1_MC = 3,           --魔法
    ITEMADDVALUE_TYPE1_SC = 4,           --道术
    ITEMADDVALUE_TYPE1_LUCK = 5,         --幸运

    --自定义装备属性组
    ITEM_CUSTOMEAB_GROUP_0 = 0,          --强化
    ITEM_CUSTOMEAB_GROUP_1 = 1,          --升星
    ITEM_CUSTOMEAB_GROUP_2 = 2,          --洗炼 极品
    ITEM_CUSTOMEAB_GROUP_3 = 3,          --天赋
    ITEM_CUSTOMEAB_GROUP_4 = 4,          --
    ITEM_CUSTOMEAB_GROUP_5 = 5,          --    

    --邮件ID
    MAIL_ID_BAGFULL = 100,               --背包已满，道具发放到邮件中

    --游戏成长属性
    ABILITYID_MAX_HP = 1,                --最大生命值
    ABILITYID_MAX_MP = 2,                --最大魔法值
    ABILITYID_MIN_DC = 3,                --最小攻击
    ABILITYID_MAX_DC = 4,                --最大攻击
    ABILITYID_MIN_MC = 5,                --最小魔法
    ABILITYID_MAX_MC = 6,                --最大魔法    
    ABILITYID_MIN_SC = 7,                --最小道术
    ABILITYID_MAX_SC = 8,                --最大道术    
    ABILITYID_MIN_AC = 9,                --最小物防
    ABILITYID_MAX_AC = 10,               --最大物防
    ABILITYID_MIN_MAC = 11,              --最小魔防
    ABILITYID_MAX_MAC = 12,              --最大魔防  doto...后续再加

    ABILITYID_CUS_EQUIPPOS_DC_ADDPERCENT = 200,    --装备位的攻击加成百分比
    ABILITYID_CUS_EQUIPPOS_MC_ADDPERCENT = 201,    --装备位的魔法加成百分比
    ABILITYID_CUS_EQUIPPOS_SC_ADDPERCENT = 202,    --装备位的道术加成百分比
    ABILITYID_CUS_EQUIPPOS_AC_ADDPERCENT = 203,    --装备位的物防加成百分比
    ABILITYID_CUS_EQUIPPOS_MAC_ADDPERCENT = 204,   --装备位的魔防加成百分比

    --自定义的百分比加成属性 对应的基础属性ID
    ADD_PERCENT_ABILITY_PAIR = {},

    --游戏玩家自定义属性组
    ABIL_GROUP_ADD_1 = 'abgroupadd1',        --装备位百分比加成的点数 1
    ABIL_GROUP_ADD_2 = 'abgroupadd2',        --装备位百分比加成的点数 2
    ABIL_GROUP_ADD_3 = 'abgroupadd3',        --装备位百分比加成的点数 3
    ABIL_GROUP_ADD_4 = 'abgroupadd4',        --装备位百分比加成的点数 4  
    ABIL_GROUP_ADD_5 = 'abgroupadd5',        --装备位百分比加成的点数 5
    ABIL_GROUP_ADD_6 = 'abgroupadd6',        --装备位百分比加成的点数 6
    ABIL_GROUP_ADD_7 = 'abgroupadd7',        --装备位百分比加成的点数 7
    ABIL_GROUP_ADD_8 = 'abgroupadd8',        --装备位百分比加成的点数 8
    ABIL_GROUP_ADD_9 = 'abgroupadd9',        --装备位百分比加成的点数 9
    ABIL_GROUP_ADD_10 = 'abgroupadd10',      --装备位百分比加成的点数 10

    ABIL_GROUP_HUWEI1 = 'huwei1',             --紫宸殿 护卫1
    ABIL_GROUP_HUWEI2 = 'huwei2',             --紫宸殿 护卫2
    ABIL_GROUP_HUWEI3 = 'huwei3',             --紫宸殿 护卫3
    ABIL_GROUP_HUWEI4 = 'huwei4',             --紫宸殿 护卫4
    ABIL_GROUP_HUWEI5 = 'huwei5',             --紫宸殿 护卫5    

    ABILITY_GROUP_STONE_PRENAME = 'stone_',   --魂石属性加成的前置组名
    ABILITY_GROUP_STONE_JIBAN = 'stonejiban', --魂石羁绊属性组名
    ABILITY_GROUP_GUANZHI = 'guanzhi',        --官职对应的属性加成
    ABILITY_GROUP_FREEVIP = 'freevip',        --FREEVIP对应的属性加成
    ABILITY_GROUP_TEMPTEST = 'temptest',      --临时测试对应的属性加成

    --装备位百分比增加属性值对应的属性组名  十个装备位分开
    EQUIPPOS_ADDAB_GROUP_NAME = {},    

    --游戏参数
    PLAYER_AUTO_ADDEXP_MAXLV = 50,              --新玩家自动获得经验的最大等级
    MAPNAME_NEWREN = 'xinr1',                   --新人地图
    MAPNAME_JQPD = 'jqpd',                      --激情泡点的地图名  
    ADDLUCK_USE_XYF_NUM = 1,                    --单次祝福使用幸运符数量
    ADDLUCK_USE_BDF_NUM = 1,                    --单次祝福使用保底符数量
    ADDLUCK_USE_XYF_ADDRATE = 20,               --祝福时使用幸运符增加的成功概率
    ITEM_COMPOSE_NEED_NUM = 3,                  --合成时需要的合成道具数量
    SOUL_STONE_SLOT_MAX_HOLE_NUM = 4,           --一个魂石槽位最大的孔数
    BACK_MAP_POSITION = {mapid=3, x=330, y=330},--回城点
    OFFLINE_FETCH_MIN_INTERVAL = 180,           --离线领取奖励的最小间隔，秒
    DAY_FREE_ENTER_MOFANGZHEN_TIMES = 2,        --每日免费进入魔方阵的次数
    MOFANGZHEN_ONCE_FOR_STAY_SECONDS = 1800,    --一次魔方阵可以待多长时间(秒)
    MOFANGZHEN_DAY_MAX_BUY_TIMES = 5,           --魔方阵每天最大购买次数
    MOFANGZHEN_DAY_BUY_NEEDITEMS = {{name='元宝', num=20}},     --魔方阵购买次数需要的消耗
    DAY_RANDOMBOSS_GETREWARD_MAXTIMES = 5,      --随机boss每天奖励最多领取5次
    DAY_RANDOMBOSS_TRIGGER_MAXTIMES = 3,        --随机boss每天最多触发3次
    ACTIVATED_AUTORECYCLE_FREEVIP_LV = 2,       --激活自动回收的免费VIP等级
    ACTIVATED_AUTORECYCLE_NEEDYB = 100,         --激活自动回收需要的元宝数量
    MAX_DISTANCE = 999999,                      --极限距离参数
    DAY_BAOZHUBOSS_GETREWARD_MAXTIMES = 5,      --宝珠boss[灵玉副本]每天奖励最多领取次数    
    EXTEND_STORAGE_ONCE_ADDNUM = 8,                                  --扩展一次仓库增加的格子数量
    EXTEND_STORAGE_ONCE_NEEDITEMS = {{name='绑定元宝', num=800}},     --扩展一次仓库所需的道具消耗
    SHOW_QUICK_TIP_MIN_LEVEL = 20,                                   --显示快捷提示的最小等级

    --通用的特殊地图内原地复活的消耗，随次数变化
    COMMON_LOCAL_RELIVE_NEED_ITEMS = {{{name='金币', num=10000}}, {{name='金币', num=20000}}, {{name='金币', num=30000}}, {{name='金币', num=40000}}, {{name='金币', num=50000}},
        {{name='金币', num=60000}}, {{name='金币', num=70000}}, {{name='金币', num=80000}}, {{name='金币', num=90000}}, {{name='金币', num=100000}},},      

    EQUIP_RANDOMAB_GOLD_NEEDITEMS = {},         --金币洗炼对应的消耗
    EQUIP_RANDOMAB_YB_NEEDITEMS = {},           --元宝洗炼对应的消耗
    CHECK_BOX_VAR = {},                         --CheckBox选项框


    --系统数字变量，重启不保存 I0 - I99
    VAR_I_CURR_DYNNPC_GROUPID = 'I1',            --当前系统对应的动态NPC的组编号,玩家登录时+1赋值

    --玩家数字变量，下线不保存 N0 - N99
    VAR_N_NPC_CHECKBOX_1 = 'N4',                --玩家NPC对话框中的第一个CheckBox选项
    VAR_N_NPC_CHECKBOX_2 = 'N5',                --玩家NPC对话框中的第二个CheckBox选项
    VAR_N_NPC_CHECKBOX_3 = 'N6',                --玩家NPC对话框中的第三个CheckBox选项
    VAR_N_NPC_CHECKBOX_4 = 'N7',                --玩家NPC对话框中的第四个CheckBox选项
    VAR_N_NPC_CHECKBOX_5 = 'N8',                --玩家NPC对话框中的第五个CheckBox选项
    VAR_N_NPC_CHECKBOX_6 = 'N9',                --玩家NPC对话框中的第六个CheckBox选项
    VAR_N_NPC_CHECKBOX_7 = 'N10',               --玩家NPC对话框中的第七个CheckBox选项
    VAR_N_NPC_CHECKBOX_8 = 'N11',               --玩家NPC对话框中的第八个CheckBox选项
    VAR_N_NPC_CHECKBOX_9 = 'N12',               --玩家NPC对话框中的第九个CheckBox选项
    VAR_N_NPC_CHECKBOX_10 = 'N13',              --玩家NPC对话框中的第十个CheckBox选项
    VAR_N_CHOOSE_ITEM_MAKEIDX = 'N14',          --玩家选择的背包中的道具makeidx
    VAR_N_CURR_NPC_DATA_PAGE1 = 'N15',          --玩家当前的NPC数据中的页数
    VAR_N_SOULSTONE_JBLEVEL = 'N16',            --玩家魂石羁绊等级
    VAR_N_CURR_DYNNPC_GROUPID = 'N17',          --玩家魂当前的动态NPC的组ID
    VAR_N_CURR_RANDOMBOSS_FIGHTING_ID = 'N18',  --玩家当前触发的随机BOSS的挑战ID
    VAR_N_LAST_OPER_TIME1 = 'N19',              --玩家上一次操作的时间记录1   用于处理一些需要操作短时间冷却的  几秒钟的CD
    VAR_N_LAST_OPER_TIME2 = 'N20',              --玩家上一次操作的时间记录2   用于处理一些需要操作短时间冷却的  几秒钟的CD
    VAR_N_LAST_ATTACK_MODE = 'N21',             --保存玩家当前的攻击模式
    VAR_U_CURR_TASKLINEID = 'N22',              --当前打开的任务对话对应的tasklineid
    VAR_N_NPC_CHECKBOX_11 = 'N23',              --玩家NPC对话框中的第十一个CheckBox选项
    VAR_N_NPC_CHECKBOX_12 = 'N24',              --玩家NPC对话框中的第十二个CheckBox选项
    VAR_N_NPC_CHECKBOX_13 = 'N25',              --玩家NPC对话框中的第十三个CheckBox选项    
    VAR_N_NPC_CHECKBOX_14 = 'N26',              --玩家NPC对话框中的第十四个CheckBox选项    
    VAR_N_CHOOSE_RECYCLE_TYPE = 'N27',          --玩家选择的回收类型
    VAR_N_COMMON_LOCAL_RELIVE_TIMES = 'N28',    --通用原地复活次数
    VAR_N_SELECT_COMPOSE_PILE_NUM = 'N29',      --合成可叠加道具时，选择的单个合成数量
    VAR_N_NPC_TEMPPARAM1 = 'N30',               --玩家NPC操作的参数1
    VAR_N_CHOOSE_OPER_TYPE = 'N31',             --玩家选择的操作类型  通用的临时变量 例如选择技能升级还是技能强化
    VAR_N_LAST_PLAYERPOWER = 'N32',             --玩家最近一次变化的战力
    VAR_N_LAST_NPC_CHOOSEID = 'N33',            --玩家最近一次NPC选择的id
    VAR_N_ITEM_COMPOSE_CHOOSE_ITEM1 = 'N34',    --玩家道具合成时，选择的第一件合成物品，每次使用需检测

    --玩家字符型变量，下线不保存 S0 - S99
    VAR_S_SELECT_ITEM = 'S0',
    VAR_S_SELECT_COMPOSE_ITEMS = 'S1',          --选择的所有待合成装备 唯一ID ,分割    

    --玩家数字变量，下线保存   U0 - U254
    VAR_U_ADVANCE_SKILL1_LV = 'U51',            --进阶技能等级保存，用于伤害计算  占用
    VAR_U_ADVANCE_SKILL2_LV = 'U52',
    VAR_U_ADVANCE_SKILL3_LV = 'U53',
    VAR_U_ADVANCE_SKILL4_LV = 'U54',
    VAR_U_ADVANCE_SKILL5_LV = 'U55',
    VAR_U_ADVANCE_SKILL6_LV = 'U56',
    VAR_U_ADVANCE_SKILL7_LV = 'U57',
    VAR_U_ADVANCE_SKILL8_LV = 'U58',
    VAR_U_ADVANCE_SKILL9_LV = 'U59',
    VAR_U_ADVANCE_SKILL10_LV = 'U60',
    VAR_U_ADVANCE_SKILL11_LV = 'U61',
    VAR_U_ADVANCE_SKILL12_LV = 'U62',
    VAR_U_ADVANCE_SKILL13_LV = 'U63',
    VAR_U_ADVANCE_SKILL14_LV = 'U64',
    VAR_U_ADVANCE_SKILL15_LV = 'U65',
    VAR_U_ADVANCE_SKILL16_LV = 'U66',
    VAR_U_ADVANCE_SKILL17_LV = 'U67',
    VAR_U_ADVANCE_SKILL18_LV = 'U68',
    VAR_U_ADVANCE_SKILL19_LV = 'U69',
    VAR_U_ADVANCE_SKILL20_LV = 'U70',
    VAR_U_ADVANCE_SKILL21_LV = 'U71',
    VAR_U_ADVANCE_SKILL22_LV = 'U72',
    VAR_U_ADVANCE_SKILL23_LV = 'U73',
    VAR_U_ADVANCE_SKILL24_LV = 'U74',
    VAR_U_ADVANCE_SKILL25_LV = 'U75',
    VAR_U_ADVANCE_SKILL26_LV = 'U76',
    VAR_U_ADVANCE_SKILL27_LV = 'U77',
    VAR_U_ADVANCE_SKILL28_LV = 'U78',
    VAR_U_ADVANCE_SKILL29_LV = 'U79',
    VAR_U_ADVANCE_SKILL30_LV = 'U80',    

    VAR_U_GUANZHI_LEVEL = 'U100',               --玩家的官职等级
    VAR_U_GUANZHI_CURREXP = 'U101',             --玩家的官职当前经验
    VAR_U_ZCDHW_LEVEL1 = 'U102',                --玩家的紫宸殿护卫1等级
    VAR_U_ZCDHW_LEVEL2 = 'U103',                --玩家的紫宸殿护卫2等级
    VAR_U_ZCDHW_LEVEL3 = 'U104',                --玩家的紫宸殿护卫3等级
    VAR_U_ZCDHW_LEVEL4 = 'U105',                --玩家的紫宸殿护卫4等级
    VAR_U_ZCDHW_LEVEL5 = 'U106',                --玩家的紫宸殿护卫5等级
    VAR_U_MOFANG_CURR_LAYER = 'U107',           --玩家当前进入的魔方阵的层数
    VAR_U_MOFANG_LEFT_BUYTIMES = 'U108',        --玩家当前剩余购买的进入魔方地图的次数
    VAR_U_MOFANGZHEN_ID = 'U109',               --玩家魔方阵当前进入的ID
    VAR_U_FREEVIPTASK_COUNTER1 = 'U110',        --免费VIP任务计数1
    VAR_U_FREEVIPTASK_COUNTER2 = 'U111',        --免费VIP任务计数2
    VAR_U_FREEVIPTASK_COUNTER3 = 'U112',        --免费VIP任务计数3
    VAR_U_FREEVIPTASK_COUNTER4 = 'U113',        --免费VIP任务计数4
    VAR_U_FREEVIPTASK_COUNTER5 = 'U114',        --免费VIP任务计数5
    VAR_U_FREEVIP_LEVEL = 'U115',               --免费VIP等级
    VAR_U_ID_TASKLINE1 = 'U116',                --任务1线当前任务ID
    VAR_U_STATUS_TASKLINE1 = 'U117',            --任务1线当前任务状态
    VAR_U_ID_TASKLINE2 = 'U116',                --任务2线当前任务ID
    VAR_U_STATUS_TASKLINE2 = 'U117',            --任务2线当前任务状态
    VAR_U_ID_TASKLINE3 = 'U116',                --任务3线当前任务ID
    VAR_U_STATUS_TASKLINE3 = 'U117',            --任务3线当前任务状态     
    VAR_U_RECHARGE_TOTAL = 'U118',              --累计充值 RMB
    VAR_U_FIRST_RECHARGE_DAY = 'U119',          --首充的日期记录
    VAR_U_FIRST_LOGIN_DAY = 'U120',             --首次登录游戏的日期记录
    VAR_U_NEWPLAYER_RECHARGE_SINGLE = 'U121',   --新人充值返利活动，单笔最大充值
    VAR_U_NEWPLAYER_RECHARGE_TOTAL = 'U122',    --新人充值返利活动，累计最大充值
    VAR_U_LAST_RECORD_WEEK = 'U123',            --玩家跨天时记录的周数
    VAR_U_LOGINDAYS_IN_WEEK = 'U124',           --玩家一周里的跨天次数
    VAR_U_LAST_LOGIN_TIME = 'U125',             --玩家上一次登录时间，跨天重置
    VAR_U_TREASUREMAP_CURRID = 'U126',          --当前对应的藏宝图配置id
    VAR_U_BIAOCHE_CURRID = 'U127',              --当前对应的镖车配置ID
    VAR_U_BIAOCHE_REFRESH_TIMES = 'U128',       --镖车刷新次数，接受镖车后清0
    
    --玩家字符型变量，下线保存 T0 - T254
    VAR_T_EQUIPPOS_STRENGTH_INFO = 'T1',        --玩家的装备位强化信息
    VAR_T_EQUIPPOS_UPGRADESTAR_INFO = 'T2',     --玩家的装备位升星信息
    VAR_T_SOULSTONE_SLOT_INFO = 'T3',           --玩家的魂石槽位信息
    VAR_T_OFFLINE_REWARD_INFO = 'T4',           --玩家的离线奖励相关信息   
    VAR_T_COUNTERDATA_TASKLINE1 = 'T5',         --任务1线的计数变量
    VAR_T_COUNTERDATA_TASKLINE2 = 'T6',         --任务2线的计数变量
    VAR_T_COUNTERDATA_TASKLINE3 = 'T7',         --任务3线的计数变量
    VAR_T_NEWPLAYER_SINGLERECHARGE_REWARDDATA = 'T8',    --新人充值返利领奖信息--单充
    VAR_T_NEWPLAYER_TOTALRECHARGE_REWARDDATA = 'T9',     --新人充值返利领奖信息--累充
    VAR_T_OPENSERVER_REWARDDATA1 = 'T10',                --开服活动领奖信息--每日活跃
    VAR_T_OPENSERVER_REWARDDATA2 = 'T11',                --开服活动领奖信息--每周活跃
    VAR_T_OPENSERVER_REWARDDATA3 = 'T12',                --开服活动领奖信息--等级达标
    VAR_T_OPENSERVER_REWARDDATA4 = 'T13',                --开服活动领奖信息--战力达标
    VAR_T_EXTENDGIFT_REWARDDATA = 'T14',                 --进阶礼包领奖信息

    --玩家数字变量，下线保存，0点重置 J0 - J499
    VAR_J_DAY_BAOZHU_BOSS_TIMES = 'J1',         --玩家今日进入宝珠BOSS地图的次数
    VAR_J_DAY_GUAZHI_ADDEXP = 'J2',             --玩家今日获得的官职经验
    VAR_J_DAY_GUAZHI_GETREWARD = 'J3',          --玩家今日是否已领取官职奖励
    VAR_J_DAY_MOFANG_LEFT_FREETIMES = 'J4',     --玩家今日剩余可免费进入魔方地图的次数
    VAR_J_DAY_MOFANG_BUYTIMES = 'J5',           --玩家今日魔方阵购买次数
    VAR_J_DAY_MOFANG_ENTER_TIME = 'J6',         --玩家今日魔方阵进入时间
    VAR_J_DAY_MOFANG_STAY_SECONDS = 'J7',       --玩家今日魔方阵可待时间（秒）
    VAR_J_DAY_RANDOMBOSS_REWARDTIMES = 'J8',    --玩家今日随机BOSS领奖次数
    VAR_J_DAY_RANDOMBOSS_TRIGGERTIMES = 'J9',   --玩家今日随机BOSS触发次数
    VAR_J_DAY_FREEVIP_REWARDTIMES = 'J10',      --玩家今日领取每日VIP奖励次数
    VAR_J_DAY_RECHARGE_TOTAL = 'J11',           --玩家今日的总充值
    VAR_J_DAY_ONLINE_TIME = 'J12',              --玩家今日的在线时长
    VAR_J_DAY_SINGLEBOSS_KILLTIMES = 'J13',     --玩家今日击杀单人首领的次数
    VAR_J_DAY_SINGLEBOSS_BUYTIMES = 'J14',      --玩家今日购买单人首领的次数
    VAR_J_DAY_EVERYDAYTASK_FINALREWARD_IDX = 'J15',     --玩家 每日任务累计领奖编号     
    VAR_J_DAY_TREASUREMAP_USETIMES = 'J16',             --玩家 今日使用藏宝图次数
    VAR_J_DAY_TREASUREMAP_NO_PANELTIP_FLAG = 'J17',     --玩家 今日不再显示藏宝图的提示面板
    VAR_J_DAY_BIAOCHE_ACCEPT_TIMES = 'J18',             --玩家 今日接镖次数
    
    --玩家字符变量，下线保存，0点重置 Z0 - Z499
    VAR_Z_DAY_EVERYDAYTASK_COUNTER_DATA = 'Z1',         --玩家 每日任务 子任务计数
    VAR_Z_DAY_EVERYDAYTASK_REWARD_DATA = 'Z2',          --玩家 每日任务 子任务领奖记录
    

    --玩家的位标记，下线保存  索引【1~800】
    VAR_HUM_BITFLAG_USE_XYF = 1,                --祝福是否使用幸运符
    VAR_HUM_BITFLAG_USE_BDF = 2,                --祝福是否使用保底符
    VAR_HUM_BITFLAG_RECYCLE_BAOZHU_1 = 3,       --白色灵珠是否回收
    VAR_HUM_BITFLAG_RECYCLE_BAOZHU_2 = 4,       --绿色灵珠是否回收
    VAR_HUM_BITFLAG_RECYCLE_BAOZHU_3 = 5,       --蓝色灵珠是否回收
    VAR_HUM_BITFLAG_RECYCLE_BAOZHU_4 = 6,       --紫色灵珠是否回收
    VAR_HUM_BITFLAG_RECYCLE_BAOZHU_5 = 7,       --粉色灵珠是否回收
    VAR_HUM_BITFLAG_RECYCLE_BAOZHU_6 = 8,       --橙色灵珠是否回收
    VAR_HUM_BITFLAG_RECYCLE_BAOZHU_KEEPBETTER = 9,  --灵珠回收时，是否保留比穿戴更好的    
    VAR_HUM_BITFLAG_MFZ_ADDTIME_FLAG1 = 10,         --魔方阵 增加时间标记1 确认后用1次换增加30分钟
    VAR_HUM_BITFLAG_MFZ_ADDTIME_FLAG2 = 11,         --魔方阵 增加时间标记2 确认后时间不足自动用次数换时间
    VAR_HUM_BITFLAG_FREEVIP_TASK_DRAWFLAG1 = 12,    --免费VIP任务1 是否领奖
    VAR_HUM_BITFLAG_FREEVIP_TASK_DRAWFLAG2 = 13,    --免费VIP任务2 是否领奖
    VAR_HUM_BITFLAG_FREEVIP_TASK_DRAWFLAG3 = 14,    --免费VIP任务3 是否领奖
    VAR_HUM_BITFLAG_FREEVIP_TASK_DRAWFLAG4 = 15,    --免费VIP任务4 是否领奖
    VAR_HUM_BITFLAG_FREEVIP_TASK_DRAWFLAG5 = 16,    --免费VIP任务5 是否领奖
    VAR_HUM_BITFLAG_NPC_TEMP_CHOOSE_FLAG = 17,      --NPC上的临时操作标记
    VAR_HUM_BITFLAG_FIRSTRECHARGE_REWARD1 = 18,     --首充奖励领取标记1
    VAR_HUM_BITFLAG_FIRSTRECHARGE_REWARD2 = 19,     --首充奖励领取标记2
    VAR_HUM_BITFLAG_FIRSTRECHARGE_REWARD3 = 20,     --首充奖励领取标记3

    VAR_HUM_BITFLAG_RECYCLE_ITEM1_1 = 21,           --白色装备是否回收
    VAR_HUM_BITFLAG_RECYCLE_ITEM1_2 = 22,           --绿色装备是否回收
    VAR_HUM_BITFLAG_RECYCLE_ITEM1_3 = 23,           --蓝色装备是否回收
    VAR_HUM_BITFLAG_RECYCLE_ITEM1_4 = 24,           --紫色装备是否回收
    VAR_HUM_BITFLAG_RECYCLE_ITEM1_5 = 25,           --粉色装备是否回收
    VAR_HUM_BITFLAG_RECYCLE_ITEM1_6 = 26,           --金色装备是否回收
    VAR_HUM_BITFLAG_RECYCLE_ITEM1_7 = 27,           --红色装备是否回收
    VAR_HUM_BITFLAG_RECYCLE_ITEM2_1 = 28,           --白色直升宝石是否回收
    VAR_HUM_BITFLAG_RECYCLE_ITEM2_2 = 29,           --绿色直升宝石是否回收
    VAR_HUM_BITFLAG_RECYCLE_ITEM2_3 = 30,           --蓝色直升宝石是否回收
    VAR_HUM_BITFLAG_RECYCLE_ITEM2_4 = 31,           --紫色直升宝石是否回收
    VAR_HUM_BITFLAG_RECYCLE_ITEM2_5 = 32,           --粉色直升宝石是否回收
    VAR_HUM_BITFLAG_RECYCLE_ITEM2_6 = 33,           --金色直升宝石是否回收
    VAR_HUM_BITFLAG_RECYCLE_ITEM2_7 = 34,           --红色直升宝石是否回收
    VAR_HUM_BITFLAG_ACTIVATED_AUTORECYCLE = 35,     --激活自动回收功能
    VAR_HUM_BITFLAG_AUTORECYCLE_ITEM1 = 36,         --勾选装备自动回收
    VAR_HUM_BITFLAG_AUTORECYCLE_ITEM2 = 37,         --勾选直升宝石自动回收
    VAR_HUM_BITFLAG_IS_FIRST_RANDOMBOSS_REWARD = 38,       --是否是第一个战力boss的奖励
    VAR_HUM_BITFLAG_IS_FIRST_RANDOMBOSS_TRIGGER = 39,      --是否是触发的第一个战力boss


    VAR_HUM_BITFLAG_NEW_PLAYER_INIT_FLAG = 100,     --玩家是否进行新手初始化
    VAR_HUM_BITFLAG_RELIVE_DIALOGUE_FLAG = 101,     --玩家是否当前已有复活框弹出

    --道具的int变量 1-50
    ITEM_INTVAR_ADDLUCK_LV = 1,                 --道具的祝福等级
    ITEM_INTVAR_RANDOMAB_NUM = 2,               --装备洗炼属性的条数
    ITEM_INTVAR_RANDOMAB_CURR_SEQ = 3,          --装备洗炼当前选择的第几条属性  未洗炼状态  作为临时变量
    ITEM_INTVAR_RANDOMAB_STATS = 4,             --装备洗炼的当前状态 0无洗炼属性待洗炼状态  1已洗炼出属性待处理状态
    ITEM_INTVAR_ATTACK_SPEEDUP_INITGIFT = 6,    --装备加速属性【由装备天赋给予的】

    --道具的字符串变量 1-20
    --ITEM_STRVAR_RANDOMAB_DATA = 1,                --装备洗炼属性的数据保存
    ITEM_STRVAR_RANDOMAB_CREATE_SINGLEAB = 2,       --装备洗炼生成的单挑属性

    --地图的int变量 1-50
    MAP_INTVAR_RANDOMBOSS_TRIGGER_STARTTIME = 1,    --触发随机boss的生成时间
    MAP_INTVAR_RANDOMBOSS_TRIGGER_ID = 2,           --触发随机boss的触发ID

    --地图的string变量 1-50
    MAP_STRVAR_RANDOMBOSS_TRIGGER_NAME = 1,         --触发随机boss的玩家名
    MAP_STRVAR_RANDOMBOSS_MONNAME = 2,              --触发随机boss的怪物名字
    MAP_STRVAR_RANDOMBOSS_MONUNIQUEID = 3,          --触发随机boss的怪物唯一ID

    --监听事件类型名
    EVENT_NAME_PLAYER_ENTERGAME = 'player_entergame',   --玩家进入游戏
    EVENT_NAME_PLAYER_LEAVEGAME = 'player_leavegame',   --玩家退出游戏
    EVENT_NAME_PLAYER_ADDBAGITEM = 'player_addbag',     --玩家道具进背包
    EVENT_NAME_PLAYER_ENTERMAP = 'player_entermap',     --玩家进入地图
    EVENT_NAME_PLAYER_LEAVEMAP = 'player_leavemap',     --玩家离开地图
    EVENT_NAME_PLAYER_DIE = 'player_die',               --玩家死亡
    EVENT_NAME_MON_KILLED = 'mon_killed',               --怪物被击杀
    EVENT_NAME_KILL_PLAYER = 'kill_player',             --击杀玩家
    EVENT_NAME_PLAYER_RESETDAY = 'player_resetday',     --玩家跨天
    EVENT_NAME_PLAYER_RESETWEEK = 'player_resetweek',   --玩家跨周
    EVENT_NAME_KILL_MON = 'kill_mon',                   --击杀怪物
    EVENT_NAME_CLICK_NPC = 'click_npc',                 --点击NPC
    EVENT_NAME_CLICK_TASK = 'click_task',               --点击任务
    EVENT_NAME_DO_RECHARGE = 'do_recharge',             --充值

    --玩家定时器ID
    TIMER_ID_MOFANGZHEN = 11,                   --魔方阵地图的定时器
    TIMER_ID_CHECK_TOPICON_REDPOINT = 12,       --检测topicon功能入口的小红点
    TIMER_ID_CHECK_QUICK_GOTO_TIP = 13,         --检测npc功能的快捷前往提示

    --功能模块编号
    FUNC_ID_EQUIPPOS_STRENGTH = 1,              --装备位强化
    FUNC_ID_EQUIPPOS_STAR = 2,                  --装备位升星
    FUNC_ID_EQUIP_RANDOMAB = 3,                 --装备洗炼
    FUNC_ID_WEAPON_ADDLUCK = 4,                 --武器祝福
    FUNC_ID_BAOZHU = 5,                         --宝珠系统
    FUNC_ID_BAOZHU_BOSS = 6,                    --宝珠BOSS
    FUNC_ID_SOUL_STONE = 7,                     --魂石
    FUNC_ID_GUANZHI = 8,                        --官职
    FUNC_ID_OFFLINE = 9,                        --离线系统 紫宸殿
    FUNC_ID_MOFANGZHEN = 10,                    --魔方阵
    FUNC_ID_RANDOMBOSS = 11,                    --随机BOSS
    FUNC_ID_FREEVIP = 12,                       --免费VIP
    FUNC_ID_GAMETASK = 13,                      --任务系统
    FUNC_ID_TOPICON = 14,                       --顶端功能入口
    FUNC_ID_FIRST_RECHARGE = 15,                --首充
    FUNC_ID_NEWPLAYER_RECHARGE = 16,            --新手充值返利
    FUNC_ID_RECYCLE_MANAGER = 17,               --回收系统
    FUNC_ID_OPEN_SERVER = 18,                   --开服活动
    FUNC_ID_PUBLIC_BOSS = 19,                   --野外首领
    FUNC_ID_SINGLE_BOSS = 20,                   --个人首领
    FUNC_ID_EVERYDAY_TASK = 21,                 --每日必做
    FUNC_ID_YUNBIAO = 22,                       --运镖
    FUNC_ID_TREASUREMAP = 23,                   --藏宝图
    FUNC_ID_COMPOSE = 24,                       --合成系统
    FUNC_ID_EXTEND_GIFT = 25,                   --进阶礼包
    

    --快捷前往
    QUICK_GOTO_UPGRADE_LEVEL = 1,               --升级
    QUICK_GOTO_INCREASE_POWER = 2,              --涨战力
    QUICK_GOTO_KILL_RANDOMBOSS = 3,             --击杀战力boss
    QUICK_GOTO_KILL_BAOZHUBOSS = 4,             --击杀宝珠【灵玉】boss
    QUICK_GOTO_ENTER_MOFANGZHEN = 5,            --进入魔方阵
    QUICK_GOTO_UPGRADE_EQUIPSTAR = 6,           --装备升星
    QUICK_GOTO_EQUIP_STRENGTH = 7,              --装备强化
    QUICK_GOTO_EQUIP_QUALITY = 8,               --装备品质
    QUICK_GOTO_EQUIP_RANDOMAB = 9,              --装备洗炼
    QUICK_GOTO_EQUIP_COMPOSE = 10,              --装备合成
    QUICK_GOTO_SOULSTONE = 11,                  --魂石系统
    QUICK_GOTO_BAOZHU = 12,                     --宝珠【灵玉】系统
    QUICK_GOTO_FREEVIP = 13,                    --免费VIP系统
    QUICK_GOTO_RECHARGE = 14,                   --充值界面
    QUICK_GOTO_SINGLEBOSS = 15,                 --个人首领
    QUICK_GOTO_PUBLICBOSS = 16,                 --野外首领
    QUICK_GOTO_YUNBIAO = 17,                    --运镖
    QUICK_GOTO_TREASUREMAP = 18,                --藏宝图
    QUICK_GOTO_GUANZHI = 19,                    --官职
    QUICK_GOTO_ZCD = 20,                        --紫宸殿 离线护卫

    --脚本创建的动态npcid    最终的npcid是 系统组编号*10000+动态id
    DYN_NPC_ZCD_HUWEI1 = 101,                     --紫宸殿护卫1
    DYN_NPC_ZCD_HUWEI2 = 102,                     --紫宸殿护卫2
    DYN_NPC_ZCD_HUWEI3 = 103,                     --紫宸殿护卫3
    DYN_NPC_ZCD_HUWEI4 = 104,                     --紫宸殿护卫4
    DYN_NPC_ZCD_HUWEI5 = 105,                     --紫宸殿护卫5

    --任务线ID
    TASK_LINE_ID_MAIN = 100,                      --任务线，主线任务
    TASK_LINE_ID_BRANCH = 201,                    --任务线，支线任务1

    --任务类型
    TASK_TYPE_KILLMON = 1,                        --杀怪任务
    TASK_TYPE_FREEVIP = 2,                        --免费VIP任务

    --任务线状态
    TASK_STATUS_NONE = 0,                         --无任务线
    TASK_STATUS_ADD = 1,                          --已添加，未接受
    TASK_STATUS_ACCEPT = 2,                       --已接受，未完成
    TASK_STATUS_FINISH = 3,                       --已完成，未领奖
    TASK_STATUS_END = 4,                          --已领奖，结束    
}

--装备位对应的名称
CommonDefine.EQUIPPOS_NAME = {
    [CommonDefine.EQUIPPOS_DRESS] = '衣服',
    [CommonDefine.EQUIPPOS_WEAPON] = '武器',
    [CommonDefine.EQUIPPOS_MEDAL] = '勋章',
    [CommonDefine.EQUIPPOS_NECKLACE] = '项链',
    [CommonDefine.EQUIPPOS_HELMET] = '头盔',
    [CommonDefine.EQUIPPOS_ARMRING_R] = '右手镯',
    [CommonDefine.EQUIPPOS_ARMRING_L] = '左手镯',
    [CommonDefine.EQUIPPOS_RING_R] = '右戒指',
    [CommonDefine.EQUIPPOS_RING_L] = '左戒指',
    [CommonDefine.EQUIPPOS_BELT] = '腰带',
    [CommonDefine.EQUIPPOS_BOOTS] = '鞋子',

    [CommonDefine.EQUIPPOS_SSH_1] = '鼠灵',
    [CommonDefine.EQUIPPOS_SSH_2] = '牛灵',
    [CommonDefine.EQUIPPOS_SSH_3] = '虎灵',
    [CommonDefine.EQUIPPOS_SSH_4] = '兔灵',
    [CommonDefine.EQUIPPOS_SSH_5] = '龙灵',
    [CommonDefine.EQUIPPOS_SSH_6] = '蛇灵',
    [CommonDefine.EQUIPPOS_SSH_7] = '马灵',
    [CommonDefine.EQUIPPOS_SSH_8] = '羊灵',
    [CommonDefine.EQUIPPOS_SSH_9] = '猴灵',
    [CommonDefine.EQUIPPOS_SSH_10] = '鸡灵',
    [CommonDefine.EQUIPPOS_SSH_11] = '狗灵',
    [CommonDefine.EQUIPPOS_SSH_12] = '猪灵',

}

--自定义的百分比加成属性 对应的基础属性ID
CommonDefine.ADD_PERCENT_ABILITY_PAIR = {
    [CommonDefine.ABILITYID_CUS_EQUIPPOS_DC_ADDPERCENT] = {CommonDefine.ABILITYID_MIN_DC, CommonDefine.ABILITYID_MAX_DC},
    [CommonDefine.ABILITYID_CUS_EQUIPPOS_MC_ADDPERCENT] = {CommonDefine.ABILITYID_MIN_MC, CommonDefine.ABILITYID_MAX_MC},
    [CommonDefine.ABILITYID_CUS_EQUIPPOS_SC_ADDPERCENT] = {CommonDefine.ABILITYID_MIN_SC, CommonDefine.ABILITYID_MAX_SC},
    [CommonDefine.ABILITYID_CUS_EQUIPPOS_AC_ADDPERCENT] = {CommonDefine.ABILITYID_MIN_AC, CommonDefine.ABILITYID_MAX_AC},
    [CommonDefine.ABILITYID_CUS_EQUIPPOS_MAC_ADDPERCENT] = {CommonDefine.ABILITYID_MIN_MAC, CommonDefine.ABILITYID_MAX_MAC},
}

--装备位百分比增加属性值对应的属性组名  十个装备位分开
CommonDefine.EQUIPPOS_ADDAB_GROUP_NAME = {
    [CommonDefine.EQUIPPOS_DRESS] = CommonDefine.ABIL_GROUP_ADD_1,
    [CommonDefine.EQUIPPOS_WEAPON] = CommonDefine.ABIL_GROUP_ADD_2,
    [CommonDefine.EQUIPPOS_NECKLACE] = CommonDefine.ABIL_GROUP_ADD_3,
    [CommonDefine.EQUIPPOS_HELMET] = CommonDefine.ABIL_GROUP_ADD_4,
    [CommonDefine.EQUIPPOS_ARMRING_R] = CommonDefine.ABIL_GROUP_ADD_5,
    [CommonDefine.EQUIPPOS_ARMRING_L] = CommonDefine.ABIL_GROUP_ADD_6,
    [CommonDefine.EQUIPPOS_RING_R] = CommonDefine.ABIL_GROUP_ADD_7,
    [CommonDefine.EQUIPPOS_RING_L] = CommonDefine.ABIL_GROUP_ADD_8,
    [CommonDefine.EQUIPPOS_BELT] = CommonDefine.ABIL_GROUP_ADD_9,
    [CommonDefine.EQUIPPOS_BOOTS] = CommonDefine.ABIL_GROUP_ADD_10,
}

--金币洗炼对应的消耗
CommonDefine.EQUIP_RANDOMAB_GOLD_NEEDITEMS = {
    {name='金币', num=10000},
}       

--道具的品质颜色
CommonDefine.ITEM_QUALITY_COLORNAME = {
    [CommonDefine.ITEM_QUALITY_WHITE+1]     = '白色',
    [CommonDefine.ITEM_QUALITY_GREEN+1]     = '绿色',
    [CommonDefine.ITEM_QUALITY_BLUE+1]      = '蓝色',
    [CommonDefine.ITEM_QUALITY_PURPLE+1]    = '紫色',
    [CommonDefine.ITEM_QUALITY_PINK+1]      = '粉色',
    [CommonDefine.ITEM_QUALITY_GOLD+1]      = '金色',
    [CommonDefine.ITEM_QUALITY_RED+1]       = '红色',
}

--元宝洗炼对应的消耗
CommonDefine.EQUIP_RANDOMAB_YB_NEEDITEMS = {
    {name='元宝', num=100},
}

--CheckBox选项框对应变量
CommonDefine.CHECK_BOX_VAR = {
    CommonDefine.VAR_N_NPC_CHECKBOX_1,
    CommonDefine.VAR_N_NPC_CHECKBOX_2,
    CommonDefine.VAR_N_NPC_CHECKBOX_3,
    CommonDefine.VAR_N_NPC_CHECKBOX_4,
    CommonDefine.VAR_N_NPC_CHECKBOX_5,
    CommonDefine.VAR_N_NPC_CHECKBOX_6,
    CommonDefine.VAR_N_NPC_CHECKBOX_7,
    CommonDefine.VAR_N_NPC_CHECKBOX_8,
    CommonDefine.VAR_N_NPC_CHECKBOX_9,
    CommonDefine.VAR_N_NPC_CHECKBOX_10,
    CommonDefine.VAR_N_NPC_CHECKBOX_11,
    CommonDefine.VAR_N_NPC_CHECKBOX_12,
    CommonDefine.VAR_N_NPC_CHECKBOX_13,
    CommonDefine.VAR_N_NPC_CHECKBOX_14,
}

--玩家的基础装备位  对应强化，升星，普通穿戴
CommonDefine.BASE_EQUIPMENT_POS = {
    CommonDefine.EQUIPPOS_DRESS, 
    CommonDefine.EQUIPPOS_WEAPON, 
    CommonDefine.EQUIPPOS_NECKLACE, 
    CommonDefine.EQUIPPOS_HELMET, 
    CommonDefine.EQUIPPOS_RING_L,
    CommonDefine.EQUIPPOS_RING_R, 
    CommonDefine.EQUIPPOS_ARMRING_L, 
    CommonDefine.EQUIPPOS_ARMRING_R, 
    CommonDefine.EQUIPPOS_BELT, 
    CommonDefine.EQUIPPOS_BOOTS
}

return CommonDefine