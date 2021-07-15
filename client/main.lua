ESX = nil
local PlayerData = {}
local money = {bank = 0, money = 0}
local PlayerCharacterName = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer

    ESX.TriggerServerCallback('chicle_pause_menu:getPlayerMoney', function(cb)
        money.money = cb.money
        money.bank = cb.bank
    end)

    ESX.TriggerServerCallback('chicle_pause_menu:getPlayerName', function(cb) PlayerCharacterName = cb end)

end)

Citizen.CreateThread(function()
    local IsPauseMenu = false -- This is just to check if you just opened the pause menu

    while true do
        Wait(0)

        if IsPauseMenuActive() then
            if not isPauseMenu then
                isPauseMenu = true
                ESX.TriggerServerCallback('chicle_pause_menu:getPlayerMoney', function(cb)
                    money.money = cb.money
                    money.bank = cb.bank
                end)

                if PlayerCharacterName == nil then
                    ESX.TriggerServerCallback('chicle_pause_menu:getPlayerName', function(cb)
                        PlayerCharacterName = cb
                    end)
                end
            end

              -- Space for the subtitle
              BeginScaleformMovieMethodOnFrontendHeader("SHIFT_CORONA_DESC")
              PushScaleformMovieFunctionParameterBool(true)
              PushScaleformMovieFunctionParameterBool(true)
              PopScaleformMovieFunction()

              -- The title text
              BeginScaleformMovieMethodOnFrontendHeader("SET_HEADER_TITLE")
              PushScaleformMovieFunctionParameterString(Config.title)
              PushScaleformMovieFunctionParameterBool(true)

              -- The subtitle text
              PushScaleformMovieFunctionParameterString(Config.subtitle)
              PushScaleformMovieFunctionParameterBool(true)
              PopScaleformMovieFunctionVoid()

              BeginScaleformMovieMethodOnFrontendHeader("SET_HEADING_DETAILS")
              PushScaleformMovieFunctionParameterString(PlayerCharacterName) -- Nombre del jugador
              PushScaleformMovieFunctionParameterString((Config.cash_text):format(money.money)) -- Dia y hora
              PushScaleformMovieFunctionParameterString((Config.bank_text):format(money.bank)) -- Dinero en banco y efectivo
              ScaleformMovieMethodAddParamBool(false)
              ScaleformMovieMethodAddParamBool(isScripted)
              EndScaleformMovieMethod()

        else
          if isPauseMenu then
            isPauseMenu = false
          end
        end

    end

end)
