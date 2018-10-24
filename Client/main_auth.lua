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
				 triggerServerEvent ( "onPlayerLogIn", lp, lp, nick, pass )
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
				triggerServerEvent ( "onPlayerSignIn", lp, lp, nick, pass )
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
end
addEvent("onPlayerAuth",true)
addEventHandler("onPlayerAuth", root, onPlayerAuth)