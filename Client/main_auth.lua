local loginTexture = dxCreateRoundedTexture(screenW * 0.2917, screenH * 0.6500, 10)
local loginTextureSmooth = dxSmoothRoundedTexture(loginTexture, screenW * 0.3542, screenH * 0.1756, screenW * 0.2917, screenH * 0.6500, "Images/mask.png" )

local buttons = {
	[1] = {screenW * 0.3785, screenH * 0.6800, 0,0},
	[2] = {screenW * 0.5111, screenH * 0.6800, 0,0}
}

local Btnhovered = {
	[1] = false,
	[2] = false
}

wanim,hanim = false

local authButtonActive = dxCreateRoundedTexture(screenW * 0.1104, screenH * 0.0578,10)
local authButtonInActive = dxCreateRoundedTexture(screenW * 0.1104, screenH * 0.0578,10)
local authButtonSmoothActive = dxSmoothRoundedTexture(authButtonActive, screenW * 0.3785, screenH * 0.6800, screenW * 0.1104, screenH * 0.0578, "Images/mask-active.png" )
local authButtonSmoothInActive = dxSmoothRoundedTexture(authButtonActive, screenW * 0.3785, screenH * 0.6800, screenW * 0.1104, screenH * 0.0578, "Images/mask-inactive.png" )

function onResStart(  )
	loginPanel = dxCreateRenderTarget( screenW * 0.2917, screenH * 0.6500, true )
	showCursor(true)
    dxSetRenderTarget( loginPanel ) -- Select custom render target for drawing
   	dxDrawRoundedRectangle(0, 0, screenW * 0.2917, screenH * 0.6500, tocolor(34,37,42,216), 10)
    dxSetRenderTarget()       
end
addEventHandler( "onClientResourceStart", getRootElement(), onResStart )

function renderLogInPanel( )
	dxDrawImage( screenW * 0.3542, screenH * 0.1756, screenW * 0.2917, screenH * 0.6500, loginTextureSmooth )
	
end
addEventHandler( "onClientRender", root, renderLogInPanel )

function renderMainMenu( )
	dxDrawImage(screenW * 0.3250, screenH * 0.1756, screenW * 0.3556, screenH * 0.5689, "Images/auth-logo.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)

	dxDrawImage( screenW * 0.3785, screenH * 0.6800, screenW * 0.1104, screenH * 0.0578, authButtonSmoothInActive )
	dxDrawImage( screenW * 0.3785, screenH * 0.6800, buttons[1][3],buttons[1][4], authButtonSmoothActive)

	dxDrawImage( screenW * 0.5111, screenH * 0.6800, screenW * 0.1104, screenH * 0.0578, authButtonSmoothInActive )
	dxDrawImage( screenW * 0.5111, screenH * 0.6800, buttons[2][3],buttons[2][4], authButtonSmoothActive,0,0,0)
end
addEventHandler( "onClientRender", root, renderMainMenu )

function isCursorOnBtn( )
	for k,v in ipairs(buttons) do
		if isMouseInPosition(v[1],v[2],screenW * 0.1104, screenH * 0.0578) then
			if not(animbtn) then
				Btnhovered[k] = true
				endWidth,endHeight = screenW * 0.1104, screenH * 0.0578
				animbtn = k
				if not(isEventHandlerAdded("onClientRender", getRootElement(), animateBtn)) then
					addEventHandler( "onClientRender", getRootElement(), animateBtn )
				end
			end
		else
			Btnhovered[k] = false
		end
	end
end
addEventHandler( "onClientRender", getRootElement(), isCursorOnBtn )

function animateBtn(  )
	if wanim and hanim then
		outputDebugString( "end" )
		removeEventHandler("onClientRender",root,animateBtn)
		animbtn = false
	else
		buttons[animbtn][3] = animate(buttons[animbtn][3],endWidth,"Linear",100,function(width )
			if width == endWidth then
				wanim = true
			end
		end)
		outputDebugString( buttons[animbtn][3] )
		buttons[animbtn][4] = animate(buttons[animbtn][4],endHeight,"Linear",100,function( height )
			if height == endHeight then
				hanim = true			
			end
		end)
		outputDebugString( buttons[animbtn][4] )
	end
end