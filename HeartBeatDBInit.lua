local function InitializeDB(db, isCharDB)
    if db.threshold == nil then 
        db.threshold = HeartBeatConstants.Defaults.THRESHOLD  -- Default to 40%
    end
    if db.beatMode == nil then 
        db.beatMode = HeartBeatConstants.Defaults.BEAT_MODE    -- Default to "Normal"
    end
    if isCharDB and db.useCharSettings == nil then 
        db.useCharSettings = false 
    end
end

HeartBeatDB = HeartBeatDB or {}
HeartBeatCharDB = HeartBeatCharDB or {}
InitializeDB(HeartBeatDB, false)
InitializeDB(HeartBeatCharDB, true)