@echo off
Echo ============== Copy Config To Server EnvirData =================
Echo ==xcopy /y ".\NewConfig\cfg_att_score.xls" "E:\Game996\MirServer\Mir200\Envir\Data\" /I /E
Echo ==xcopy /y ".\NewConfig\cfg_custpro_caption.xls" "E:\Game996\MirServer\Mir200\Envir\Data\" /I /E

Echo ============== Copy ScriptConfig To Server =================
xcopy /y .\DevVersion_Server\Envir\Data\*.*  E:\Game996_ShenWang\MirServer\Mir200\Envir\Data\ /I /E
xcopy /y .\DevVersion_Server\Envir\MapQuest_Def\*.*  E:\Game996_ShenWang\MirServer\Mir200\Envir\MapQuest_Def\ /I /E
xcopy /y .\DevVersion_Server\Envir\Market_Def\*.*  E:\Game996_ShenWang\MirServer\Mir200\Envir\Market_Def\ /I /E
xcopy /y .\DevVersion_Server\Envir\QuestDiary\*.*  E:\Game996_ShenWang\MirServer\Mir200\Envir\QuestDiary\ /I /E

Echo ====== Finish=======

