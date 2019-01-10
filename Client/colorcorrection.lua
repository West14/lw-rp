function carpaint_staRef()
    if not carGeneShader then carGeneShader = dxCreateShader ( "Shaders/car_refgene.fx",1,Settings.var.renderDistance,true) end
    if not carShatShader then carShatShader = dxCreateShader ( "Shaders/car_refgene.fx",1,Settings.var.renderDistance,true) end
    -- Apply to world texture
    if Settings.var.CarPaintVers==3 then carGrunShader=dxCreateShader ( "Shaders/car_refgrunL.fx",1,Settings.var.renderDistance,true) end
    if Settings.var.CarPaintVers==2 then carGrunShader=dxCreateShader ( "Shaders/car_refgrun.fx",1,Settings.var.renderDistance,false) end
    
    carpaint_RefSettings()
    
    engineApplyShaderToWorldTexture ( carGrunShader, "vehiclegrunge256" )
    engineApplyShaderToWorldTexture ( carGrunShader, "?emap*" )
    engineApplyShaderToWorldTexture ( carGeneShader, "vehiclegeneric256" )
    engineApplyShaderToWorldTexture ( carShatShader, "vehicleshatter128" )
    engineApplyShaderToWorldTexture ( carGeneShader, "hotdog92glass128" )
    engineApplyShaderToWorldTexture ( carGeneShader, "okoshko" )
    
    for _,addList in ipairs(texturegrun) do
    engineApplyShaderToWorldTexture (carGrunShader, addList )
    end	
end

function carpaint_stopRef()
    if carGrunShader and carGeneShader and carShatShader then
        engineRemoveShaderFromWorldTexture ( carGrunShader, "vehiclegrunge256" )
        engineRemoveShaderFromWorldTexture ( carGrunShader, "?emap*" )
        engineRemoveShaderFromWorldTexture ( carGeneShader, "vehiclegeneric256" )
        engineRemoveShaderFromWorldTexture ( carShatShader, "vehicleshatter128" )
        engineRemoveShaderFromWorldTexture ( carGeneShader, "hotdog92glass128" )
        engineRemoveShaderFromWorldTexture ( carGeneShader, "okoshko" )
    for _,addList in ipairs(texturegrun) do
        engineRemoveShaderFromWorldTexture(carGrunShader, addList )
    end
    destroyElement(carGrunShader)
    destroyElement(carGeneShader)
    destroyElement(carShatShader)
    carGrunShader=nil
    carGeneShader=nil
    carShatShader=nil
    end
end

function applyPalette( src, lumPixel)
	if not src then return nil end
	local mx,my = dxGetMaterialSize( src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( paletteShader, "sBaseTexture", src )
	dxSetShaderValue( paletteShader, "sLumPixel", lumPixel )
	dxDrawImage( 0, 0, mx,my, paletteShader )
	return newRT
end

addEventHandler("onClientRender",root,function()
    applyPalette(window,"Images/shaderpallete.png")
end)