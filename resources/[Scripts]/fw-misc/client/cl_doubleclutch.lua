local InVehicle = false
local IsDriver = false

function StartClutchLoop(Vehicle)
    local Active = 0

    Citizen.CreateThread(function()
        while InVehicle do
            if IsDriver then
                local RearAir = (GetVehicleWheelSuspensionCompression(Vehicle, 0) < 0.07 or GetVehicleWheelSuspensionCompression(Vehicle, 1) < 0.07) or (GetVehicleWheelSuspensionCompression(Vehicle, 2) < 0.07 or GetVehicleWheelSuspensionCompression(Vehicle, 3) < 0.07)
                if RearAir then
                    local CarSpeed = GetEntitySpeed(Vehicle)
                    if CarSpeed > 30.0 then
                        Active = 15
                        SetVehicleMaxSpeed(Vehicle, CarSpeed)
                    end
                end
                Citizen.Wait(20)
                if Active > 1 then
                    Active = Active - 1
                else
                    if Active == 1 then
                        Active = Active - 1
                        SetVehicleMaxSpeed(Vehicle, 0.0)
                    end
                    Citizen.Wait(150)
                end
            else
                Citizen.Wait(1000)
            end
        end
    end)
end

RegisterNetEvent("baseevents:enteredVehicle")
AddEventHandler("baseevents:enteredVehicle", function(Vehicle, Seat, DisplayName, NetId)
    InVehicle = true


    if not IsThisModelACar(GetEntityModel(Vehicle)) then
        return
    end

    PlayerVehicle = Vehicle
    IsDriver = Seat == -1

    StartClutchLoop(Vehicle)

    Citizen.CreateThread(function()
        while InVehicle do

            if not IsDriver then
                IsDriver = GetPedInVehicleSeat(Vehicle, -1) == PlayerPedId()
                Citizen.Wait(IsDriver and 100 or 500)
            else
                if GetVehicleCurrentGear(Vehicle) < 3 and GetVehicleCurrentRpm(Vehicle) == 1.0 and math.ceil(GetEntitySpeed(Vehicle) * 2.236936) > 50 then
                    local MaxGears = GetVehicleHandlingInt(Vehicle, "CHandlingData", "nInitialDriveGears")
                
                    while GetVehicleCurrentRpm(Vehicle) > 0.6 and MaxGears > 3 do
                        SetVehicleCurrentRpm(Vehicle, 0.3)
                        Citizen.Wait(1)
                    end
                
                    Citizen.Wait(800)
                end
            end

            Citizen.Wait(500)
        end
    end)
end)

RegisterNetEvent("baseevents:leftVehicle")
AddEventHandler("baseevents:leftVehicle", function(Vehicle, Seat, DisplayName, NetId)
    InVehicle = false
end)