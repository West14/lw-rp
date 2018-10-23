function onStart( )
	showCursor(true)
	DGS:dgsSetProperty(pass,"masked",true) -- Маскируем эдит для пароля под ******
	addEventHandler ( "onDgsMouseClick", root, onGuiClicked ) -- хадлер клика на логин
	addEventHandler ( "onDgsEditSwitched", login, onClickToEdit ) -- хадлер клика на логин
	addEventHandler ( "onDgsEditSwitched", pass, onClickToEdit ) -- хадлер клика на логин
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

function logIn( button, state ) -- когда игрок жмет на кнопку "Войти"
	if button == "left" and state == "down" then
		local nick = DGS:dgsGetText( login )
		local pass = DGS:dgsGetText( pass ) 
		if #nick > 1 and #pass > 1 then
			if string.find(nick,"_") then
				 triggerServerEvent ( "onPlayerLogIn", resourceRoot, lp, nick, pass )
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
				triggerServerEvent ( "onPlayerSignIn", resourceRoot, lp, nick, pass )
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