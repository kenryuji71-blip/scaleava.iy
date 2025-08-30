-- scaleava.lua
-- Plugin Infinite Yield: Scale Avatar
-- Buat command ;scaleava dan ;scaleavareset

local Players = game:GetService("Players")

-- Pastikan Infinite Yield sudah ada
if InfiniteYield then
    -- Command untuk scaling avatar
    InfiniteYield.AddCommand("scaleava", function(args, speaker)
        local target = args[1]
        local scale = tonumber(args[2]) or tonumber(args[1])

        local function applyScale(plr, num)
            local char = plr.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum:FindFirstChild("BodyHeightScale") then
                    hum.BodyHeightScale.Value = num
                    hum.BodyWidthScale.Value = num
                    hum.BodyDepthScale.Value = num
                    hum.HeadScale.Value = num
                end
            end
        end

        if not scale then
            speaker:SendNotification("ScaleAva", "Gunakan: ;scaleava <angka> | ;scaleava <player> <angka> | ;scaleava all <angka>", 5)
            return
        end

        if target and not tonumber(target) then
            if target:lower() == "all" then
                for _, plr in pairs(Players:GetPlayers()) do
                    applyScale(plr, scale)
                end
            else
                local plr = Players:FindFirstChild(target)
                if plr then applyScale(plr, scale) end
            end
        else
            applyScale(speaker, scale)
        end
    end)

    -- Command untuk reset scale
    InfiniteYield.AddCommand("scaleavareset", function(args, speaker)
        local target = args[1]

        local function reset(plr)
            local char = plr.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum:FindFirstChild("BodyHeightScale") then
                    hum.BodyHeightScale.Value = 1
                    hum.BodyWidthScale.Value = 1
                    hum.BodyDepthScale.Value = 1
                    hum.HeadScale.Value = 1
                end
            end
        end

        if target then
            if target:lower() == "all" then
                for _, plr in pairs(Players:GetPlayers()) do
                    reset(plr)
                end
            else
                local plr = Players:FindFirstChild(target)
                if plr then reset(plr) end
            end
        else
            reset(speaker)
        end
    end)

    print("✅ ScaleAva Plugin Loaded!")
else
    warn("⚠️ Infinite Yield not detected. Pastikan plugin dimuat dari folder plugins.")
end
