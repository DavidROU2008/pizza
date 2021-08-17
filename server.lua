local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_pizza")

local pizza = math.random(1, 5)

RegisterServerEvent('pizza:notificare')
AddEventHandler('pizza:notificare', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if vRP.hasGroup({user_id, 'Pizza'}) then
    vRPclient.notify(player, {GetPlayerName(source).. " ~h~~b~verifici pizza din cuptor🍕"})
    end
end)

RegisterServerEvent('pizza:cuptor')
AddEventHandler('pizza:cuptor', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if vRP.hasGroup({user_id, 'Pizza'}) then
        vRP.giveInventoryItem({user_id, 'pizza', pizza, true})
    vRPclient.notify(player, {GetPlayerName(source).. " ~h~~b~ai pus pizza in ghizodan🍕"})
    exports.ghmattimysql:execute("UPDATE vrp_users SET experience=experience+10 WHERE id=@id", {
        ['@id'] = user_id
    }, function (rows)
    end)
    vRPclient.notify(player, {"~h~~g~Ai primit +10EXP"})
    end
end)
