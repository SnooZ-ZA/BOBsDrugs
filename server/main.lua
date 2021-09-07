ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('esx_weed:getItem')
AddEventHandler('esx_weed:getItem', function()
local player = ESX.GetPlayerFromId(source)
local randomWeed = math.random(2, 5)
   player.addInventoryItem('weed', randomWeed)
end)

RegisterServerEvent('bobs_weed:harvest')
AddEventHandler('bobs_weed:harvest', function(suspect)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('bobs_weed_harvest:callCops', xPlayers[i], suspect)
		end
	end
end)

-- // ## DRUGS MISSION REWARDS ## // --
RegisterServerEvent("bobs_drugs:cokereward")
AddEventHandler("bobs_drugs:cokereward",function()
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem('coke', math.random(40,70))
	TriggerEvent("Scully:ResetTimer")
end)

RegisterServerEvent("bobs_drugs:methreward")
AddEventHandler("bobs_drugs:methreward",function()
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem('meth', math.random(30,50))
	TriggerEvent("Scully:ResetTimer")
end)

-- // ## DRUGS EFFECT ## // --
ESX.RegisterUsableItem('weed', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)	
	xPlayer.removeInventoryItem("weed",1)
	TriggerClientEvent("bobs_drugs:activate_weed",source)
end)

ESX.RegisterUsableItem('coke', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('coke', 1)
	TriggerClientEvent('coke:onUse', source)
end)

ESX.RegisterUsableItem('meth', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('meth', 1)
	TriggerClientEvent('meth:onUse', source)
end)