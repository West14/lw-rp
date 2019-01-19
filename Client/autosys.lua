MaxFuel = 100
decreasing = 0.000005 -- per frame
local speedometerTexture = dxCreateRoundedTexture(screenW * 0.8194, screenH * 0.7100, screenW * 0.1590, screenH * 0.2467, 10, "Images/speedbg.png")

function onVehicleEngineOn(btn,press)
	if press then
		if btn == "2" then
			local theVehicle = getPedOccupiedVehicle ( lp )
			if theVehicle then
				local state = getVehicleEngineState(theVehicle)
                if getElementData(theVehicle,"pid") == getElementData(lp, "tableid") then
                    if getElementData(theVehicle,"fuel") > 0 then
                        setVehicleEngineState(theVehicle, not(state))
                        toggleControl( 'accelerate', not(isControlEnabled('accelerate')) )
                        toggleControl( 'brake_reverse', not(isControlEnabled('brake_reverse')) )
                    end
                elseif getElementData(theVehicle, "frid") == getElementData(lp, "faction") then
                    if getElementData(theVehicle,"fuel") > 0 then
                        setVehicleEngineState(theVehicle, not(state))
                        toggleControl( 'accelerate', not(isControlEnabled('accelerate')) )
                        toggleControl( 'brake_reverse', not(isControlEnabled('brake_reverse')) )
                    end
 				end
			end
		end
	end
end
addEventHandler( "onClientKey", root, onVehicleEngineOn)

function vehicleRemoveFuel()
    local veh = getPedOccupiedVehicle(lp)
    if veh then
        --radar dxDrawImage(screenW * 0.0083, screenH * 0.6978, screenW * 0.1792, screenH * 0.2733, "Images/avatar-mask.png", 0, 0, 0, tocolor(34, 37, 42, 172), false)

        dxDrawImage(screenW * 0.8090, screenH * 0.6989, screenW * 0.1792, screenH * 0.2733, "Images/avatar-mask.png", 0, 0, 0, tocolor(34, 37, 42, 172), false)
        dxDrawImage(screenW * 0.7514, screenH * 0.7744, screenW * 0.0458, screenH * 0.0700, "Images/avatar-mask.png", 0, 0, 0, tocolor(34, 37, 42, 172), false)
        dxDrawImage(screenW * 0.7292, screenH * 0.8700, screenW * 0.0681, screenH * 0.1022, "Images/avatar-mask.png", 0, 0, 0, tocolor(34, 37, 42, 172), false)

        dxDrawImage(screenW * 0.8194, screenH * 0.7100, screenW * 0.1590, screenH * 0.2467, "Images/speedbg.png")

        if getVehicleEngineState(veh) then
            local speedx, speedy, speedz = getElementVelocity ( veh )
            local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
            local localkmh = actualspeed * 180
            local newFuel = getElementData(veh,"fuel")-decreasing*localkmh
            setElementData(veh,"fuel",newFuel)
        end
        if getElementData(veh,"fuel") <= 0 then
            setVehicleEngineState(veh, false)
            toggleControl( 'accelerate', not(isControlEnabled('accelerate')) )
            toggleControl( 'brake_reverse', not(isControlEnabled('brake_reverse')) )
        end
    end
end
addEventHandler( "onClientRender",root, vehicleRemoveFuel )