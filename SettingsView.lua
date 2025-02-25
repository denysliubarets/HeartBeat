local panel = CreateFrame(
    "Frame",
    "HeartBeatOptionsPanel",
    UIParent,
    BackdropTemplateMixin and "BackdropTemplate" or nil
)
panel:SetSize(300, 320)  -- Adjusted height unchanged
panel:SetPoint("CENTER")

if panel.SetBackdrop then
    panel:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    panel:SetBackdropColor(0, 0, 0, 1)
end
panel:Hide()

-- Title
local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title:SetPoint("TOP", 0, -20)
title:SetText("HeartBeat Settings")

-- Slider (Only HeartBeat Threshold)
local thresholdSlider = HeartBeat_CreateSlider("HeartBeatThresholdSlider", panel, "HP", -90)

-- Radio Buttons
local loudRadio = CreateFrame("CheckButton", "HeartBeatLoudRadio", panel, "UIRadioButtonTemplate")
loudRadio:SetPoint("TOPLEFT", thresholdSlider, "BOTTOMLEFT", 0, -40)
_G[loudRadio:GetName().."Text"]:SetText("Loud beats")
_G[loudRadio:GetName().."Text"]:SetTextColor(1, 1, 1, 1)

local normalRadio = CreateFrame("CheckButton", "HeartBeatNormalRadio", panel, "UIRadioButtonTemplate")
normalRadio:SetPoint("TOPLEFT", loudRadio, "BOTTOMLEFT", 0, -10)
_G[normalRadio:GetName().."Text"]:SetText("Normal beats")
_G[normalRadio:GetName().."Text"]:SetTextColor(1, 1, 1, 1)

local quietRadio = CreateFrame("CheckButton", "HeartBeatQuietRadio", panel, "UIRadioButtonTemplate")
quietRadio:SetPoint("TOPLEFT", normalRadio, "BOTTOMLEFT", 0, -10)
_G[quietRadio:GetName().."Text"]:SetText("Quiet beats")
_G[quietRadio:GetName().."Text"]:SetTextColor(1, 1, 1, 1)

-- Checkbox
local charCheck = CreateFrame("CheckButton", "HeartBeatCharCheck", panel, "InterfaceOptionsCheckButtonTemplate")
charCheck:SetPoint("TOPLEFT", quietRadio, "BOTTOMLEFT", -4, -30)
charCheck.Text:SetText("Use character-specific settings")
charCheck.Text:SetTextColor(1, 1, 1, 1)
charCheck.Text:ClearAllPoints()
charCheck.Text:SetPoint("LEFT", charCheck, "RIGHT", 5, 0)

-- Buttons
local saveButton = CreateFrame("Button", "HeartBeatSaveButton", panel, "UIPanelButtonTemplate")
saveButton:SetPoint("BOTTOMLEFT", 20, 10)
saveButton:SetSize(80, 25)
saveButton:SetText("Save")

local cancelButton = CreateFrame("Button", "HeartBeatCancelButton", panel, "UIPanelButtonTemplate")
cancelButton:SetPoint("BOTTOMRIGHT", -20, 10)
cancelButton:SetSize(80, 25)
cancelButton:SetText("Cancel")

-- Expose UI elements
HeartBeatSettingsView = {
    panel = panel,
    thresholdSlider = thresholdSlider,  -- Renamed from panicSlider
    loudRadio = loudRadio,
    normalRadio = normalRadio,
    quietRadio = quietRadio,
    charCheck = charCheck,
    saveButton = saveButton,
    cancelButton = cancelButton
}