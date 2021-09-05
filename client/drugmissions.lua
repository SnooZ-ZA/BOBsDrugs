ESX = nil

local PlayerData = nil
local StopMission = false
local cokemission =  {x = -109.75, y = -11.05, z = 70.52}
local methmission =  {x = 244.99, y = 370.44, z = 105.74}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false) 
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, cokemission.x, cokemission.y, cokemission.z)

			if dist <= 25.0  then				
			DrawMarker(25, cokemission.x, cokemission.y, cokemission.z-0.90, 0, 0, 0, 0, 0, 0, 1.301, 1.3001, 1.3001, 0, 205, 250, 200, 0, 0, 0, 0)
			else
			Citizen.Wait(1500)
			end

            if dist <= 1.0 then
				DrawText3D(cokemission.x, cokemission.y, cokemission.z, "Press [~g~E~s~] to order ~b~Cocaine Shipment~s~")
					if IsControlJustReleased(0, 38) then
					ESX.TriggerServerCallback('Scully:CanStartRobbery', function(CanRob)
						if CanRob then
							ShowAdvancedNotification('CHAR_MP_DETONATEPHONE', '~y~SATLINK~s~', '~b~STATUS~s~', '~g~ONLINE!~s~ Connecting...')
							exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 10000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "CONTACTING SUPPLIERS",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "WORLD_HUMAN_STAND_MOBILE", -- https://pastebin.com/6mrYTdQv
								--animationDictionary = "missheistfbisetup1", -- https://alexguirre.github.io/animations-list/
								--animationName = "unlock_loop_janitor",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
							Citizen.Wait(10000)
							ESX.ShowNotification("Wait for location of ~b~Drug Shipment~s~!")
							TriggerServerEvent("Scully:StartTimer", 20)
							ClearPedTasks(PlayerPedId())
							local waitdrop = math.random(15000, 30000)
							Citizen.Wait(waitdrop)
							TriggerEvent("bobs_drugs:startTheEvent", 'coke')
							ESX.ShowNotification("Go to the ~y~Location~s~ on your GPS to collect ~b~Drugs Shipment~s~")
							Citizen.Wait(500)
						else
							ShowAdvancedNotification('CHAR_MP_DETONATEPHONE', '~y~SATLINK~s~', '~b~STATUS~s~', '~r~OFFLINE!~s~ Try again Later')	
						end
					end)
				end
					
		end
	end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false) 
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, methmission.x, methmission.y, methmission.z)

			if dist <= 25.0  then
				
			DrawMarker(25, methmission.x, methmission.y, methmission.z-0.90, 0, 0, 0, 0, 0, 0, 1.301, 1.3001, 1.3001, 0, 205, 250, 200, 0, 0, 0, 0)
			else
			Citizen.Wait(1500)
			end

            if dist <= 1.0 then
				DrawText3D(methmission.x, methmission.y, methmission.z, "Press [~g~E~s~] to order ~b~Meth Shipment~s~")
					if IsControlJustReleased(0, 38) then
						ESX.TriggerServerCallback('Scully:CanStartRobbery', function(CanRob)
						if CanRob then
							ShowAdvancedNotification('CHAR_MP_DETONATEPHONE', '~y~SATLINK~s~', '~b~STATUS~s~', '~g~ONLINE!~s~ Connecting...')
							exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 10000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "CONTACTING SUPPLIERS",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "WORLD_HUMAN_STAND_MOBILE", -- https://pastebin.com/6mrYTdQv
								--animationDictionary = "missheistfbisetup1", -- https://alexguirre.github.io/animations-list/
								--animationName = "unlock_loop_janitor",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
							Citizen.Wait(10000)
							ESX.ShowNotification("Wait for location of ~b~Drug Shipment~s~!")
							TriggerServerEvent("Scully:StartTimer", 20)
							ClearPedTasks(PlayerPedId())
							local waitdrop = math.random(15000, 30000)
							Citizen.Wait(waitdrop)
							TriggerEvent("bobs_drugs:startTheEvent", 'meth')	
							ESX.ShowNotification("Go to the ~y~Location~s~ on your GPS to collect ~b~Drugs Shipment~s~")
							Citizen.Wait(500)
						else
							ShowAdvancedNotification('CHAR_MP_DETONATEPHONE', '~y~SATLINK~s~', '~b~STATUS~s~', '~r~OFFLINE!~s~ Try again Later')
						end
					end)
				end
					
		end
	end
