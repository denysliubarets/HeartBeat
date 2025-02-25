HeartBeatConstants = {
    Intervals = {
        CALM    = 1.4,
        INTENSE = 1.0,
        PANIC   = 0.5
    },
    Defaults = {
        THRESHOLD = 40,          -- Default single threshold for heartbeat trigger
        BEAT_MODE = "Normal"     -- Default sound mode
    },
    ThresholdFactors = {         -- Factors for splitting threshold into zones
        PANIC   = 0.4,           -- 40% of threshold (e.g., 16% HP if threshold is 40%)
        INTENSE = 0.8            -- 80% of threshold (e.g., 32% HP if threshold is 40%)
    },
    SoundFiles = {
        LOUD         = "Interface/AddOns/HeartBeat/Sounds/HeartbeatLoud.ogg",
        NORMAL       = "Interface/AddOns/HeartBeat/Sounds/HeartbeatNormal.ogg",
        QUIET        = "Interface/AddOns/HeartBeat/Sounds/HeartbeatQuiet.ogg",
        PANIC_LOUD   = "Interface/AddOns/HeartBeat/Sounds/PanicLoud.ogg",
        PANIC_NORMAL = "Interface/AddOns/HeartBeat/Sounds/PanicNormal.ogg",
        PANIC_QUIET  = "Interface/AddOns/HeartBeat/Sounds/PanicQuiet.ogg"
    },
    Icons = {
        MINIMAP      = "Interface/AddOns/HeartBeat/Textures/MinimapIcon.png"
    }
}