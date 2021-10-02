PantCore = nil
TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)

RegisterServerEvent("pant-spawn:frist-chacter")
AddEventHandler("pant-spawn:frist-chacter",function()
--	TriggerEvent('PantCore:Server:OnPlayerLoaded')
	--local src = source
	--local Player = PantCore.Functions.GetPlayer(src)
	--TriggerClientEvent('pant-spawn:client:setupSpawns', src, Player, false, {})
	--TriggerClientEvent('pant-spawn:client:openUI', src, true)
end)


-- Citizen.CreateThread(function()
-- 	local HouseGarages = {}
-- 	PantCore.Functions.ExecuteSql(false, "SELECT * FROM `houselocations`", function(result)
-- 		if result[1] ~= nil then
-- 			for k, v in pairs(result) do
-- 				local owned = false
-- 				if tonumber(v.owned) == 1 then
-- 					owned = true
-- 				end
-- 				local garage = v.garage ~= nil and json.decode(v.garage) or {}
-- 				Config.Houses[v.name] = {
-- 					coords = json.decode(v.coords),
-- 					owned = v.owned,
-- 					price = v.price,
-- 					locked = true,
-- 					adress = v.label, 
-- 					tier = v.tier,
-- 					garage = garage,
-- 					decorations = {},
-- 				}
-- 				HouseGarages[v.name] = {
-- 					label = v.label,
-- 					takeVehicle = garage,
-- 				}
-- 			end
-- 		end
-- 		TriggerClientEvent("pant-garages:client:houseGarageConfig", -1, HouseGarages)
-- 		TriggerClientEvent("pant-houses:client:setHouseConfig", -1, Config.Houses)
-- 	end)
-- end)

-- PantCore.Functions.CreateCallback('pant-spawn:server:getOwnedHouses', function(source, cb, cid)
-- 	if cid ~= nil then
-- 		PantCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_houses` WHERE `citizenid` = "'..cid..'"', function(houses)
-- 			if houses[1] ~= nil then
-- 				cb(houses)
-- 			else
-- 				cb(nil)
-- 			end
-- 		end)
-- 	else
-- 		cb(nil)
-- 	end
-- end)

--  PantCore.Commands.Add("testloc", "Een race stoppen als creator.", {}, false, function(source, args)
-- 	local src = source
-- 	local Player = PantCore.Functions.GetPlayer(src)
-- 	TriggerClientEvent('pant-spawn:client:setupSpawns', src, Player, false, {})
-- 	TriggerClientEvent('pant-spawn:client:openUI', src, true)
-- end)