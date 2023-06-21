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
        ESX.ShowNotification(_U('no_vehicle_found'))
    end
end)


RegisterKeyMapping('lockvehicle', _U('lock_vehicle'), 'keyboard', 'f10')