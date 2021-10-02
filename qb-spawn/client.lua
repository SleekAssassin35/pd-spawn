PantCore = nil

Citizen.CreateThread(function() 
    while PantCore == nil do
        TriggerEvent("PantCore:GetObject", function(obj) PantCore = obj end)    
        Citizen.Wait(200)
    end
end)

local location = "motel"
local type = "normal"

--CODE

local choosingSpawn = false

 RegisterCommand("spawne", function()
    TriggerEvent('pant-spawn:client:setupSpawns', PantCore.Functions.GetPlayerData(), false, nil)
    TriggerEvent("pant-spawn:client:openUI", true)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if NetworkIsPlayerActive(PlayerId()) then
            print("geldimi")
			TriggerServerEvent('pant-spawn:frist-chacter')
			break
		end
	end
end)

RegisterNetEvent('pant-spawn:frist-chacter')
AddEventHandler('pant-spawn:frist-chacter', function()
    if GetEntityModel(PlayerPedId()) == `PLAYER_ZERO` then
        local defaultModel = `a_m_y_stbla_02`
        RequestModel(defaultModel)

        while not HasModelLoaded(defaultModel) do
            Citizen.Wait(10)
        end

        SetPlayerModel(PlayerId(), defaultModel)
        SetPedDefaultComponentVariation(PlayerPedId())
        SetPedRandomComponentVariation(PlayerPedId(), true)
        SetModelAsNoLongerNeeded(defaultModel)
    end

    -- freeze the player
    FreezeEntityPosition(PlayerPedId(), true)

end)

RegisterNetEvent('pant-spawn:client:openUI')
AddEventHandler('pant-spawn:client:openUI', function(value, new)
    SetEntityVisible(PlayerPedId(), false)
    DoScreenFadeOut(250)
    Citizen.Wait(2000)
    DoScreenFadeIn(250)
    PantCore.Functions.GetPlayerData(function(PlayerData)     
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + 150, -85.00, 0.00, 0.00, 100.00, false, 0)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)
    end)
    Citizen.Wait(500)
    SetDisplay(value)
end)

RegisterNUICallback("exit", function(data)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "ui",
        status = false
    })
    choosingSpawn = false
end)

local cam = nil
local cam2 = nil

-- function setupSpawnLocations()
--     SendNUIMessage({
--         action = "setupLocations",
--         locations = PANT.Spawns
--     })
-- end

RegisterNUICallback('setCam', function(data)
    location = tostring(data.posname)
    type = tostring(data.type)

    local camZPlus1 = 300
    local camZPlus2 = 100
    local pointCamCoords = 75
    local pointCamCoords2 = 0
    local cam1Time = 500
    local cam2Time = 1000

    if DoesCamExist(cam) then
        DestroyCam(cam, true)
    end

    if DoesCamExist(cam2) then
        DestroyCam(cam2, true)
    end

    if type == "current" then
        PantCore.Functions.GetPlayerData(function(PlayerData)
            cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + camZPlus1, 300.00,0.00,0.00, 110.00, false, 0)
            PointCamAtCoord(cam2, PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + pointCamCoords)
            SetCamActiveWithInterp(cam2, cam, cam1Time, true, true)
            if DoesCamExist(cam) then
                DestroyCam(cam, true)
            end
            Citizen.Wait(cam1Time)

            cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + camZPlus2, 300.00,0.00,0.00, 110.00, false, 0)
            PointCamAtCoord(cam, PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + pointCamCoords2)
            SetCamActiveWithInterp(cam, cam2, cam2Time, true, true)
            --SetEntityCoords(PlayerPedId(), PlayerData.position.x, PlayerData.position.y, PlayerData.position.z)
        end)
    elseif type == "normal" then
        local campos = PANT.Spawns[location].coords

        cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", campos.x, campos.y, campos.z + camZPlus1, 300.00,0.00,0.00, 110.00, false, 0)
        PointCamAtCoord(cam2, campos.x, campos.y, campos.z + pointCamCoords)
        SetCamActiveWithInterp(cam2, cam, cam1Time, true, true)
        if DoesCamExist(cam) then
            DestroyCam(cam, true)
        end
        Citizen.Wait(cam1Time)

        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", campos.x, campos.y, campos.z + camZPlus2, 300.00,0.00,0.00, 110.00, false, 0)
        PointCamAtCoord(cam, campos.x, campos.y, campos.z + pointCamCoords2)
        SetCamActiveWithInterp(cam, cam2, cam2Time, true, true)
        --SetEntityCoords(PlayerPedId(), campos.x, campos.y, campos.z)
    end
