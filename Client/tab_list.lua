local tabRenderTarget = dxCreateRenderTarget( screenW, screenH, true )
local tabShadowBtn = dxCreateRoundedTexture(0,0, 256, 256,10,"Images/mask-btnshadow.png")
local maxplayers = 500
players = {}

--[[503, 227, 16, 21]]

function dxDrawTabList()
	if isLogged(lp) then
		if ( getKeyState( "TAB" ) ) then
			local x,y,z = getElementPosition(lp)
			ypos = screenH * (268/sY)
			count = 0
			dxDrawRectangle(screenW * (472/sX), screenH * (212/sY), 517, 56, tocolor(57, 139, 31, 255), false)
			dxDrawRectangle(screenW * (472/sX), screenH * (268/sY), 517, 464, tocolor(0, 0, 0, 154), false)
			dxDrawImage(screenW * (482/sX), screenH * (143/sY), 188, 192, tabShadowBtn, 0, 0, 0, tocolor(255, 255, 255, 255))
			dxDrawImage(screenW * (848/sX), screenH * (143/sY), 112, 192, tabShadowBtn, 0, 0, 0, tocolor(255, 255, 255, 255))
			dxDrawText(getZoneName(x,y,z), screenW * (483/sX), screenH * (222/sY), 668, 253, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center")
			for i,player in pairs(players) do
				if getElementData(player,"logged") then
					local id = tostring(getElementData(player,"id"))
					dxDrawText(id.." "..getElementData(player,"nick"), screenW * (473/sX), ypos, 990, 297, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center")
				else	
					local id = tostring(getElementData(player,"id"))
					dxDrawText(tostring(getElementData(player,"id")).." "..getElementData(player,"nick"), screenW * (473/sX), ypos, 990, 297, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center")
				end
				count = count + 1
				ypos = ypos + 37
			end
			dxDrawText(count.."/"..maxplayers, screenW * (847/sX), screenH * (222/sY), 960, 254, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center")
		end
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
	--scrollCache = math.min( scrollCache, getPlayerCount() * r_height ) 
	updatePlayers()
end)

function test()
	setElementData(lp,"id",2)
end
addCommandHandler("testt",test)
