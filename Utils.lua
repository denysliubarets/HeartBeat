HeartBeat_GetActiveDB = function()
    return HeartBeatCharDB.useCharSettings and HeartBeatCharDB or HeartBeatDB
end

HeartBeat_PlaySound = function(isPanic, beatMode)
    local SoundMap = {
        Panic = {
            Loud  = HeartBeatConstants.SoundFiles.PANIC_LOUD,
            Quiet = HeartBeatConstants.SoundFiles.PANIC_QUIET,
            Normal = HeartBeatConstants.SoundFiles.PANIC_NORMAL
        },
        Normal = {
            Loud  = HeartBeatConstants.SoundFiles.LOUD,
            Quiet = HeartBeatConstants.SoundFiles.QUIET,
            Normal = HeartBeatConstants.SoundFiles.NORMAL
        }
    }
    local state = isPanic and "Panic" or "Normal"
    PlaySoundFile(SoundMap[state][beatMode], "Master")
end

HeartBeat_CreateSlider = function(name, parent, label, yOffset)
    local slider = CreateFrame("Slider", name, parent, "OptionsSliderTemplate")
    slider:SetPoint("TOPLEFT", 40, yOffset)
    slider:SetWidth(220)
    slider:SetMinMaxValues(0, 100)
    slider:SetValueStep(5)
    slider:SetObeyStepOnDrag(true)
    _G[slider:GetName().."Low"]:SetText("0%")
    _G[slider:GetName().."High"]:SetText("100%")
    _G[slider:GetName().."Text"]:SetText(label..": 0%")
    slider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value + 0.5)
        _G[self:GetName().."Text"]:SetText(label..": "..value.."%")
    end)
    return slider
end