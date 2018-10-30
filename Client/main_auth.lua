function onStart( )
	showCursor(true)
	DGS:dgsSetProperty(pass,"masked",true) -- Маскируем эдит для пароля под ******
	addEventHandler ( "onDgsMouseClick", root, onGuiClicked ) -- хадлер клика на меню
	addEventHandler ( "onDgsEditSwitched", login, onClickToEdit ) -- хадлер клика на логин
	addEventHandler ( "onDgsEditSwitched", pass, onClickToEdit ) -- хадлер клика на пароль
	addEventHandler ( "onDgsEditSwitched", login, guiTextClear ) -- хадлер таба на логин
	addEventHandler ( "onDgsEditSwitched", pass, guiTextClear ) -- хадлер таба на пароль
	setCameraMatrix(1677.4501, -1493.8395, 123.0782, 1527.5341,-1778.5883,71.1633)
    fadeCamera(true)
    setBlurLevel(0)
    setPlayerHudComponentVisible("area_name", false)
    setPlayerHudComponentVisible("radar", false)
end
addEventHandler("onClientResourceStart",root,onStart)

function onGuiClicked( btn,state )
	if source == login then
		onClickToEdit(btn,state)
	elseif source == pass then
		onClickToEdit(btn,state)
	elseif source == submit then
		logIn(btn,state)
	elseif source == register then
		signIn(btn,state)
	end
end

function guiTextClear( )
	local text = DGS:dgsGetText( source )
	if text == "Логин" then
		DGS:dgsSetText(source, "")
	elseif text == "Пароль" then
		DGS:dgsSetText(source, "")
	end
end

function logIn( button, state ) -- когда игрок жмет на кнопку "Войти"
	if button == "left" and state == "down" then
		local nick = DGS:dgsGetText( login )
		local pass = DGS:dgsGetText( pass ) 
		if #nick > 1 and #pass > 1 then
			if string.find(nick,"_") then
				triggerServerEvent ( "onPlayerLogIn", lp, lp, nick, teaEncode(pass, encKey))
				setElementData(lp,"logged", true)
			else
				outputError("Неверные данные!")
			end
		end
	end
end

function signIn( button, state ) -- когда игрок жмет на кнопку "Региcтрация"
	if button == "left" and state == "down" then
		local nick = DGS:dgsGetText( login )
		local pass = DGS:dgsGetText( pass ) 
		if #nick > 1 and #pass > 1 then
			if string.find(nick,"_") then
				triggerServerEvent ( "onPlayerSignIn", lp, lp, nick, teaEncode(pass, encKey))
			else
				outputError("Неверный никнейм!")
			end
		else
			outputError("Неверные данные!")
		end
	end
end

function onClickToEdit( button, state ) -- убирает стандартный текст при нажатии
	if button == "left" and state == "down" then
		local text = DGS:dgsGetText( source )
		if text == "Логин" then
			DGS:dgsSetText(source, "")
		elseif text == "Пароль" then
			DGS:dgsSetText(source, "")
		end
	end
end

function onPlayerAuth( ) -- когда игрок авторизовывается
	lpName = getElementData(lp,"nick")
	DGS:dgsSetVisible ( login, false )
	DGS:dgsSetVisible ( pass, false )
	DGS:dgsSetVisible ( submit, false )
	DGS:dgsSetVisible ( register, false )
	setPlayerHudComponentVisible("radar", true)
end
addEvent("onPlayerAuth",true)
addEventHandler("onPlayerAuth", root, onPlayerAuth)

