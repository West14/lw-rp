local tablistRT = dxCreateRenderTarget(screenW, screenH, true)

local players = getElementsByType('player')

local tablist_opened = false

function showTabList()
	if tablist_opened then
		dxDrawImage(screenW * 0.3476, screenH * 0.2362, screenW * 1, screenH * 1, tablistRT)
	end
end

function renderTabList()
	dxSetRenderTarget(tablistRT)
	dxDrawRectangle(screenW * 0.3476, screenH * 0.2362, screenW * 0.3054, screenH * 0.5286, tocolor(148, 185, 69, 255), false)
	for i,player in ipairs(players) do
		dxDrawRectangle(screenW * 0.3476, (screenH * 0.2362)*i, screenW * 0.3054, screenH * 0.0219, tocolor(255, 255, 255, 255), false)
		dxDrawText(1, (screenW * 0.3476)*i, screenH * 0.2410, screenW * 0.3631, screenH * 0.2533, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, false, false, false)
        if getElementData(player, 'logged') then
        	dxDrawText(getElementData(player, 'nick'), (screenW * 0.3815)*i, screenH * 0.2410, screenW * 0.4863, screenH * 0.2533, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, false, false, false)
		else 
			dxDrawText('Не авторизован(а)', (screenW * 0.3815)*i, screenH * 0.2410, screenW * 0.4863, screenH * 0.2533, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, false, false, false)
		end
	end
	dxSetRenderTarget()
end


function handleTabList(button, press)
	if button == 'tab' then
		if press then
			renderTabList()
			tablist_opened = true
		elseif not(press) then
			tablist_opened = false
		end
	end
end

addEventHandler("onClientKey", getRootElement(), handleTabList)
addEventHandler("onClientRender", getRootElement(), renderTabList)