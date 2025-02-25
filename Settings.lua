local view = HeartBeatSettingsView

-- Load settings into UI
local function LoadSettings()
    local db = HeartBeat_GetActiveDB()
    view.charCheck:SetChecked(HeartBeatCharDB.useCharSettings)
    
    view.thresholdSlider:SetValue(db.threshold or HeartBeatConstants.Defaults.THRESHOLD)
    _G[view.thresholdSlider:GetName().."Text"]:SetText("HeartBeat Threshold: "..(db.threshold or HeartBeatConstants.Defaults.THRESHOLD).."%")
    
    view.loudRadio:SetChecked(db.beatMode == "Loud")
    view.normalRadio:SetChecked(db.beatMode == "Normal")
    view.quietRadio:SetChecked(db.beatMode == "Quiet")
end

-- Event Handlers
view.panel:SetScript("OnShow", LoadSettings)

view.charCheck:SetScript("OnClick", function(self)
    HeartBeatCharDB.useCharSettings = self:GetChecked()
    LoadSettings()  -- Refresh UI with new DB
end)

view.loudRadio:SetScript("OnClick", function(self)
    view.loudRadio:SetChecked(true)
    view.normalRadio:SetChecked(false)
    view.quietRadio:SetChecked(false)
    HeartBeat_GetActiveDB().beatMode = "Loud"
    HeartBeat_PlaySound(false, "Loud")  -- Preview calm sound
end)

view.normalRadio:SetScript("OnClick", function(self)
    view.loudRadio:SetChecked(false)
    view.normalRadio:SetChecked(true)
    view.quietRadio:SetChecked(false)
    HeartBeat_GetActiveDB().beatMode = "Normal"
    HeartBeat_PlaySound(false, "Normal")
end)

view.quietRadio:SetScript("OnClick", function(self)
    view.loudRadio:SetChecked(false)
    view.normalRadio:SetChecked(false)
    view.quietRadio:SetChecked(true)
    HeartBeat_GetActiveDB().beatMode = "Quiet"
    HeartBeat_PlaySound(false, "Quiet")
end)

view.saveButton:SetScript("OnClick", function()
    local db = HeartBeat_GetActiveDB()
    local thresholdValue = math.floor(view.thresholdSlider:GetValue() + 0.5)

    db.threshold = thresholdValue  -- Store single threshold

    print("HeartBeat: Settings saved.")
    print("Threshold: "..thresholdValue.."%")
    print("Beat mode: "..db.beatMode..
          (HeartBeatCharDB.useCharSettings and " [CHARACTER]" or " [GLOBAL]"))
    view.panel:Hide()
end)

view.cancelButton:SetScript("OnClick", function()
    view.panel:Hide()
end)

-- Slash Command
SLASH_HEARTBEAT1 = "/heartbeat"
SLASH_HEARTBEAT2 = "/hbha"
SlashCmdList["HEARTBEAT"] = function()
    if view.panel:IsShown() then
        view.panel:Hide()
    else
        view.panel:Show()
    end
end

print("HeartBeat loaded. Type /heartbeat or /hbha to open the settings window.")
