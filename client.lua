local weather


--Update weather
RegisterNetEvent('client:setWeather')
AddEventHandler('client:setWeather', function(data)
    weather = dump(data["weather"])
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypePersist(weather)
    SetWeatherTypeNow(weather)
    SetWeatherTypeNowPersist(weather)
end)


--Set weather command for admins
RegisterCommand('setweather', function(source, args)
    if args[1] == nil then
        print("Arguments are missing")
    else
        weather = args[1]
        TriggerServerEvent('server:saveWeather', weather)
        TriggerServerEvent('server:setWeather', source)
        print("Updated weather to " ..weather)
    end
end, false)


--Set weather on player spawn
AddEventHandler('playerSpawned', function(source)
    Wait(500)
    print("Updated weather to " ..weather)
    TriggerServerEvent('server:setWeather', source)
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



