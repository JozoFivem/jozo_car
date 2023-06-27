Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(100)
    end
end)

RegisterCommand('lockvehicle', function()

    local vehicle, dist = ESX.Game.GetClosestVehicle()

    if dist < 10 and vehicle > 0 then
        ClearPedTasks(PlayerPedId())
        Wait(100)
        TriggerServerEvent('jozocar:VehicleLock', VehToNet(vehicle), GetVehicleDoorLockStatus(vehicle))
    else
        ESX.ShowNotification = function(message, type)
            exports["jozo_notify"]:TriggerNotification({ ['type'] = car-front, ['message'] = (_U('no_vehicle_found')) })
    end
end)


RegisterKeyMapping('lockvehicle', _U('lock_vehicle'), 'keyboard', 'f10')

function Draw3DText(x, y, z, text)
	SetTextScale(0.22, 0.22)
    SetTextFont(13)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local centralPos = vector3(-25.94, -624.51, 35.5)
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        local dist = #(GetEntityCoords(playerPed) - centralPos)

        if dist < 15.0 then
            Draw3DText(centralPos.x, centralPos.y, centralPos.z, _U('change_locks_for', Config.Price))
            if dist < 2 then
                if IsControlJustPressed(0, 38) then
                    local veh = GetVehiclePedIsIn(playerPed)
                    if DoesEntityExist(veh) then
                        TriggerServerEvent('jozocar:Locks', GetVehicleNumberPlateText(veh))
                        Wait(5000)
                    else
                        ESX.ShowNotification = function(message, type)
                            exports["jozo_notify"]:TriggerNotification({ ['type'] = car-front, ['message'] = (_U('must_in_vehicle'))})
                    end
                end
            end
        else
            Wait(500)
        end
    end
end)

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(centralPos)

    SetBlipSprite (blip, 186)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.9)
    SetBlipColour (blip, 73)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(AddTextComponentString(_U('locksmith')))
    EndTextCommandSetBlipName(blip)

end)

RegisterCommand('givekeys', function()
    local closestP, closestD = ESX.Game.GetClosestPlayer()
    local vehicle, dist = ESX.Game.GetClosestVehicle()
    if DoesEntityExist(vehicle) and closestP ~= -1 and closestD < 4 and dist < 10 then
        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerServerEvent('jozocar:GiveKey', plate, GetPlayerServerId(closestP))
    end
end)
