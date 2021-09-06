ESX        = nil
percent    = false
searching  = false
cachedWeed = {}

local _source    = source
local oPlayer = false
local InVehicle = false
local playerpos = false

Citizen.CreateThread(function()
    while(true) do
		oPlayer = PlayerPedId()
        InVehicle = IsPedInAnyVehicle(oPlayer, true)
		playerpos = GetEntityCoords(oPlayer)
        Citizen.Wait(500)
    end
end)

closestWeed = {
	"prop_weed_01",
	--"prop_weed_02",
	"bkr_prop_weed_lrg_01b",
	"bkr_prop_weed_med_01b"
}

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(5)

		TriggerEvent("esx:getSharedObject", function(library)
			ESX = library
		end)
    end

    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response
end)

Citizen.CreateThread(function()
    Citizen.Wait(100)
    while true do
        
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for i = 1, #closestWeed do
            local x = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(closestWeed[i]), false, false, false)
            local entity = nil
            if DoesEntityExist(x) then
                sleep  = 5
                entity = x
                weed   = GetEntityCoords(entity)
				drawText3D(weed.x, weed.y, weed.z + 1.5, '⚙️')				
                while IsControlPressed(0, 38) do
                drawText3D(weed.x, weed.y, weed.z + 1.5, 'Press [~g~H~s~] to harvest ~b~ WEED ~s~')
				break
				end
                if IsControlJustReleased(0, 74) then
                    if not cachedWeed[entity] then
					chance2 = math.random(1,10)
							if chance2 == 5 then
								ESX.ShowNotification("Someone spotted you and called the ~r~cops~s~ with ~r~your description~s~")
								Citizen.Wait(2000)
								local suspect = PlayerId(-1)	
								TriggerServerEvent('bobs_weed:harvest', suspect)
							else
								SetEntityHeading(oPlayer,GetHeadingFromVector_2d(weed.x-playerpos.x,weed.y-playerpos.y))
								searching = true
								exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 11000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "HARVESTING",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "CODE_HUMAN_MEDIC_KNEEL", -- https://pastebin.com/6mrYTdQv
								--animationDictionary = "missheistfbisetup1", -- https://alexguirre.github.io/animations-list/
								--animationName = "unlock_loop_janitor",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
								Citizen.Wait(11000)
								cachedWeed[entity] = true
								TriggerServerEvent('esx_weed:getItem')
								ClearPedTasks(PlayerPedId())
								searching = false															
							end										
					else
                        ESX.ShowNotification('You have already harvested here!')
                    end
                end
                break
            else
                sleep = 1000
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(100)
    while true do

        local sleep = 1000

        if percent then

            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for i = 1, #closestWeed do

                local x = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(closestWeed[i]), false, false, false)
                local entity = nil
                
                if DoesEntityExist(x) then
                    sleep  = 5
                    entity = x
                    weed   = GetEntityCoords(entity)
                    drawText3D(weed.x, weed.y, weed.z + 1.5, TimeLeft .. '~g~%~s~')
                    break
                end
            end
        end
        Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if searching then
            DisableControlAction(0, 38) 
			DisableControlAction(0, 47)
        end
    end
end)

RegisterNetEvent("bobs_drugs:activate_weed")
AddEventHandler("bobs_drugs:activate_weed",function()
    local ped = PlayerPedId()
	if not IsPedInAnyVehicle(PlayerPedId()) then
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
								Label = "SMOKING JOINT",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "WORLD_HUMAN_SMOKING_POT", -- https://pastebin.com/6mrYTdQv
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
		ClearPedTasks(PlayerPedId())
	else
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
								Label = "SMOKING JOINT",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "WORLD_HUMAN_SMOKING_POT", -- https://pastebin.com/6mrYTdQv
								--animationDictionary = "missheistfbisetup1", -- https://alexguirre.github.io/animations-list/
								--animationName = "unlock_loop_janitor",
								},
								DisableControls = {
								Mouse = false,
								Player = false,
								Vehicle = false
								},
								})
		Citizen.Wait(10000)
	end	
    SetTimecycleModifier("spectator5")
	SetPedMotionBlur(playerPed, true)
    if GetPedArmour(ped) <= 75 then
        AddArmourToPed(ped,25)
    elseif GetPedArmour(ped) <= 99 then
        SetPedArmour(ped,100)
    end
	Citizen.Wait(10000)
    SetTimecycleModifier("default")
	SetPedMotionBlur(playerPed, false)
