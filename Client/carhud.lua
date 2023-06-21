Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)
		local playerped = GetPlayerPed(-1)
    
        if IsPedInAnyVehicle(playerped, false) then
            Citizen.Wait(20)
            local veh = GetVehiclePedIsIn(playerped)
            if Config.Miles then
                VehicleSpeed = math.ceil(GetEntitySpeed(veh) * 2.236936)
            else
                VehicleSpeed = math.ceil(GetEntitySpeed(veh) * 3.6)
            end
            local VehicleGasoline = math.ceil(GetVehicleFuelLevel(veh))
            SendNUIMessage({
                display = true,
                speed = VehicleSpeed,
                gasoline = VehicleGasoline,
            })
            Citizen.Wait(20)
        else
            SendNUIMessage({
                display = false
            })
        end
    end
end)