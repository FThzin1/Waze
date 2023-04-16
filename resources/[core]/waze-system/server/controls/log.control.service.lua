-----------------------------------------------------------------------------------------------------------------------------------------
-- LOGLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local logList = {
    --[[
        Bem-vindo amigo ao pesadelo dessa base, criar todas as logs.
        Nesta base utilizamos um sistema a parte para gerir as logs, assim você não precisa ficar reiniciando a VRP incansávelmente para mexer em besteiras
        Boa sorte >:)
    ]]
    ["logTeste"] = "https://discord.com/api/webhooks/1095111116247543809/J--IIUR4ovlzovWbZC7omK_molmwjssGiXQERdBhOWJbOgPoATyK7UOgMJC5XazN9p-x",
    ["logTeste2"] = "https://discord.com/api/webhooks/sualog"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRACTDISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
local function extractDiscord(src)
    local identifiers = {
        discord = "",
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id,"discord") then
            identifiers.discord = id
        end
    end

    return identifiers
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDLOGS
-----------------------------------------------------------------------------------------------------------------------------------------
function sendLogs(user_id,data)
    local user_id = parseInt(user_id)
    local identity = vRP.getUserIdentity(user_id)

    local infos = extractDiscord(vRP.getUserSource(user_id))
    
    PerformHttpRequest(logList[data.webhook], function(err, text, headers)
    end, "POST", json.encode({
        username = "Waze Evolved",
        avatar_url = "https://cdn.discordapp.com/attachments/1091826684648505396/1095072924756623390/500x500.png",
        embeds = {
            {
                color = 3092790,
                description = "**ID:** "..user_id.."\n**Nome:** "..identity.name.." ".. identity.firstname.."\n**Discord:** <@"..infos.discord:gsub("discord:", "")..">\n\n```"..data.text.."\n```**"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."**",
            }
        }
    }), { ["Content-Type"] = "application/json" })
end

function sendRegister(data)
        
    PerformHttpRequest(logList[data.webhook], function(err, text, headers)
    end, "POST", json.encode({
        username = "Waze Evolved",
        avatar_url = "https://cdn.discordapp.com/attachments/1091826684648505396/1095072924756623390/500x500.png",
        embeds = {
            {
                color = 3092790,
                description = "\n```"..data.text.."\n```**"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."**",
            }
        }
    }), { ["Content-Type"] = "application/json" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("sendLogs",sendLogs)
exports("sendRegister",sendRegister)