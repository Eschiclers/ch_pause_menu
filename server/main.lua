local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('chicle_pause_menu:getPlayerName', function(source,cb) 
  local xPlayer = ESX.GetPlayerFromId(source)
  cb(xPlayer.getName())
end)

ESX.RegisterServerCallback('chicle_pause_menu:getPlayerMoney', function(source,cb) 
  local xPlayer = ESX.GetPlayerFromId(source)

  cb( { money = xPlayer.getAccount('money').money, bank = xPlayer.getAccount('bank').money } )
end)