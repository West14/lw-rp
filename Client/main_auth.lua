local loginTexture = dxCreateRoundedTexture(screenW * 0.3542, screenH * 0.1756, screenW * 0.2917, screenH * 0.6500, 10, "Images/mask.png")

local authButtonActive = dxCreateRoundedTexture(screenW * 0.3785, screenH * 0.6800, screenW * 0.1104, screenH * 0.0578,10, "Images/btn-active.png")
local authButtonInActive = dxCreateRoundedTexture(screenW * 0.3785, screenH * 0.6800, screenW * 0.1104, screenH * 0.0578,10, "Images/btn-inactive.png")

local CheckboxActive = dxCreateRoundedTexture(0,0, 13,13,2, "Images/checkbox-active.png")
local CheckboxInActive = dxCreateRoundedTexture(0, 0, 13, 13,2, "Images/checkbox-inactive.png")

local iconsuccess = dxCreateRoundedTexture(0,0,13,13,2,"Images/mask-success.png")
local iconerror = dxCreateRoundedTexture(0,0,13,13,2,"Images/mask-error.png")

local createBgIcon = dxCreateTexture("Images/createperson-bg.png")

local addicon = dxCreateRoundedTexture(0,0,26,26,2,"Images/mask-add.png")

local logBtn = DGS:dgsCreateButton( 0.3785, 0.6800, 0.1104, 0.0578, "ВОЙТИ", true, false, color, 1, 1, authButtonInActive, authButtonActive, authButtonActive  )
local regBtn = DGS:dgsCreateButton( 0.5111, 0.6800, 0.1104, 0.0578, "РЕГИСТРАЦИЯ", true, false, color, 1, 1, authButtonInActive, authButtonActive, authButtonActive )

local logEdit = DGS:dgsCreateEdit(0.3826,0.4878,0.2292,0.0322,"",true,nil,tocolor(234,234,234),1,1,nil,tocolor(0,0,0,0))
local passEdit = DGS:dgsCreateEdit(0.3826,0.6022,0.2292,0.0322,"",true,nil,tocolor(234,234,234),1,1,nil,tocolor(0,0,0,0))
local emailEdit = DGS:dgsCreateEdit(0.3722,0.6356,0.2542,0.0378,"",true,nil,tocolor(234,234,234),1,1,nil,tocolor(0,0,0,0))

local lastChangeText = 0
local remember_checkbox = false
avatar = dxCreateTexture("Images/davatar.jpg")
regavatar = dxMaskTexture(avatar, "Images/avatar-mask.png")
avatar = dxMaskTexture(avatar, "Images/avatar-mask.png")
playerCharacters = {}
playerCharactersYpos = {}
selectGender = 'Мужской'
characterSkins = {
	['Мужской'] = {
		[1] = 250,
		[2] = 259,
		[3] = 170
	},
	['Женский'] = {
		[1] = 225,
		[2] = 263
	}
}

characterSpawns = {
	[1] = {'Монгомери'},
	[2] = {'Ещё какая-нибудь хуета'}
}

function onResStart(  )
	showCursor(true)
	changeWindow("menu")
	DGS:dgsSetFont(logBtn,font_montmediumL)
	setPlayerHudComponentVisible("radar",false)
	setPlayerHudComponentVisible("area_name",false)
	DGS:dgsSetFont(regBtn,font_montmediumL)
	DGS:dgsSetFont(logEdit,"default")
	DGS:dgsEditSetMasked ( passEdit, true )
	DGS:dgsSetFont(passEdit,"default")
	DGS:dgsSetProperty(logBtn,"textColor",guiColor)
	DGS:dgsSetProperty(regBtn,"textColor",guiColor)
	requestBrowserDomains({"forum.lw-rp.tk"})
	fadeCamera(true)
	setCameraTarget(lp)
	setCameraMatrix(-369.0126953125, -1541.95703125,36.245861053467,-333.9208984375,-1448.4169921875,31.908327102661)
	setTimer(checkAvatar,1000,0)
end
addEventHandler( "onClientResourceStart", getRootElement(), onResStart )

