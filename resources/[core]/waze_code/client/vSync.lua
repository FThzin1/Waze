-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES EXTRASUNNY/CLEAR/NEUTRAL/SMOG/FOGGY/OVERCAST/CLOUDS/CLEARING/RAIN/THUNDER/SNOW/BLIZZARD/SNOWLIGHT/XMAS/HALLOWEEN
-----------------------------------------------------------------------------------------------------------------------------------------
local minutes = 1
local hours = 0
local actualWeather = "CLEAR"
local weathers = {
    "EXTRASUNNY",
    "CLEAR",
    "NEUTRAL",
    "SMOG",
    "FOGGY",
    "OVERCAST",
    "CLOUDS",
    "CLEARING",
    "RAIN",
    "THUNDER",
    "SNOW",
    "BLIZZARD",
    "SNOWLIGHT",
    "XMAS",
    "HALLOWEEN"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC : COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("noite",function(source,args)
    minutes = parseInt(00)
    hours = parseInt(00)
    UpdateTime(actualWeather,hours,munites)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC : COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dia",function(source,args)
    minutes = parseInt(00)
    hours = parseInt(12)
    UpdateTime(actualWeather,hours,munites)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC : COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hora",function(source,args)
    if args[1] and args[2] then
        hours = parseInt(args[1])
        minutes = parseInt(args[2])
        UpdateTime(actualWeather,hours,munites)
    else
        TriggerEvent('Notify', source, 'negado', 'Utilize: /hora horas minutos')
    end
end)
--------------------------------------------------------------------------------------------------------------------------------
-- SYNC : CLIMA
--------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('clima', function(source, args)
    if args[1] then
        local weather = parseInt(args[1])
        if weather > 0 then
            if weathers[weather] then
                actualWeather = weathers[weather]
                UpdateTime(actualWeather,hours,munites)
                TriggerEvent('Notify', 'sucesso', 'Você mudou o clima para <b>'..actualWeather..'</b>.')
            end
        else
            TriggerEvent('Notify', 'negado', 'Você deve especificar um número de <b>1 a ' .. #weathers .. '</b>.')
        end
    else
        TriggerEvent('Notify', 'negado', 'Você deve especificar um número de <b>1 a ' .. #weathers .. '</b>.')
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNC : THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function UpdateTime(actualWeather,hours,munites)
    SetWeatherTypeNow(actualWeather)
    SetWeatherTypePersist(actualWeather)
    SetWeatherTypeNowPersist(actualWeather)
    NetworkOverrideClockTime(hours,minutes,00)
end