function registerMenu()
	dxDrawRectangle(1121, 231, 309, 233, tocolor(0, 0, 0, 165), false)
    dxDrawRectangle(1126, 344, 142, 35, tocolor(0, 0, 0, 255), true)
    dxDrawRectangle(1123, 231, 307, 22, tocolor(25, 25, 25, 255), false)
    dxDrawText("Регистрация персонажа", 1123, 231, 1430, 253, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
   	dxDrawText("Пол персонажа:", 1128, 269, 1229, 292, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, true, false, false)
    dxDrawText("Выбор скина:", 1123, 312, 1430, 336, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, true, true, false)
    dxDrawRectangle(1128, 344, 142, 35, tocolor(0, 0, 0, 255), true)
    dxDrawText("Предыдущий", 1128, 344, 1268, 377, tocolor(192, 192, 192, 255), 1.00, "default", "center", "center", false, false, true, true, false)
    dxDrawRectangle(1278, 344, 142, 35, tocolor(0, 0, 0, 255), true)
    dxDrawText("Следущий", 1278, 345, 1418, 378, tocolor(192, 192, 192, 255), 1.00, "default", "center", "center", false, false, true, true, false)
    dxDrawRectangle(1133, 398, 280, 38, tocolor(17, 0, 0, 255), true)
    dxDrawText("Далее", 1134, 399, 1413, 436, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, true, false)
end

function registerClick( button, state, absoluteX, absoluteY )
	if source == registered.button[1] then -- кнопка предыдущий
		selectedSkin = selectedSkin -1 -- уменьшение выбор
		if selectedSkin <= 0 then -- если выбранный скин равен или меньше нуля
			if selectedgender == 1 then
				selectedSkin = #male_register_skins -- выбранный скин = конец массива со скинами
			elseif selectedgender == 2 then
				selectedSkin = #female_register_skins -- выбранный скин = конец массива со скинами
			end
		end
		--outputDebugString(selectedSkin) -- дебаг выбранного скина
		setSkin( lp, selectedSkin ) -- функция смены скина персонажа
	elseif source == registered.button[2] then -- следующий
		selectedSkin = selectedSkin + 1 -- увеличение выбора
		if selectedgender == 1 then
			if selectedSkin > #male_register_skins then -- если выбор больше массива
				selectedSkin = 1 -- выбранный скин = 1
			end
		elseif selectedgender == 2 then
			if selectedSkin > #female_register_skins then -- если выбор больше массива
				selectedSkin = 1 -- выбранный скин = 1
			end
		end
		setSkin( lp, selectedSkin ) -- сет скина
		--outputDebugString(selectedSkin) --дебаг
	elseif source == registered.button[3] then -- далее
		selectSkin()
	elseif source == registered.radiobutton[2] then
		selectedgender = 1
		selectedSkin = 1
		setElementModel(lp,male_register_skins[1])
	elseif source == registered.radiobutton[1] then
		selectedgender = 2
		selectedSkin = 1
		setElementModel(lp,female_register_skins[1])
	end
end


function setSkins() -- смена скина при реге
	selectedSkin = 1
	selectedgender = 1
	setElementModel(lp, male_register_skins[selectedSkin])
	addEventHandler("onClientRender",root,rotatePed)
	outputChatMessage("Выберите ваш будущий скин. Вращение: стрелочка влево, стрелочка вправо.")

	addEventHandler("onClientRender",root,registerMenu)
	addEventHandler("onClientGUIClick",registered.button[1],registerClick)
	addEventHandler("onClientGUIClick",registered.button[2],registerClick)
	addEventHandler("onClientGUIClick",registered.button[3],registerClick)
	addEventHandler("onClientGUIClick",registered.radiobutton[1],registerClick)
	addEventHandler("onClientGUIClick",registered.radiobutton[2],registerClick)

	guiSetVisible( registered.button[1], true)
	guiSetVisible( registered.button[2], true)
	guiSetVisible( registered.button[3], true)
	guiSetVisible( registered.button[3], true)

	guiSetVisible( registered.radiobutton[1], true)
	guiSetVisible( registered.radiobutton[2], true)
end
addEvent("setSkin",true)
addEventHandler("setSkin", root, setSkins)

function rotatePed()
	local rotX, rotY, rotZ = getElementRotation(localPlayer) -- get the local players's rotation
	if getKeyState("arrow_l") then
    	setElementRotation(localPlayer,0,0,rotZ-1,"default",true) -- turn the player 1 degrees
	elseif getKeyState("arrow_r") then
    	setElementRotation(localPlayer,0,0,rotZ+1,"default",true) -- turn the player 1 degrees
	end
end


function setSkin( lp, skin ) -- функция сета скина
	if selectedgender == 1 then
		setElementModel(lp, male_register_skins[skin])
	elseif selectedgender == 2 then
		setElementModel(lp, female_register_skins[skin])
	end
end

function selectSkin( ) -- выбор скина
	showCursor(false)
	
	setElementData(lp, "gender",selectedgender)
	if selectedgender == 1 then
		setElementData(lp,"skin",male_register_skins[selectedSkin])
	elseif selectedgender == 2 then
		setElementData(lp,"skin",female_register_skins[selectedSkin])
	end
	triggerServerEvent("addDataToDataBase",lp,getElementData(lp,"nick"),'skin',getElementData(lp,"skin"))
	
	triggerServerEvent("addDataToDataBase",lp,getElementData(lp,"nick"),'gender',selectedgender)
	setElementData(lp, "logged", true)
	removeEventHandler("onClientRender",root,registerMenu)

	removeEventHandler("onClientGUIClick",registered.button[1],registerClick)
	removeEventHandler("onClientGUIClick",registered.button[2],registerClick)
	removeEventHandler("onClientGUIClick",registered.button[3],registerClick)
	removeEventHandler("onClientGUIClick",registered.radiobutton[1],registerClick)
	removeEventHandler("onClientGUIClick",registered.radiobutton[2],registerClick)

	guiSetVisible( registered.button[1], false)
	guiSetVisible( registered.button[2], false)
	guiSetVisible( registered.button[3], false)
	guiSetVisible( registered.button[3], false)

	guiSetVisible( registered.radiobutton[1], false)
	guiSetVisible( registered.radiobutton[2], false)

	showCursor(false)
	triggerServerEvent("onClientEndRegister",root,lp,getElementData(lp,"skin"))
end