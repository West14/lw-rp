MaxFuel = 100
decreasing = 0.000005 -- per frame
isOnGasStation = false
local speedometerTexture = dxCreateRoundedTexture(screenW * 0.8194, screenH * 0.7100, screenW * 0.1590, screenH * 0.2467, 10, "Images/speedbg.png")

function engineCheck(theVehicle)
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

function beltCheck(theVehicle)
    local belt = getElementData(theVehicle,"belt")
    setElementData(theVehicle, "belt",not(belt))
end

function lightCheck(theVehicle)
    local state = getVehicleOverrideLights(theVehicle)
    if ( state ~= 2 ) then
        setVehicleOverrideLights ( theVehicle, 2 )
    else
        setVehicleOverrideLights ( theVehicle, 1 )
    end
end

local vehBtnFunctions = {
    {"2",engineCheck},
    {"l",beltCheck},
    {"lctrl",lightCheck}
}


function onVehicleEngineOn(btn,press)
    if press then
        local theVehicle = getPedOccupiedVehicle ( lp )
	    if theVehicle then
            for i=1,#vehBtnFunctions do
                if btn == vehBtnFunctions[i][1] then
                    vehBtnFunctions[i][2](theVehicle)
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
        dxDrawImage(screenW * (1169/sX), screenH * (627/sY), 252, 246, "Images/avatar-mask.png", 0, 0, 0, tocolor(34, 37, 42, 172), false)
        dxDrawImage(screenW * 0.7514, screenH * 0.7744, screenW * 0.0458, screenH * 0.0700, "Images/avatar-mask.png", 0, 0, 0, tocolor(34, 37, 42, 172), false)
        dxDrawImage(screenW * 0.7292, screenH * 0.8700, screenW * 0.0681, screenH * 0.1022, "Images/avatar-mask.png", 0, 0, 0, tocolor(34, 37, 42, 172), false)
        dxDrawImage(screenW * (1184/sX), screenH * (629/sY), 218, 218, "Images/speedbg.png")
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

function onVehDamage(attacker,weap,loss,atx,aty,atz)
    local speedx, speedy, speedz = getElementVelocity ( source )
    local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
    local localkmh = actualspeed * 180
    if loss > 100 then
        local x,y,z = getElementPosition(lp)
        fadeCamera(false,0)
        local phealth = getElementHealth(lp)
        setElementHealth(lp,phealth-loss/25)
        toggleControl ( "accelerate", false ) -- disable the accelerate key
        toggleControl ( "brake_reverse", false ) -- disable the brake_reverse key
        toggleControl ( "handbrake", false ) -- disable the handbrake key
        toggleControl ( "enter_exit", false )
        startAudio("Audio/zvonvushax.mp3",0.3)
        startAudio("Audio/serdce.mp3",1)
        if getElementData(source,"belt") then
            createVehTimer(5000)
        else
            createVehTimer(2000)
        end
    end
end
addEventHandler("onClientVehicleDamage",root,onVehDamage)

function createVehTimer(interval)
    setTimer(function()
        fadeCamera(true,interval/1000)
        
        toggleControl ( "accelerate", true ) -- disable the accelerate key
        toggleControl ( "brake_reverse", true ) -- disable the brake_reverse key
        toggleControl ( "handbrake", true ) -- disable the handbrake key
        toggleControl ( "enter_exit", true )
    end,interval,1)
end


function createFuelCuboid()
    colcircle = createColCuboid(1,1,10)
    setElementData(colcircle,"type","gas-station")
end

function gasHit(element)
    if getElementData(element,"type") == "gas-station" then
        isOnGasStation = true
        outputDebugString("hit")
    end
end

addEventHandler ( "onClientColShapeHit", getRootElement(), gasHit )

function gasLeave(element)
    if getElementData(element, "type") == "gas-station" then
        isOnGasStation = false
        outputDebugString("leave")
    end 
end
addEventHandler("onClientColShapeLeave",root, gasLeave)