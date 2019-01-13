local width, height, h_height, r_height, s_width = 500, 520, 70, 40, 15
local renderTarget = dxCreateRenderTarget( width, height, true )
local posX = ( screenW - width ) / 2
local isScrollActive, scrollCache, scrollColor = _, 0, 0
maxplayers = 500
players = {}

function dxDrawTabList()
	if isLogged(lp) then
		if ( getKeyState( "TAB" ) ) then
			local c_height = getPlayerCount() * r_height
			local posY = ( screenH - ( math.min( c_height, height ) + h_height ) ) / 2
			dxDrawRectangle( posX, posY, width, h_height, tocolor(123, 168, 44, 255), true )
			dxDrawText( getPlayerCount() .. "/"..maxplayers, posX, posY, posX + width - 10, posY + h_height, tocolor( 255, 255, 255, 255 ), 1, font_montregularB, "right", "center", false, false, true )
			local headerX, headerY = posX + 85, posY + 7
			dxDrawImageSection( headerX, headerY, 16, 16, 16, 0, 16, 16, "Images/icons.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ), true )
			dxDrawText( getElementData(lp,"nick"):gsub( "_", " " ), headerX + 20, headerY, headerX + 20, headerY + 16, tocolor( 255, 255, 255, 255 ), 1, font_montregular, "left", "center", false, false, true )
			dxDrawImageSection( headerX, headerY + 20, 16, 16, 32, 0, 16, 16, "Images/icons.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ), true )
			dxDrawText( convertNumber( getPlayerMoney( ) ) .. "$", headerX + 20, headerY + 20, headerX + 20, headerY + 36, tocolor( 255, 255, 255, 255 ), 1, font_montregular, "left", "center", false, false, true )
			dxDrawImageSection( headerX, headerY + 40, 16, 16, 0, 0, 16, 16, "Images/icons.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ), true )
			dxDrawText( getZoneName( getElementPosition( localPlayer ) ), headerX + 20, headerY + 40, headerX + 20, headerY + 56, tocolor( 255, 255, 255, 255 ), 1, font_montregular, "left", "center", false, false, true )
			
			local offsetY = 0
			local _width = c_height > height and width - s_width - 5 or width
			
			dxSetRenderTarget( renderTarget, true )
				for i = 1, getPlayerCount() do
					local posY = offsetY - scrollCache
					dxDrawRectangle( 0, posY, width, r_height, tocolor( 0, 0, 0, 200 ) )
					dxDrawText( getElementData( players[ i ], "nick" ) or "Не авторизован", (posX/2)-40, posY, 50, posY + r_height , tocolor( 255, 255, 255, 255 ), 1, font_montregular, "center", "center" )
							
					dxDrawText( getElementData( players[ i ], "id" ),s_width+25, posY, 50, posY + r_height , tocolor( 255, 255, 255, 255 ), 1, font_montregular, "center", "center" )
					offsetY = offsetY + r_height
					
				end
				
				if ( width ~= _width ) then
				
					local vRatio = height / c_height
					local s_height = height * vRatio
					local scrollY = ( vRatio * scrollCache ) + 5
					local isHover = isCursorOnElement( posX + _width, posY + scrollY + h_height, s_width, s_height - 10 )
					local r, g, b = interpolateBetween( 42, 93, 132, 22, 73, 112, scrollColor, "Linear" )
					scrollColor = math.min( math.max( isScrollActive and scrollColor + 0.1 or scrollColor - 0.1, 0 ), 1 )
					_dxDrawRectangle( _width, 5, s_width, height - 10, 10, tocolor( 0, 0, 0, 200 ) )
					_dxDrawRectangle( _width, scrollY, s_width, s_height - 10, 10, tocolor( r, g, b, 255 ) )
					
					if ( isHover and getKeyState( "mouse1" ) ) then isScrollActive = not isScrollActive and cursorY( ) - scrollY + 5 or isScrollActive elseif ( not getKeyState( "mouse1" ) ) then isScrollActive = nil end
					
					if ( isScrollActive ) then
						
						scrollCache = math.min( math.max( ( cursorY( ) - isScrollActive ) / vRatio, 0 ), c_height - height )
						
					end
					
				end
				
			dxSetRenderTarget( )
			dxDrawImage( posX, posY + h_height, width, height, renderTarget, 0, 0, 0, tocolor( 255, 255, 255, 255 ), true )
			
		end
		showCursor( getKeyState( "mouse2" ) )
	end
end
addEventHandler("onClientRender",root,dxDrawTabList)

function updatePlayers()
	triggerServerEvent("onClientGetsPlayers",lp)
end
addEventHandler("onClientPlayerJoin",root,updatePlayers)
addEventHandler("onClientResourceStart",root,updatePlayers)

function onReturnsPlayers(ids,max)
	players = ids
	maxplayers = maxplayers
end
addEvent("onReturnPlayers",true)
addEventHandler("onReturnPlayers",root,onReturnsPlayers)

addEventHandler( "onClientPlayerQuit", root, function( )
	scrollCache = math.min( scrollCache, getPlayerCount() * r_height ) 
	updatePlayers()
end)

function onTabKey(key)
	local c_height = getPlayerCount() * r_height
	if ( getKeyState( "TAB" ) and ( c_height > height ) ) then
		if ( key == "mouse_wheel_up" ) then
			scrollCache = math.max( scrollCache - r_height, 0 )
		elseif ( key == "mouse_wheel_down" ) then
			scrollCache = math.min( scrollCache + r_height, c_height - height )
		end
	end
end
addEventHandler( "onClientKey", root,onTabKey)