end)

RegisterNetEvent('coke:onUse')
AddEventHandler('coke:onUse', function(source)
	ESX.ShowNotification("You used ~r~Cocaine~s~")
	local crackhead = PlayerPedId()
	if not IsPedInAnyVehicle(PlayerPedId()) then
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
								Label = "SMOKING CRACK",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "WORLD_HUMAN_SMOKING_POT", -- https://pastebin.com/6mrYTdQv
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
		ClearPedTasks(PlayerPedId())
	else
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
								Label = "SMOKING CRACK",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "WORLD_HUMAN_SMOKING_POT", -- https://pastebin.com/6mrYTdQv
								--animationDictionary = "missheistfbisetup1", -- https://alexguirre.github.io/animations-list/
								--animationName = "unlock_loop_janitor",
								},
								DisableControls = {
								Mouse = false,
								Player = false,
								Vehicle = false
								},
								})
		Citizen.Wait(10000)
	end
	if GetPedArmour(crackhead) <= 75 then
        AddArmourToPed(crackhead,25)
    elseif GetPedArmour(crackhead) <= 99 then
        SetPedArmour(crackhead,100)
    end
	SetTimecycleModifier("DRUG_gas_huffin")
	Citizen.Wait(15000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(2000)
	ESX.ShowNotification("The effects of the coke seem to have worn off")
	ClearTimecycleModifier()
end)

RegisterNetEvent('meth:onUse')
AddEventHandler('meth:onUse', function(source)
	ESX.ShowNotification("You used ~r~Meth~s~")
	local crackhead = PlayerPedId()
	if not IsPedInAnyVehicle(PlayerPedId()) then
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
								Label = "SMOKING SPEED",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "WORLD_HUMAN_SMOKING_POT", -- https://pastebin.com/6mrYTdQv
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
		ClearPedTasks(PlayerPedId())
	else
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
								Label = "SMOKING SPEED",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "WORLD_HUMAN_SMOKING_POT", -- https://pastebin.com/6mrYTdQv
								--animationDictionary = "missheistfbisetup1", -- https://alexguirre.github.io/animations-list/
								--animationName = "unlock_loop_janitor",
								},
								DisableControls = {
								Mouse = false,
								Player = false,
								Vehicle = false
								},
								})
		Citizen.Wait(10000)
	end
	if GetPedArmour(crackhead) <= 75 then
        AddArmourToPed(crackhead,25)
    elseif GetPedArmour(crackhead) <= 99 then
        SetPedArmour(crackhead,100)
    end
	SetTimecycleModifier("DRUG_gas_huffin")
	Citizen.Wait(15000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(2000)
	ESX.ShowNotification("The effects of the meth seem to have worn off")
	ClearTimecycleModifier()
end)


RegisterNetEvent('bobs_weed_harvest:callCops')
AddEventHandler('bobs_weed_harvest:callCops', function(suspect)
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(suspect))
	ESX.ShowAdvancedNotification('Alert', 'Drug Harvesting!', 'We have sent a description of the suspect!', mugshotStr, 4)
    UnregisterPedheadshot(mugshot)
    local suspectLoc = AddBlipForCoord(playerpos.x, playerpos.y, playerpos.z)
    SetBlipSprite(suspectLoc , 161)
    SetBlipScale(suspectLoc , 2.0)
    SetBlipColour(suspectLoc, 2)
    PulseBlip(suspectLoc)
	Wait(20*1000)
    RemoveBlip(suspectLoc)
end)