ESX = nil
local CopsConnected  = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

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

local relationshipTypes = {
  "s_m_y_dealer_01",
} 

RequestAnimDict("mp_common")
RequestAnimDict("cellphone@str")
RequestAnimDict("amb@prop_human_parking_meter@male@base")
RequestAnimDict("misscarsteal4@actor")
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local handle, ped = FindFirstPed()
		local success
		repeat
			success, ped = FindNextPed(handle)
			local pos = GetEntityCoords(ped)
			local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerpos.x, playerpos.y, playerpos.z, true)
			if distance < 2 and CanSellToPed(ped) then
				local inventory = ESX.GetPlayerData().inventory
				local count = 0
				for i=1, #inventory, 1 do
				if inventory[i].name == 'weed' or inventory[i].name == 'coke' or inventory[i].name == 'meth' then
				count = inventory[i].count
				if not InVehicle and not IsEntityDead(PlayerPedId()) and count > 0 then
					drawText3D(pos.x, pos.y, pos.z + 1.0, '⚙️')				
					while IsControlPressed(0, 38) do
					drawText3D(pos.x, pos.y, pos.z + 1.0, 'Press [~g~H~s~] to offer ~b~ DRUGS ~s~')
					break
					end
					if IsControlJustPressed(1,74) then
						local chance = math.random(1,2)
						if chance == 1 then
							oldped = ped
								TaskStandStill(ped,50000.0)
								SetEntityAsMissionEntity(ped)
								FreezeEntityPosition(ped,true)
								FreezeEntityPosition(oPlayer,true)
								SetEntityHeading(ped,GetHeadingFromVector_2d(pos.x-playerpos.x,pos.y-playerpos.y)+200)
								SetEntityHeading(oPlayer,GetHeadingFromVector_2d(pos.x-playerpos.x,pos.y-playerpos.y))
									entity = ped
									--TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_DRUG_DEALER_HARD", 0, true)
									--exports['progressBars']:startUI(13000, "NEGOTIATING PRICE")
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
								Label = "NEGOTIATING PRICE",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "WORLD_HUMAN_DRUG_DEALER_HARD", -- https://pastebin.com/6mrYTdQv
								--animationDictionary = "missheistfbisetup1", -- https://alexguirre.github.io/animations-list/
								--animationName = "unlock_loop_janitor",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
									Citizen.Wait(5000)
									TaskPlayAnim(ped, "amb@prop_human_parking_meter@male@base", "base", 8.0, 8.0, 10000, 0, 1, 0,0,0)
									Citizen.Wait(10)
									TaskPlayAnim(oPlayer, "mp_common", "givetake2_a", 8.0, 8.0, 2000, 0, 1, 0,0,0)
									Citizen.Wait(3000)
									TaskPlayAnim(ped, "mp_common", "givetake2_a", 8.0, 8.0, 2000, 0, 1, 0,0,0)
									TriggerServerEvent("esx_Drugs:sellDrugs")
						else
							chance2 = math.random(1,2)
							if chance2 == 1 then
								oldped = ped
								TaskPlayAnim(ped, "cellphone@str", "f_cellphone_call_listen_maybe_a", 8.0, 8.0, 20000, 0, 1, 0,0,0)
								Citizen.Wait(3000)
								ESX.TriggerServerCallback('bobs_weed:cops', function(CopsConnected)
								if CopsConnected >= Config.cops then
									ESX.ShowNotification("The person ~r~rejected~s~ your offer and called the ~r~cops~s~ with a description!")
									local suspect = PlayerId(-1)	
									TriggerServerEvent('bobs_weed:reject', suspect)
									else
								ESX.ShowNotification("The person called the local ~r~Kingpin~s~")
								--kingpin
								Citizen.Wait(3000)
								if not DoesEntityExist(dealer) then
								RequestModel("s_m_y_dealer_01")
									while not HasModelLoaded("s_m_y_dealer_01") do
									Wait(10)
									end
									
								RequestModel("voodoo2")
									while not HasModelLoaded("voodoo2") do
									Wait(10)
									end
										local retval, coords = GetClosestVehicleNode(pos.x, pos.y , pos.z, 0)
										dealer = CreatePed(4, "s_m_y_dealer_01", coords.x, coords.y, coords.z, 0.0, true, false)
										dealer2 = CreatePed(4, "s_m_y_dealer_01", coords.x, coords.y, coords.z, 0.0, true, false)
										dealerveh = CreateVehicle("voodoo2", coords.x, coords.y, coords.z, 0.0, true, false)
										
										SetPedIntoVehicle(dealer, dealerveh, -1)
										SetPedIntoVehicle(dealer2, dealerveh, -2)
										SetVehicleFixed(dealerveh)
										SetVehicleOnGroundProperly(dealerveh)
										SetEntityAsMissionEntity(dealer, true, true)
										SetEntityAsMissionEntity(dealer2, true, true)
										SetPedFleeAttributes(dealer, 0, 0)
										SetPedFleeAttributes(dealer2, 0, 0)
										SetPedCombatAttributes(dealer, 2, 1)
										SetPedCombatAttributes(dealer2, 2, 1)
										SetPedCombatAbility(dealer, 100)
										SetPedCombatAbility(dealer2, 100)
										SetPedCombatMovement(dealer, 2)
										SetPedCombatMovement(dealer2, 2)
										SetPedCombatRange(dealer, 2)
										SetPedCombatRange(dealer2, 2)
										SetPedKeepTask(dealer, true)
										SetPedKeepTask(dealer2, true)
										GiveWeaponToPed(dealer, GetHashKey('WEAPON_PISTOL50'),250,false,true)
										GiveWeaponToPed(dealer2, GetHashKey('WEAPON_PISTOL50'),250,false,true)
										local playerped = PlayerPedId()
										AddRelationshipGroup('DrugsNPC')
								AddRelationshipGroup('PlayerPed')
								SetPedRelationshipGroupHash(dealer, 'DrugsNPC')
								SetPedRelationshipGroupHash(dealer2, 'DrugsNPC')
								SetRelationshipBetweenGroups(5,GetPedRelationshipGroupDefaultHash(playerped),'DrugsNPC')
								SetRelationshipBetweenGroups(5,'DrugsNPC',GetPedRelationshipGroupDefaultHash(playerped))
								Citizen.Wait(60000)
								if DoesEntityExist(dealer) then
								DeleteEntity(dealer)
								DeleteEntity(dealer2)
								end
								if DoesEntityExist(dealerveh) then
								DeleteEntity(dealerveh)
								end
								end
								
								
								--kingpin end
								end
								end)
							else
								oldped = ped
								SetEntityHeading(ped,GetHeadingFromVector_2d(pos.x-playerpos.x,pos.y-playerpos.y)+180)
								SetEntityHeading(oPlayer,GetHeadingFromVector_2d(pos.x-playerpos.x,pos.y-playerpos.y))
								TaskPlayAnim(ped, "misscarsteal4@actor", "actor_berating_loop", 8.0, 8.0, 5000, 0, 1, 0,0,0)
								Citizen.Wait(3000)
								ESX.ShowNotification("The person ~r~rejected~s~ your offer")
							end
						end
						SetPedAsNoLongerNeeded(oldped)
						FreezeEntityPosition(ped,false)
						FreezeEntityPosition(oPlayer,false)
						Citizen.Wait(10000)
						break
					end
				end
			end
			end
			end
		until not success
		EndFindPed(handle)
	end
