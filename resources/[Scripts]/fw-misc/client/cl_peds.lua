-- // Events \\ --

-- RegisterNetEvent('fw-interactions:client:talk:to:npc')
-- AddEventHandler('fw-interactions:client:talk:to:npc', function(SubType, Entity)
--     local Type = Entity['Type']
--     Citizen.SetTimeout(150, function()
--         PlayAmbientSpeech1(Entity['Entity'], "GENERIC_HI", "SPEECH_PARAMS_FORCE_NORMAL")
--         if Type == 'Toolshop' or Type == 'Fisher' or Type == 'Pickaxe' then
--             TriggerEvent('fw-stores:server:open:shop')
--         elseif Type == 'Rental' then
--             TriggerEvent('fw-vehicles:client:open:rental')
--         elseif Type == 'Electronics' then
--             TriggerServerEvent('fw-illegal:server:sell:electrnoics')
--         elseif Type == 'Secret-Sell' then
--             TriggerServerEvent('fw-fishing:server:sell:gold-fish')
--         elseif Type == 'SellWeed' then
--             TriggerServerEvent('fw-illegal:server:sell:weed')
--         elseif Type == 'BarsSell' then
--             TriggerEvent('fw-pawnshop:client:open:selling', 'BarsItem')
--         elseif Type == 'OtherSell' then
--             TriggerEvent('fw-illegal:client:open:selling:other')
--         elseif Type == 'Hydrochloricacid' or Type == 'Ephedrine' or Type == 'Onderwerelddokter' then
--             TriggerEvent('fw-stores:server:open:shop')
--         elseif Type == 'Coke-Plane' then
--             TriggerEvent('fw-coke:client:rentPlane')
--         elseif Type == 'KartEvent' then
--             TriggerEvent('fw-vehicles:client:open:kartrental')
--         end
--     end)
-- end)