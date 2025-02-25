local ldb  = LibStub("LibDataBroker-1.1", true)
local icon = LibStub("LibDBIcon-1.0", true)

if ldb and icon then
    local dataObject = ldb:NewDataObject("HeartBeat", {
        type = "launcher",
        icon = HeartBeatConstants.Icons.MINIMAP,
        OnClick = function(_, button)
            if HeartBeatOptionsPanel:IsShown() then
                HeartBeatOptionsPanel:Hide()
            else
                HeartBeatOptionsPanel:Show()
            end
        end,
        OnTooltipShow = function(tt)
            if tt and tt.AddLine then
                tt:AddLine("HeartBeat")
                tt:AddLine("Click to open/close settings.", 1, 1, 1)
            end
        end,
    })

    if not HeartBeatDB.minimapIcon then
        HeartBeatDB.minimapIcon = { hide = false }
    end

    icon:Register("HeartBeat", dataObject, HeartBeatDB.minimapIcon)
end