end)

RegisterNUICallback('chooseAppa', function(data)
    local appaYeet = data.appType

    SetDisplay(false)
    DoScreenFadeOut(500)
    Citizen.Wait(5000)
    TriggerServerEvent('PantCore:Server:OnPlayerLoaded')
    TriggerEvent('PantCore:Client:OnPlayerLoaded')
    FreezeEntityPosition(ped, false)
    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    SetCamActive(cam2, false)
    DestroyCam(cam2, true)
    SetEntityVisible(PlayerPedId(), true)
end)

RegisterNUICallback('spawnplayer', function()
    local PlayerData = PantCore.Functions.GetPlayerData()
    if type == "current" then
        SetDisplay(false)
        DoScreenFadeOut(500)
        Citizen.Wait(8000)
        TriggerServerEvent('PantCore:Server:OnPlayerLoaded')
        TriggerEvent('PantCore:Client:OnPlayerLoaded')
        Citizen.Wait(500)
        local PlayerData = nil
        PantCore.Functions.GetPlayerData(function(PlayerLastData)
            PlayerData = PlayerLastData
            SetEntityCoords(PlayerPedId(), PlayerData.position.x, PlayerData.position.y, PlayerData.position.z)
        end)
        RenderScriptCams(false, true, 500, true, true)
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        SetCamActive(cam2, false)
        DestroyCam(cam2, true)
        SetEntityVisible(PlayerPedId(), true)
        Citizen.Wait(500)
        DoScreenFadeIn(250)
        FreezeEntityPosition(PlayerPedId(), false)
        SetEntityCoords(PlayerPedId(), PlayerData.position.x, PlayerData.position.y, PlayerData.position.z)
        SetEntityHeading(PlayerPedId(), PlayerData.position.a)
    elseif type == "normal" then
        SetDisplay(false)
        DoScreenFadeOut(500)
        Citizen.Wait(5000)
        TriggerServerEvent('PantCore:Server:OnPlayerLoaded')
        TriggerEvent('PantCore:Client:OnPlayerLoaded')
        Citizen.Wait(500)
        SetEntityCoords(PlayerPedId(), PANT.Spawns[location].coords.x, PANT.Spawns[location].coords.y, PANT.Spawns[location].coords.z)
        RenderScriptCams(false, true, 500, true, true)
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        SetCamActive(cam2, false)
        DestroyCam(cam2, true)
        SetEntityVisible(PlayerPedId(), true)
        Citizen.Wait(500)
        DoScreenFadeIn(250)
        FreezeEntityPosition(PlayerPedId(), false)
        SetEntityCoords(PlayerPedId(), PANT.Spawns[location].coords.x, PANT.Spawns[location].coords.y, PANT.Spawns[location].coords.z)
        SetEntityHeading(PlayerPedId(), PANT.Spawns[location].coords.h)
    end
    TriggerEvent('ld-ambulance:check-death')
end)

function SetDisplay(bool)
    choosingSpawn = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool
    })
end

Citizen.CreateThread(function()
    while choosingSpawn do
        Citizen.Wait(0)

        DisableAllControlActions(0)
    end
end)

RegisterNetEvent('pant-spawn:client:setupSpawns')
AddEventHandler('pant-spawn:client:setupSpawns', function(cData, new, apps)
    if not new then
        SendNUIMessage({
            action = "setupLocations",
            locations = PANT.Spawns,
           -- houses = "",
        })
   
    elseif new then
       SendNUIMessage({
            action = "setupAppartements",
            locations = PANT.Spawns,
        })
    end
end)