end)

RegisterNetEvent("bobs_drugs:startTheEvent")
AddEventHandler("bobs_drugs:startTheEvent",function(drug)
	RequestModel(-459818001)
	while not HasModelLoaded(-459818001) do
		Citizen.Wait(100)
	end
	local num = math.random(1,#Config.MissionPosition)
	local loc = Config.MissionPosition[num]
	local typed = drug
	local playerped = GetPlayerPed(-1)
	local taken = false
	local blip = CreateMissionBlip(loc.Location)
	while not taken and not StopMission do
		Citizen.Wait(10)
		
		if GetDistanceBetweenCoords(loc.Location, GetEntityCoords(GetPlayerPed(-1))) < 2.5 then
			ESX.Game.Utils.DrawText3D(loc.Location,"Press [~g~E~s~] to take the ~b~bobs_drugs~s~",.5,0)
			if IsControlJustReleased(1,38) then
					exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 10000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "COLLECTING DRUGS",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
								--animationDictionary = "missheistfbisetup1", -- https://alexguirre.github.io/animations-list/
								--animationName = "unlock_loop_janitor",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
					Citizen.Wait(10000)
					--ClearPedTasks(PlayerPedId())
					if GetDistanceBetweenCoords(loc.Location, GetEntityCoords(GetPlayerPed(-1))) < 2.5 then
					ESX.ShowNotification("~g~Completed:~s~ You collected the drugs!")
							if typed == "coke" then
								TriggerServerEvent("bobs_drugs:cokereward")
							elseif typed == "meth" then
								TriggerServerEvent("bobs_drugs:methreward")
							end
					RequestAnimDict("anim@heists@box_carry@")
					while not HasAnimDictLoaded("anim@heists@box_carry@") do
					Citizen.Wait(1)
					end
					TaskPlayAnim(GetPlayerPed(-1),"anim@heists@box_carry@","idle",1.0, -1.0, -1, 49, 0, 0, 0, 0)
					Citizen.Wait(300)
						attachModel = GetHashKey('prop_mp_drug_package')
						boneNumber = 28422
						SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263) 
						local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumber)
						RequestModel(attachModel)
							while not HasModelLoaded(attachModel) do
								Citizen.Wait(100)
							end
							attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
							AttachEntityToEntity(attachedProp, GetPlayerPed(-1), bone, 0.0, 0.0, 0.0, 135.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
				
					RemoveBlip(blip)
					Config.MissionPosition[num].InUse = false
					TriggerServerEvent("bobs_drugs:syncMissionData",Config.MissionPosition)
					taken = true
					Citizen.Wait(5000)
					ClearPedTasks(PlayerPedId())
					RemoveAnimDict("anim@heists@box_carry@")
					DeleteEntity(attachedProp)
					break
					end
			end
		end
		
		if StopMission == true then
			ESX.ShowNotification("~r~Mission Failed:~s~ You died")
			Config.MissionPosition[num].InUse = false
		end
		
	end
	RemoveBlip(blip)
end)

function CreateMissionBlip(location)
	local blip = AddBlipForCoord(location.x,location.y,location.z)
	SetBlipSprite(blip, 1)
	SetBlipColour(blip, 5)
	AddTextEntry('MYBLIP', "Drug Mission")
	BeginTextCommandSetBlipName('MYBLIP')
	AddTextComponentSubstringPlayerName(name)
	EndTextCommandSetBlipName(blip)
	SetBlipScale(blip, 0.9) -- set scale
	SetBlipAsShortRange(blip, true)
	SetNewWaypoint(location.x,location.y)
	return blip
end

AddEventHandler('esx:onPlayerDeath', function(data)
	CancelEvent("bobs_drugs:startMission")
	StopMission = true
	RemoveBlip(blip)
end)

function ShowAdvancedNotification(icon, sender, title, text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, 4, sender, title, text)
    DrawNotification(false, true)
end