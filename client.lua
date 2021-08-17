local Coordonatepizza = {
    {1736.3565673828,6415.8325195312,35.037227630615}
}

--local CoordonateJob = {
   -- {-421.62188720704,6135.8349609375,31.877309799194}
--}

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        local Jucator = PlayerPedId(-1)
        local CoordonateJucator = GetEntityCoords(Jucator)
        for k,v in pairs (Coordonatepizza) do 
            local Distanta = GetDistanceBetweenCoords(CoordonateJucator.x, CoordonateJucator.y, CoordonateJucator.z, v[1], v[2], v[3], true)
            if Distanta < 5 then 
                if (Vdist(CoordonateJucator.x, CoordonateJucator.y, CoordonateJucator.z,v[1],v[2],v[3])) then
                    Draw3DText(CoordonateJucator.x, CoordonateJucator.y, CoordonateJucator.z+1, "~h~~b~Apasa ~w~[E] ~b~pentru a collecta pizza din cuptor!", 0.5)
                    Draw3DText(CoordonateJucator.x, CoordonateJucator.y, CoordonateJucator.z, "~h~~w~[ ~b~Jerry's Pizza ~w~]", 0.5)
                        DrawMarker(42, v[1],v[2],v[3] , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 38, 188, 247, 200, 0, 0, 0, 1, 0, 0, 0)
                        if Distanta < 1 then 
                            if IsControlJustPressed(0, 38) then 
                                local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
                                local pizza = CreateObject(GetHashKey("prop_cs_box_clothes"), x, y, z+0.2,  true,  true, true)
                                TriggerServerEvent('pizza:notificare')
                                TaskStartScenarioInPlace(Jucator, 'PROP_HUMAN_PARKING_METER', 0, true)
                                AttachEntityToEntity(pizza, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.08, 0, -0.10, 80.0, -20.0, 175.0, true, true, false, true, 1, true)
                                Wait(5000)
                                TriggerServerEvent('pizza:cuptor')
                                ClearPedTasks(Jucator)
                                DeleteEntity(pizza)
                        end
                    end
                end
            end
        end
    end
end)

function Draw3DText(x,y,z, text,scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(1.0*scale, 2.1*scale)
        SetTextFont(1)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(""..text)
        DrawText(_x,_y)
    end
end
      