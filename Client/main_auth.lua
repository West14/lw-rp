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
				outputChatBox("Неверные данные!")
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
				outputChatBox("Неверный никнейм!")
			end
		else
			outputChatBox("Неверные данные!")
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


function setPlayerSkin() -- смена скина при реге
	selectedSkin = 1
	setElementModel(lp, register_skins[selectedSkin])
	bindKey("arrow_l","down",changeSkin,selectedSkin)
	bindKey("arrow_r","down",changeSkin,selectedSkin)
	bindKey("enter","down",selectSkin,selectedSkin)
	outputChatMessage("Выберите ваш будущий скин. Управление: стрелочка влево, стрелочка вправо.")
	outputChatMessage("Чтобы выбрать скин нажмите Enter.")
end
addEvent("setPlayerSkin",true)
addEventHandler("setPlayerSkin", root, setPlayerSkin)

function changeSkin( key,state ) -- выбор скина
	if key ==  "arrow_l" then -- если нажал стрелочку влево
		selectedSkin = selectedSkin -1 -- уменьшение выбор
		if selectedSkin <= 0 then -- если выбранный скин равен или меньше нуля
			selectedSkin = #register_skins -- выбранный скин = конец массива со скинами
		end
		--outputDebugString(selectedSkin) -- дебаг выбранного скина
		setSkin( lp, selectedSkin ) -- функция смены скина персонажа
	elseif key == "arrow_r" then -- если нажал стрелку вправо
		selectedSkin = selectedSkin + 1 -- увеличение выбора
		if selectedSkin >= #register_skins then -- если выбор равен или больше массива
			selectedSkin = 1 -- выбранный скин = 1
		end
		setSkin( lp, selectedSkin ) -- сет скина
		--outputDebugString(selectedSkin) --дебаг
	end
end

function setSkin( lp, skin ) -- функция сета скина
	setElementModel(lp, register_skins[skin])
end

function selectSkin( btn, state,selectedSkin ) -- выбор скина
	unbindKey("arrow_l","down",changeSkin)
	unbindKey("arrow_r","down",changeSkin)
	showCursor(false)
	setElementData(lp,"skin",selectedSkin)
	triggerServerEvent("addDataToDataBase",lp,getElementData(lp,"nick"),'skin',register_skins[selectedSkin])
end