function checkAvatar()
	if lastChangeText > 0 then
		if getTickCount()-lastChangeText > 500 then
			getForumAvatar(DGS:dgsGetText(logEdit))
			lastChangeText = 0
		end
	end
end

function renderLogInPanel( )
	Blur.render()
	dxDrawImage( screenW * 0.3507, screenH * 0.1811, screenW * 0.2993, screenH * 0.6378, loginTexture )
	if activewindow == "menu" then
		dxDrawImage(screenW * 0.3715, screenH * 0.2922, screenW * 0.2583, screenH * 0.2789, "Images/auth-logo.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		DGS:dgsSetVisible(logBtn,true)
		DGS:dgsSetVisible(regBtn,true)
	elseif activewindow == "login" then
		dxDrawText("ЛОГИН", screenW * 0.3826, screenH * 0.4678, screenW * 0.4542, screenH * 0.4922, tocolor(255, 255, 255, 255), 1.00, font_montregular)
        dxDrawText("ПАРОЛЬ", screenW * 0.3826, screenH * 0.5789, screenW * 0.4542, screenH * 0.6033, tocolor(255, 255, 255, 255), 1.00, font_montregular)

		dxDrawText("<", screenW * 0.6035, screenH * 0.1922, screenW * 0.6340, screenH * 0.2200, tocolor(255, 255, 255, 255), 1.00, "clear", "center", "center")
		dxDrawRectangle(screenW * 0.3826, screenH * 0.5200, screenW * 0.2292, screenH * 0.0022, guiColor, true)
		dxDrawRectangle(screenW * 0.3826, screenH * 0.6344, screenW * 0.2292, screenH * 0.0022, guiColor, true)
		if remember_checkbox then
			dxDrawImage(screenW * 0.3819, screenH * 0.6667, screenW * 0.0090, screenH * 0.0144,CheckboxActive)
			dxDrawText("Запомнить логин", screenW * 0.4007, screenH * 0.6667, screenW * 0.4715, screenH * 0.6789, guiColor, 1.00, font_montregular, "right", "center")
		else
			dxDrawImage(screenW * 0.3819, screenH * 0.6667, screenW * 0.0090, screenH * 0.0144,CheckboxInActive)
			dxDrawText("Запомнить логин", screenW * 0.4007, screenH * 0.6667, screenW * 0.4715, screenH * 0.6789, tocolor(234, 234, 234, 255), 1.00, font_montregular, "right", "center")
		end
		if avatar then
			dxDrawImage(screenW * 0.4444, screenH * 0.2556, screenW * 0.0993, screenH * 0.1589,avatar,0,0,0,tocolor(255,255,255,255))
		end
		elseif activewindow == "register" then
		dxDrawImage(screenW * 0.4486, screenH * 0.2367, screenW * 0.0993, screenH * 0.1589, regavatar)
		
		dxDrawText("<", screenW * 0.6035, screenH * 0.1922, screenW * 0.6340, screenH * 0.2200, tocolor(255, 255, 255, 255), 1.00, "clear", "center", "center")
		dxDrawRectangle(screenW * 0.3722, screenH * 0.4989, screenW * 0.2542, screenH * 0.0022, guiColor, true)
		dxDrawRectangle(screenW * 0.3722, screenH * 0.5822, screenW * 0.2542, screenH * 0.0022, guiColor, true)
		dxDrawRectangle(screenW * 0.3722, screenH * 0.6689, screenW * 0.2542, screenH * 0.0022, guiColor, true)

		dxDrawText("ЛОГИН",  screenW * 0.3722, screenH * 0.4478, screenW * 0.4153, screenH * 0.4667, tocolor(255, 255, 255, 255), 1.00, font_montregular, "left", "center")
		dxDrawText("ПАРОЛЬ", screenW * 0.3722, screenH * 0.5333, screenW * 0.4153, screenH * 0.5522, tocolor(255, 255, 255, 255), 1.00, font_montregular, "left", "center")
		dxDrawText("ПОЧТА",  screenW * 0.3722, screenH * 0.6167, screenW * 0.4153, screenH * 0.6356, tocolor(255, 255, 255, 255), 1.00, font_montregular, "left", "center")
		if loginsuccess then
			dxDrawImage(screenW * 0.6062, screenH * 0.4678, 16,16, iconsuccess)
		elseif loginsuccess == false then
			dxDrawImage(screenW * 0.6062, screenH * 0.4678, 16,16, iconerror)
		end
		if passsuccess then
			dxDrawImage(screenW * 0.6062, screenH * 0.5500, 16,16, iconsuccess)
		elseif passsuccess == false then
			dxDrawImage(screenW * 0.6062, screenH * 0.5500, 16,16, iconerror)
		end
		if emailsuccess then
			dxDrawImage(screenW * 0.6062, screenH * 0.6400, 16,16, iconsuccess)
		elseif emailsuccess == false then
			dxDrawImage(screenW * 0.6062, screenH * 0.6400, 16,16, iconerror)
		end
	end
	
end
addEventHandler( "onClientRender", root, renderLogInPanel )

function onEnter(aX,aY)
	DGS:dgsSetAlpha(source,0)
	DGS:dgsAlphaTo(source,255,false,"Linear",500)
	DGS:dgsSetProperty(source,"textColor",tocolor(255,255,255))
	DGS:dgsSetFont(source,font_montmediumB)
end
addEventHandler("onDgsMouseEnter",logBtn,onEnter)
addEventHandler("onDgsMouseEnter",regBtn,onEnter)

function onExit()
	DGS:dgsSetFont(source,font_montmediumL)
	DGS:dgsSetProperty(source,"textColor",guiColor)
end
addEventHandler("onDgsMouseLeave",logBtn,onExit)
addEventHandler("onDgsMouseLeave",regBtn,onExit)

function onClickBtn(btn,state)
	if state == "down" then
		if btn == "left" then
			if source == logBtn then
				if activewindow == "menu" then
					changeWindow("login")
				elseif activewindow == "login" then
					startLogIn()
				else
					startSingUp()
				end
			else 
				changeWindow("register")
			end
		end
	end
end
addEventHandler("onDgsMouseClick",logBtn,onClickBtn)
addEventHandler("onDgsMouseClick",regBtn,onClickBtn)

function onClickLabel(btn,state)
	if state == "down" and btn == "left" then
		if activewindow == "login" or activewindow == "register" then
			if isCursorOverText(screenW * 0.6035, screenH * 0.1922, screenW * 0.6340, screenH * 0.2200) then
				changeWindow("menu")
			elseif isCursorOverText(screenW * 0.3826, screenH * 0.6556, screenW * 0.4715, screenH * 0.6778) then
				remember_checkbox = not(remember_checkbox)
			end	
		end
	end
end
addEventHandler("onClientClick",root,onClickLabel)

function changeWindow(window)
	activewindow = window
	if window == "menu" then
		DGS:dgsSetText(logEdit,"")
		DGS:dgsSetText(passEdit,"")
		DGS:dgsSetVisible(logEdit,false)
		DGS:dgsSetVisible(passEdit,false)
		DGS:dgsSetVisible(emailEdit,false)
		DGS:dgsSetPosition(logBtn,0.3785, 0.6800, 0.1104, 0.0578,true)
		DGS:dgsSetProperty(logBtn,"text","ВОЙТИ")
	elseif window == "login" then
		DGS:dgsSetVisible(logEdit,true)
		DGS:dgsSetVisible(passEdit,true)
		DGS:dgsSetVisible(emailEdit,false)
		DGS:dgsSetPosition(logEdit,0.3826,0.4878,0.2292,0.0322,true)
		DGS:dgsSetPosition(logBtn,0.4479,0.7033,0.1007,0.0544,true)
		DGS:dgsSetPosition(passEdit,0.3826,0.6022,0.2292,0.0322,true)
		DGS:dgsSetVisible(regBtn,false)
	elseif window == "register" then
		DGS:dgsSetVisible(logEdit,true)
		DGS:dgsSetVisible(passEdit,true)
		DGS:dgsSetVisible(emailEdit,true)
		DGS:dgsSetProperty(logBtn,"text","ДАЛЕЕ")

		DGS:dgsSetVisible(logBtn,true)
		DGS:dgsSetVisible(regBtn,false)
		DGS:dgsSetPosition(logBtn,0.4417,0.7011, 0.1118, 0.0456,true)
		DGS:dgsSetPosition(logEdit, 0.3722, 0.4667, 0.2535, 0.0356, true)
		DGS:dgsSetPosition(passEdit, 0.3722, 0.5522, 0.2535, 0.0356,true)
		
	end
end


function getForumAvatar(nick)
	fetchRemote("https://forum.lw-rp.tk/avatar.php?username="..nick,avatarCallback)
end

function avatarCallback(responseData,errno)
	if errno == 0 then
		if responseData ~= "nil" then
			fetchRemote("https://forum.lw-rp.tk"..responseData,function(pixels,errno)
				if errno == 0 then
					avatar = dxCreateTexture(pixels)
					avataralpha = 0
					avatar = dxMaskTexture(avatar, "Images/avatar-mask.png")
				end
			end)
		else
			avatar = dxCreateTexture("Images/davatar.jpg")
			avatar = dxMaskTexture(avatar, "Images/avatar-mask.png")
		end
    end
end

function timerAvatarAdd()
	if activewindow == "login" then
		lastChangeText = getTickCount() / 1000
	end
end
addEventHandler("onDgsTextChange", logEdit, timerAvatarAdd )

function startLogIn(	)
	local nicktext = DGS:dgsGetText(logEdit)
	local passtext = DGS:dgsGetText(passEdit)
	local emailtext = DGS:dgsGetText(emailEdit)
	logoptions = {
		headers = {
			["XF-Api-Key"]="uRDWClUg73pUDRyrAqtS_5WYczuS7lDF",
		},
		method="POST",
		formFields = {
			login = nicktext,
			password = passtext
		},
	}
	fetchRemote("https://forum.lw-rp.tk/api/auth",logoptions,function(responseData,errno)
		responseData = fromJSON(responseData)
		if type(errno) ~= "number" then
			if responseData.success == true then
				setElementData(lp,"forumid",responseData.user.user_id)
				triggerServerEvent("getCharacters",localPlayer,responseData.user.user_id)
				--removeEventHandler("onClientRender",root,renderLogInPanel)
				activewindow = "selectcharacters"
				destroyElement(logEdit)
				destroyElement(passEdit)
				destroyElement(emailEdit)
				destroyElement(logBtn)
				destroyElement(regBtn)
			end
		end
	end)
end

function startSingUp()
	local nicktext = DGS:dgsGetText(logEdit)
	local passtext = DGS:dgsGetText(passEdit)
	local emailtext = DGS:dgsGetText(emailEdit)
	if string.len(nicktext) > 5 then
		loginsuccess = true
	else
		loginsuccess = false
	end
	if emailtext:find("^[%w.]+@%w+%.%w+$") then
		emailsuccess = true
	else
		emailsuccess = false
	end
	if string.len(passtext) > 6 then
		passsuccess = true
	else
		passsuccess = false
	end
	if loginsuccess and passsuccess and emailsuccess then
		triggerServerEvent ( "onPlayerStartSignUp", lp, lp, nicktext, passtext, emailtext )
	end
end

function renderSelectCharacters()
	ypos = screenH * 0.2233
	for i = #playerCharacters,1,-1 do
		dxDrawText(playerCharacters[i].nick, screenW * 0.4542, ypos, screenW * 0.5514, screenH * 0.2467,tocolor(255,255,255),1,1,font_montregular)
		if isMouseInPosition(screenW * 0.4444, ypos, screenW * 0.0847, screenH * 0.0311) then
			dxDrawRoundedRectangle(screenW * 0.5583, ypos+3, screenW * 0.0056, screenH * 0.0089,tocolor(123,168,44),2)
		end
		if isMouseInPosition(screenW * 0.4444, ypos, screenW * 0.0847, screenH * 0.0311) then
			if getElementData(lp,"logged") ~= true then
				if getKeyState("mouse1") then
					removeEventHandler("onClientRender",root,renderSelectCharacters)
					removeEventHandler("onClientRender",root,renderLogInPanel)
					showCursor(false)
					triggerServerEvent("onClientSelectCharacter",lp,playerCharacters[i])
					setElementData(lp, "nick", playerCharacters[i].nick)
					setElementData(lp, "logged", true)
					setElementData(lp, "level", playerCharacters[i].level)
					setElementData(lp, "exp", playerCharacters[i].exp)
					setElementData(lp, "alevel", playerCharacters[i].alevel )
					setElementData(lp, "skin", playerCharacters[i].skin )
					setElementData(lp, "faction", playerCharacters[i].faction )
					setElementData(lp, "leader", playerCharacters[i].leader )
					setElementData(lp, "tableid", playerCharacters[i].id)
					setElementFrozen(lp,false)
					setElementData(lp, "walkstyle", playerCharacters[i].walkstyle )
				end
			end
		elseif isMouseInPosition(screenW * 0.4764, screenH * 0.2233 + 37 * #playerCharacters, screenW * 0.0181, screenH * 0.0289) then
			if getKeyState("mouse1") then
				if not(isEventHandlerAdded("onClientPreRender",root,renderCreateCharacters)) then
					removeEventHandler("onClientRender",root,renderSelectCharacters)
					removeEventHandler("onClientRender",root,renderLogInPanel)
					activewindow = "createcharacter"
					addEventHandler("onClientPreRender",root,renderCreateCharacters)
					setCameraMatrix(-2148.14453125, -2514.9580078125, 31.037450790405, -2227.642578125, -2454.3369140625, 28.776023864746)
					
					skinselect = 1

					skinspawns = 1
					
					roundrotate = 0
					
					skinped = createPed(characterSkins[selectGender][skinselect],-2151.3000488281,-2511.1000976563,30.60000038147,220.001831)
					
					skinaddBtn = DGS:dgsCreateButton( 0.1924, 0.6578, 0.1368, 0.0611, "ВОЙТИ", true, false, guiColor, 1, 1, authButtonInActive, authButtonActive, authButtonActive )
					
					addEventHandler("onDgsMouseEnter",skinaddBtn,onEnter)
					addEventHandler("onDgsMouseLeave",skinaddBtn,onExit)

					DGS:dgsSetFont( skinaddBtn, font_montmediumL )

					
					addEventHandler("onClientKey",root,function(btn,press)
						if press then
							if btn == "mouse1" then
								if isCursorOverText(screenW * 0.3160, screenH * 0.4033, screenW * 0.3229, screenH * 0.4289) or isCursorOverText(screenW * 0.2014, screenH * 0.4011, screenW * 0.2090, screenH * 0.4289) then
									if selectGender == "Мужской" then
										selectGender = "Женский"
										skinselect = 1
										setElementModel(skinped,characterSkins[selectGender][skinselect])
									elseif selectGender == "Женский" then
										selectGender = "Мужской"
										skinselect = 1
										setElementModel(skinped,characterSkins[selectGender][skinselect])
									end
								elseif isCursorOverText(screenW * 0.3153, screenH * 0.3244, screenW * 0.3222, screenH * 0.3500) then
									if skinspawns < #characterSpawns then
										skinspawns = skinspawns + 1
									end
								elseif isCursorOverText(screenW * 0.2007, screenH * 0.3244, screenW * 0.2083, screenH * 0.3522) then
									if skinspawns ~= 1 then
										skinspawns = skinspawns - 1
									end
								elseif isCursorOverText(screenW * 0.3167, screenH * 0.4800, screenW * 0.3236, screenH * 0.5056) then
									if skinselect < #characterSkins[selectGender] then
										skinselect = skinselect + 1
										setElementModel(skinped,characterSkins[selectGender][skinselect])
									end
								elseif isCursorOverText(screenW * 0.2021, screenH * 0.4800, screenW * 0.2097, screenH * 0.5078) then
									if skinselect ~= 1 then
										skinselect = skinselect - 1
										setElementModel(skinped,characterSkins[selectGender][skinselect])
									end
								end
							end
						end
					end)
				end
				
			end
		end
		ypos = ypos + 37
	end
	if #playerCharacters < 3 then
		dxDrawImage(screenW * 0.4764, ypos, screenW * 0.0181, screenH * 0.0289,addicon)
	end
end

function renderCreateCharacters()
	dxDrawImage( screenW * 0.1153, screenH * 0.1822, screenW * 0.2993, screenH * 0.6378, loginTexture, 0, 190, 43 )
	
	dxDrawText("Место появления", screenW * 0.1826, screenH * 0.2844, screenW * 0.3396, screenH * 0.3133, tocolor(255, 255, 255, 255), 1.00, "default", "center", "bottom", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.2160, screenH * 0.3500, screenW * 0.0924, screenH * 0.0022, tocolor(255, 255, 255, 255), false)
    dxDrawText(characterSpawns[skinspawns][1], screenW * 0.2153, screenH * 0.3244, screenW * 0.3083, screenH * 0.3500, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText(">", screenW * 0.3153, screenH * 0.3244, screenW * 0.3222, screenH * 0.3500, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false)
    dxDrawText("<", screenW * 0.2007, screenH * 0.3244, screenW * 0.2083, screenH * 0.3522, tocolor(255, 255, 255, 255), 1.00, "default", "right", "center", false, false, false, false, false)
    dxDrawText("Пол персонажа", screenW * 0.1826, screenH * 0.3611, screenW * 0.3396, screenH * 0.3900, tocolor(255, 255, 255, 255), 1.00, "default", "center", "bottom", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.2167, screenH * 0.4267, screenW * 0.0924, screenH * 0.0022, tocolor(255, 255, 255, 255), false)
    dxDrawText(selectGender, screenW * 0.2160, screenH * 0.4011, screenW * 0.3090, screenH * 0.4267, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText(">", screenW * 0.3160, screenH * 0.4033, screenW * 0.3229, screenH * 0.4289, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false)
    dxDrawText("<", screenW * 0.2014, screenH * 0.4011, screenW * 0.2090, screenH * 0.4289, tocolor(255, 255, 255, 255), 1.00, "default", "right", "center", false, false, false, false, false)
    dxDrawText("Внешний вид", screenW * 0.1854, screenH * 0.4400, screenW * 0.3424, screenH * 0.4689, tocolor(255, 255, 255, 255), 1.00, "default", "center", "bottom", false, false, false, false, false)
    dxDrawText(skinselect, screenW * 0.2167, screenH * 0.4800, screenW * 0.3097, screenH * 0.5056, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText(">", screenW * 0.3167, screenH * 0.4800, screenW * 0.3236, screenH * 0.5056, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, false, false)
    dxDrawText("<", screenW * 0.2021, screenH * 0.4800, screenW * 0.2097, screenH * 0.5078, tocolor(255, 255, 255, 255), 1.00, "default", "right", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.2167, screenH * 0.5056, screenW * 0.0924, screenH * 0.0022, tocolor(255, 255, 255, 255), false)
end

function returnCharacters(result)
	for i = #result,1,-1 do
		playerCharacters[i] = result[i]
	end
	addEventHandler("onClientRender",root,renderSelectCharacters)
end
addEvent("onReturnCharacters",true)
addEventHandler("onReturnCharacters",root,returnCharacters)


function errorSignUp()
	emailsuccess = false
	loginsuccess = false
	outputChatMessage("Никнейм или почта заняты","#990000")
end
addEvent("errorSignUp",true)
addEventHandler("errorSignUp",root,errorSignUp)

function endSingUp()
	removeEventHandler("onClientRender",root,renderLogInPanel)
end
addEvent("endSignUp",true)
addEventHandler("endSignUp",root,endSingUp)