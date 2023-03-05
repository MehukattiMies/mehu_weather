--Save weather into json file
RegisterNetEvent('server:saveWeather')
AddEventHandler('server:saveWeather', function(weather_name)
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "/data/weather.json")
    SaveResourceFile(GetCurrentResourceName(), "/data/weather.json", json.encode({weather = weather_name}), -1)
end)


--Load data from json file
function LoadData()
    local loaded_data = LoadResourceFile(GetCurrentResourceName(), "/data/weather.json")
    local file_data = json.decode(loaded_data or '{}')
    
    return file_data
end


--Get weather from json file and trigger it on client side
RegisterNetEvent('server:setWeather')
AddEventHandler('server:setWeather', function()
    local data = LoadData()
    TriggerClientEvent('client:setWeather', -1, data)
end)


RegisterNetEvent('server:setWeatherCommand')
AddEventHandler('server:setWeatherCommand', function(weather_name)
    if IsPlayerAceAllowed(source, "weather") then
        TriggerEvent('server:saveWeather', weather_name)
        TriggerEvent('server:setWeather', source)
    else
        TriggerClientEvent('client:missingPerms', source)
    end
end)
