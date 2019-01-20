function onDamageVehicle(loss)
    outputDebugString("test")
    local thePlayer = getVehicleOccupant(source)
    if thePlayer then
        triggerClientEvent(thePlayer,"onVehDamage",thePlayer,loss)
    end
    if getElementHealth(source) < 300 then
        setVehicleEngineState(source,false)
        setElementHealth(source,333)
        setVehicleDamageProof(source,false)
        setElementData(source,"stalled",true)
    end
end
addEventHandler("onVehicleDamage", root, onDamageVehicle)