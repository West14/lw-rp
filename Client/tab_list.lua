local tablistRT = dxCreateRenderTarget(screenW, screenH, true)
local players = getElementsByType("player")
local tablist_opened = false

function showTabList()
	if tablist_opened then
		dxDrawImage(0, 0, screenW, screenH, tablistRT)
	end
end

function renderTabList()
	ypos = screenH * 0.2822 
	dxSetRenderTarget(tablistRT)
	dxDrawRectangle(screenW * 0.3476, screenH * 0.2362, screenW * 0.3054, screenH * 0.5286, tocolor(79, 79, 79, 255), false)
	dxDrawRectangle(screenW * 0.3476,screenH * 0.2362,screenW * 0.3049,screenH * 0.0356, tocolor(11, 11, 11, 255), false)
	dxDrawText("Jabka RP | Online:"..getPlayerCount().."/500", screenW * 0.3480, screenH * 0.2367, screenW * 0.6500, screenH * 0.2667,tocolor(255,255,255),1,"default","center","center")
	for k,v in ipairs(players) do
		if getElementData(v,"logged") then
			dxDrawText("[ "..getElementData(v,"id").." ] "..getElementData(v,"nick"), screenW * 0.3499, ypos, screenW * 0.6528, screenH * 0.3022)
		else
			dxDrawText("Не авторизован", screenW * 0.3499, ypos, screenW * 0.6528, screenH * 0.3022)
		end
		ypos = ypos+12
	end
	dxSetRenderTarget()
end

function handleTabList(button, press)
	if isLogged(lp) then
		if button == 'tab' then
			if press then
				renderTabList()
				tablist_opened = true
			elseif not(press) then
				tablist_opened = false
			end
		end
	end
end

addEventHandler("onClientKey", getRootElement(), handleTabList)
addEventHandler("onClientRender", getRootElement(), showTabList)