-- // ## DRUG SALE ## // --
ESX = nil
Config = {}
Config.cops = 1
local CopsConnected  = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()
	local xPlayers = ESX.GetPlayers()
	EmsConnected = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end
	SetTimeout(120 * 1000, CountCops)
end

CountCops()

ESX.RegisterServerCallback('bobs_weed:cops', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(CopsConnected)
end)

RegisterServerEvent("esx_Drugs:sellDrugs")
AddEventHandler("esx_Drugs:sellDrugs", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local weed = xPlayer.getInventoryItem('weed').count
	local coke = xPlayer.getInventoryItem('coke').count
	local meth = xPlayer.getInventoryItem('meth').count
	local drugamount = 0
	local price = 0
	local drugType = nil
	
	if weed > 0 then
		drugType = 'weed'
		if weed == 1 then
			drugamount = 1
		elseif weed == 2 then
			drugamount = math.random(1,2)
		elseif weed == 3 then	
			drugamount = math.random(1,3)
		elseif weed >= 4 then	
			drugamount = math.random(1,4)
		end
		
	elseif coke > 0 then
		drugType = 'coke'
		if coke == 1 then
			drugamount = 1
		elseif coke == 2 then
			drugamount = math.random(1,2)
		elseif coke >= 3 then	
			drugamount = math.random(1,3)
		end

	elseif meth > 0 then
		drugType = 'meth'
		if meth == 1 then
			drugamount = 1
		elseif meth == 2 then
			drugamount = math.random(1,2)
		elseif meth >= 3 then	
			drugamount = math.random(1,3)
		end	
	
	else
		TriggerClientEvent('esx:showNotification', _source, "You have ~r~no more~r~ ~y~drugs~s~ on you")
		return
	end
	
	if drugType=='weed' then
		price = math.random(100,120) * 2 * drugamount		
	elseif drugType=='coke' then
		price = math.random(140,160) * 2 * drugamount
	elseif drugType=='meth' then
		price = math.random(120,140) * 2 * drugamount
	end
	
	if drugType ~= nil then
		xPlayer.removeInventoryItem(drugType, drugamount)
	end
	--xPlayer.addAccountMoney('black_money', price)
	 xPlayer.addMoney(price)
	if drugType=='weed' then
	TriggerClientEvent('esx:showNotification', _source, "You sold ~b~"..drugamount.."x~s~ ~y~Weed~s~ for ~r~$" .. price)
	elseif drugType=='coke' then
	TriggerClientEvent('esx:showNotification', _source, "You sold ~b~"..drugamount.."x~s~ ~y~Cocaine~s~ for ~r~$" .. price)
	elseif drugType=='meth' then
	TriggerClientEvent('esx:showNotification', _source, "You sold ~b~"..drugamount.."x~s~ ~y~Meth~s~ for ~r~$" .. price)
	end
	
end)

RegisterServerEvent('bobs_weed:reject')
AddEventHandler('bobs_weed:reject', function(suspect)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('bobs_weed:callCops', xPlayers[i], suspect)
		end
	end
end)

