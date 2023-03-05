--Update weather
RegisterNetEvent('client:setWeather')
AddEventHandler('client:setWeather', function(data)
    weather = dump(data["weather"])
    if weather ~= nil then
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(weather)
        SetWeatherTypeNow(weather)
        SetWeatherTypeNowPersist(weather)
        print("Updated weather to " ..weather)
    else
        print("Weather type instance is missing!")
    end
end)



RegisterNetEvent('client:missingPerms')
AddEventHandler('client:missingPerms', function()
    print("You dont have enough permissions to change weather")
end)


--Set weather command for admins
RegisterCommand('setweather', function(source, args)
    local ped = PlayerPedId()
    if args[1] == nil then
        print("Arguments are missing")
    else
        weather = args[1]
        TriggerServerEvent('server:setWeatherCommand', weather)
    end
end, false)


--Set weather on player spawn
AddEventHandler('playerSpawned', function(source)
    TriggerServerEvent('server:setWeather', source)
    Wait(1000)
    print("Updated weather to " ..weather)
end)


function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end



