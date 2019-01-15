MaxFuel = 100
decreasing = 0.0005 -- per frame

function onVehicleEngineOn(btn,press)
	if press then
		if btn == "2" then
			local theVehicle = getPedOccupiedVehicle ( lp )
			if theVehicle then
				local state = getVehicleEngineState(theVehicle)
				if getElementData(theVehicle,"pid") == getElementData(lp, "tableid") then
                    setVehicleEngineState(theVehicle, not(state))
                    toggleControl( 'accelerate', not(isControlEnabled('accelerate')) )
                    toggleControl( 'brake_reverse', not(isControlEnabled('brake_reverse')) )
				elseif getElementData(theVehicle, "frid") == getElementData(lp, "faction") then
                    setVehicleEngineState(theVehicle, not(state))
                    toggleControl( 'accelerate', not(isControlEnabled('accelerate')) )
                    toggleControl( 'brake_reverse', not(isControlEnabled('brake_reverse')) )
 				end
			end
		end
	end
end
addEventHandler( "onClientKey", root, onVehicleEngineOn)

function vehicleRemoveFuel()
    local veh = getPedOccupiedVehicle(lp)
    if veh then
        if getVehicleEngineState(veh) then
            local speedx, speedy, speedz = getElementVelocity ( lp )
            local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
            local localkmh = actualspeed * 180

            local newFuel = getElementData(veh,"fuel")-decreasing*
        else

        end
    end
end
addEventHandler( "onClientRender",root, vehicleRemoveFuel )