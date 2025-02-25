local frame = CreateFrame("Frame")
local lastUpdate = 0
local interval = nil
local currentInterval = nil
local currentPerc = 100 -- Cached health percentage, default to 100%

-- OnUpdate handler as a separate function for enabling/disabling
local function OnUpdateHandler(self, elapsed)
    if not interval or UnitIsDead("player") or UnitIsGhost("player") then
        lastUpdate = 0
        return
    end
    lastUpdate = lastUpdate + elapsed
    if lastUpdate >= math.max(interval, 0.1) then
        PlayHeartBeat() -- Убедились, что PlayHeartBeat глобальная
        lastUpdate = 0
    end
end

-- Updates the heartbeat interval based on player's cached health percentage
local function UpdateInterval()
    local db = HeartBeat_GetActiveDB()
    if currentPerc == nil then return end -- Safety check if health data is unavailable

    local threshold = db.threshold or HeartBeatConstants.Defaults.THRESHOLD
    local panicEnd = threshold * HeartBeatConstants.ThresholdFactors.PANIC    -- e.g., 16% if threshold = 40
    local intenseEnd = threshold * HeartBeatConstants.ThresholdFactors.INTENSE -- e.g., 32% if threshold = 40

    local newInterval
    if currentPerc < panicEnd then
        newInterval = HeartBeatConstants.Intervals.PANIC  -- 0.5s
    elseif currentPerc < intenseEnd then
        newInterval = HeartBeatConstants.Intervals.INTENSE  -- 1.0s
    elseif currentPerc < threshold then
        newInterval = HeartBeatConstants.Intervals.CALM  -- 1.4s
    else
        newInterval = nil
    end

    if newInterval ~= currentInterval then
        currentInterval = newInterval
        interval = newInterval
        if currentInterval then
            lastUpdate = math.min(lastUpdate, currentInterval) -- Adjust timing smoothly
            frame:SetScript("OnUpdate", OnUpdateHandler)        -- Enable OnUpdate when heartbeat is active
        else
            lastUpdate = 0
            frame:SetScript("OnUpdate", nil)                    -- Disable OnUpdate when no heartbeat
        end
    end
end

-- Plays the heartbeat sound based on the current health and interval
function PlayHeartBeat()
    local db = HeartBeat_GetActiveDB()
    local threshold = db.threshold or HeartBeatConstants.Defaults.THRESHOLD
    local panicEnd = threshold * HeartBeatConstants.ThresholdFactors.PANIC
    local intenseEnd = threshold * HeartBeatConstants.ThresholdFactors.INTENSE
    local intenseMid = panicEnd + (intenseEnd - panicEnd) * 0.5  -- Midpoint of intense zone (e.g., 24% if threshold = 40)

    local isPanic
    if interval == HeartBeatConstants.Intervals.PANIC then
        isPanic = true -- Full panic sound below panicEnd
    elseif interval == HeartBeatConstants.Intervals.INTENSE then
        isPanic = (currentPerc < intenseMid) -- Panic sound for first 50% of intense zone
    else -- CALM or no interval
        isPanic = false -- Normal sound for calm or above threshold
    end

    HeartBeat_PlaySound(isPanic, db.beatMode)
end

-- Event handler to update health percentage and interval
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("UNIT_HEALTH")
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "UNIT_HEALTH" and arg1 == "player" then
        local health = UnitHealth("player")
        local maxHealth = UnitHealthMax("player")
        if maxHealth == 0 then
            currentPerc = nil -- Reset if max health is invalid
        else
            currentPerc = (health / maxHealth) * 100 -- Update cached percentage
        end
        UpdateInterval()
    elseif event == "PLAYER_ENTERING_WORLD" then
        local health = UnitHealth("player")
        local maxHealth = UnitHealthMax("player")
        if maxHealth == 0 then
            currentPerc = nil
        else
            currentPerc = (health / maxHealth) * 100
        end
        UpdateInterval()
    end
end)