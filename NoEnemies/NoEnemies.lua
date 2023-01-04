ModUtil.RegisterMod("NoEnemies")

ModUtil.LoadOnce( function()
  ModUtil.MapSetTable(EncounterData.Empty,{UnthreadedEvents = EncounterSets.EncounterEventsNonCombat})
end)

function FinishRun()
	AddTimerBlock( CurrentRun, "done")
	HadesKillPresentation()
	ShowRunClearScreen()
end

ModUtil.WrapBaseFunction( "ChooseRoomReward", function(baseFunc, roomData, args)
	return nil
end, NoEnemies)

ModUtil.WrapBaseFunction( "BossIntro", function(baseFunc, eventSource, args)

	--fix camera after boss fights, end of intro function usually does this
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = args.DurationOut or 1.25, EaseIn = 0.04, EaseOut = 0.275 })

	if CurrentRun.CurrentRoom.Name == "D_Boss01" then
		FinishRun()
	end
end, NoEnemies)

--fix crash in alecto/tis
ModUtil.WrapBaseFunction( "MultiFuryIntro", function(baseFunc, eventSource, args) 
end, NoEnemies)

ModUtil.WrapBaseFunction( "DoPatches", function(baseFunc) 
	baseFunc()
	--nil check for fresh file
	if CurrentRun ~= nil then
		CurrentRun.CurrentRoom.Encounter = EncounterData.Empty
	end
end, NoEnemies)

ModUtil.WrapBaseFunction( "GetPreviousStore", function(baseFunc, args) 
	--fix crash charlie was getting in styx
	return nil
end, NoEnemies)

--dad kill function relies on dad existing, but is used to stop rta timer, so wrap it to do nothing
ModUtil.WrapBaseFunction( "HadesKillPresentation", function(baseFunc, unit, args)
end, NoEnemies)
