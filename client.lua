ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterCommand("AbrirMenuPersonal", function(source, args, rawCommand)
    TriggerServerEvent("blt_userinfo:OpenMenu")
end, true) 

RegisterKeyMapping('AbrirMenuPersonal', 'Abrir Info Menu', 'keyboard', 'F4')

RegisterNetEvent("blt_userinfo:OpenMenuCL")
AddEventHandler("blt_userinfo:OpenMenuCL", function(dineromano, dinerobanco, blackmmoney, coins)
    if PlayerClub == nil then
        OpenInfoMenu(dineromano, dinerobanco, blackmmoney, coins)
    else
        OpenInfoMenuConClub(dineromano, dinerobanco, blackmmoney, coins)
    end

end)


function OpenInfoMenu(dineromano, dinerobanco, blackmmoney, coins)
    ESX.UI.Menu.CloseAll()

    Trabajo = ("Trabajo: " ..ESX.PlayerData.job.label)
    Rango = ("Rango: " ..ESX.PlayerData.job.grade_label)
    DineroMano2 = ("Dinero: " ..dineromano)
    DineroBanco2 = ("Banco: " ..dinerobanco)
    coins2 = ("Peje Coins " ..coins)
    DineroNegro2 = ("Dinero Negro: " ..blackmmoney)


    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'info', {
        title = 'Informacion Del jugador',
        align = 'bottom-right',
        elements = {
            {label = Trabajo, value = 'nil'},
            {label = Rango, value = 'nil'},
            {label = DineroMano2, value = 'nil'},
            {label = DineroBanco2, value = 'nil'},
            {label = DineroNegro2, value = 'nil'},
            {label = coins2, value = 'nil'},
            {label = 'Dinero de Sociedad', value = 'bossmoney'}
        }
    }, function(data, menu)
        if data.current.value == 'nil' then
        elseif data.current.value == 'bossmoney' and ESX.PlayerData.job.grade_name == 'boss' then
            ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boss_label', {
                    title    = 'Dinero de Sociedad',
                    align    = 'bottom-right',
                    elements = {
                        {label = 'Dinero de Sociedad:  ' .. money, value = 'society_label'}
                    }}, function(data3, menu3)
                end, function(data3, menu3)
                    menu3.close()
                end)

            end, ESX.PlayerData.job.name)
        else
            ESX.ShowNotification("No eres Jefe de una Facción", 'error')
        end
          menu.close()
    end, function(data, menu)
        menu.close()
    end)
end