end)

Citizen.CreateThread(function()
	while true do
		TriggerServerEvent("esx_Drugs:canSellDrugs")
		Citizen.Wait(10000)
	end
end)

function CanSellToPed(ped)
	if not IsPedAPlayer(ped) 
	and not IsPedInAnyVehicle(ped,false) 
	and not IsEntityDead(ped) 
	and IsPedHuman(ped) 
	and GetEntityModel(ped) ~= GetHashKey("s_m_y_cop_01") 
	and GetEntityModel(ped) ~= GetHashKey("s_m_m_paramedic_01") 
	and GetEntityModel(ped) ~= GetHashKey("s_m_y_dealer_01") 
	and GetEntityModel(ped) ~= GetHashKey("s_m_m_doctor_01") 
	and GetEntityModel(ped) ~= GetHashKey("csb_mweather")   
	and GetEntityModel(ped) ~= GetHashKey("s_f_y_sheriff_01")  
	and ped ~= oldped then 
		return true
	end
	return false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		streetName,_ = GetStreetNameAtCoord(playerpos.x, playerpos.y, playerpos.z)
		streetName = GetStreetNameFromHashKey(streetName)
	end
end)

RegisterNetEvent('bobs_weed:callCops')
AddEventHandler('bobs_weed:callCops', function(suspect)
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(suspect))
	ESX.ShowAdvancedNotification('Alert', 'Drug sales!', 'We have sent a description of the suspect!', mugshotStr, 4)
    UnregisterPedheadshot(mugshot)
    local suspectLoc = AddBlipForCoord(playerpos.x, playerpos.y, playerpos.z)
    SetBlipSprite(suspectLoc , 161)
    SetBlipScale(suspectLoc , 2.0)
    SetBlipColour(suspectLoc, 2)
    PulseBlip(suspectLoc)
	Wait(20*1000)
    RemoveBlip(suspectLoc)
end)