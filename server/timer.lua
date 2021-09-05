ESX = nil
local cooldown = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Config = {}

Config.Timer = {
    cooldown = 30, -- How long should the default timer be in minutes?
	alertmessage = "~r~Come back ~y~Later ~r~!!", -- Message when someone tries to rob something while the cooldown is in effect.
}

ESX.RegisterServerCallback('Scully:CanStartRobbery', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer and not cooldown then
	cb(true)
    else
	--TriggerClientEvent('esx:showNotification', _source, Config.Timer.alertmessage)
	cb(false)
    end
end)

RegisterServerEvent("Scully:StartTimer")
AddEventHandler("Scully:StartTimer", function(cooldowntime)
    local cooldowntimer = Config.Timer.cooldown
    if cooldowntime ~= nil and cooldowntime > 0 then 
	cooldowntimer = cooldowntime 
    end
    cooldown = true
    SetTimeout((cooldowntimer*60000), function()
	cooldown = false
    end)
end)

RegisterServerEvent("Scully:ResetTimer")
AddEventHandler("Scully:ResetTimer", function()
    cooldown = false
end)