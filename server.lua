ESX = exports['es_extended']:getSharedObject()



RegisterServerEvent("blt_userinfo:OpenMenu")
AddEventHandler("blt_userinfo:OpenMenu", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local getmoney = xPlayer.getMoney()
    local getmoneybank = xPlayer.getAccount('bank').money
    local getmoneynegro = xPlayer.getAccount('black_money').money
    local getcoins = xPlayer.getAccount('pejecoinss').money
    TriggerClientEvent("blt_userinfo:OpenMenuCL", source, getmoney, getmoneybank, getmoneynegro, getcoins)
end)


