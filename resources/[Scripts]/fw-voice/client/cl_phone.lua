PhoneVolume, IsOnPhoneCall, CurrentCall = 0.5, false, nil

RegisterNetEvent("fw-voice:Client:Call:Start")
AddEventHandler("fw-voice:Client:Call:Start", function(ServerId, CallId)
    if not IsOnPhoneCall then
        IsOnPhoneCall = true
        CurrentCall = {CallId = CallId, TargetId = ServerId}
        AddPlayerToTargetList(ServerId, "Phone", true)
        Citizen.CreateThread(function()
            local ExistingTarget = not Targets:TargetHasAnyActiveContext(ServerId)
            local ExistingChannel = not IsPlayerInTargetChannel(ServerId)
            while IsOnPhoneCall do
                local CurrentTarget = not Targets:TargetHasAnyActiveContext(ServerId)
                local CurrentChannel = not IsPlayerInTargetChannel(ServerId)
                if ExistingTarget ~= CurrentTarget or ExistingChannel ~= CurrentChannel then
                    ExistingTarget = CurrentTarget
                    ExistingChannel = CurrentChannel
                    RefreshTargets()
                end
                Citizen.Wait(1000)
            end
        end)
        if Config.Debug then print(('[Phone] Call Started | Call ID %s | Player %s'):format(CallId, ServerId)) end
    end
end)

RegisterNetEvent("fw-voice:Client:Call:Stop")
AddEventHandler("fw-voice:Client:Call:Stop", function(ServerId, CallId)
    if IsOnPhoneCall or CurrentCall ~= nil and CurrentCall.CallId == CallId then
        IsOnPhoneCall, CurrentCall = false, nil
        RemovePlayerFromTargetList(ServerId, "Phone", true, true)
        if Config.Debug then print(('[Phone] Call Ended | Call ID %s | Player %s'):format(CallId, ServerId)) end
    end
end)

-- // Functions \\ --

function SetPhoneVolume(Volume)
    Volume = Volume * 1.0
    if Volume >= 0 and Volume <= 1.0 then
        PhoneVolume = Volume
        UpdateContextVolume("Phone", PhoneVolume)
        SetSubmixBalanceVolume('PhoneSubmix', PhoneVolume)
        if Config.Debug then print(('[Phone] Volume Changed | Current: %s'):format(PhoneVolume)) end
    end
end

function LoadPhone()
    RegisterModuleContext("Phone", 1)
    UpdateContextVolume("Phone", PhoneVolume)
    SetSubmixBalanceVolume('PhoneSubmix', PhoneVolume)
    if Config.Debug then print('[Phone] Module Loaded') end
end