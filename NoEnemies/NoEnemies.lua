ModUtil.RegisterMod("NoEnemies")

ModUtil.WrapBaseFunction( "CreateRoom", function(baseFunc, roomData, args)
	--shop instead of empty so that cerberus functions (also fixed weird pot bug? no idea what that was)
	ForceNextEncounter = "Shop" 
	--remove barge softlock
	Destroy({ Ids = GetIds({ Name = "WaterEndingObjectsDestroy" }) })
	return baseFunc(roomData, args)
end, NoEnemies)

ModUtil.WrapBaseFunction( "ChooseRoomReward", function(baseFunc, roomData, args)
	return nil
end, NoEnemies)

ModUtil.WrapBaseFunction( "BossIntro", function(baseFunc, eventSource, args)
	--fix camera after boss fights, end of intro function usually does this
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = args.DurationOut or 1.25, EaseIn = 0.04, EaseOut = 0.275 }) 
end, NoEnemies)
