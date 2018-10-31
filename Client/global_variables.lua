--[[	
	ФАЙЛ СОЗДАН ДЛЯ ТОГО, ЧТОБЫ СКИДЫВАТЬ СЮДА ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ КЛИЕНТСКОЙ ЧАСТИ.
--]]


encKey = "c3CKcjgKDGiVfyN8"
screenW, screenH = guiGetScreenSize() -- get player`s screen size
DGS = exports.dgs -- exports from dgs
lp = getLocalPlayer() -- локальный игрок
chat_messages = {} -- сообщения чата
registered = {
    button = {},
    radiobutton = {}
}
yposition = 225
showChat(false)
-- регистрация и авторизация
editWidth = 400
editHeight = 35
login = DGS:dgsCreateEdit( (screenW - editWidth) / 2, (screenH - editHeight ) / 2 - 35, editWidth, editHeight, "Логин", false, false, tocolor(0,0,0,255),1,1,false,tocolor(109, 118, 120) )
pass = DGS:dgsCreateEdit( (screenW - editWidth) / 2, (screenH - editHeight ) / 2 + 35, editWidth, editHeight, "Пароль", false, false, tocolor(0,0,0,255),1,1,false,tocolor(109, 118, 120) )
submit = DGS:dgsCreateButton( (screenW - editWidth) / 2, (screenH - editHeight ) / 2 + 75, editWidth, editHeight, "Авторизация", false )
register = DGS:dgsCreateButton( (screenW - editWidth) / 2, (screenH - editHeight ) / 2 + 115, editWidth, editHeight, "Регистрация", false )
male_register_skins = {
	[1] = 47,
	[2] = 98,
	[3] = 46,
	[4] = 60
}

female_register_skins = {
	[1] = 11,
	[2] = 12,
	[3] = 40,
	[4] = 69
}

registered.button[1] = guiCreateButton(1128, 346, 140, 33, "Влево", false) 
registered.button[2] = guiCreateButton(1279, 345, 141, 34, "Вправо", false)
registered.button[3] = guiCreateButton(1133, 400, 280, 36, "Готово", false)
registered.radiobutton[1] = guiCreateRadioButton(1326, 269, 97, 23, "Женский", false)
guiSetFont(registered.radiobutton[1], "default-bold-small")
registered.radiobutton[2] = guiCreateRadioButton(1229, 269, 97, 23, "Мужской", false)
guiSetFont(registered.radiobutton[2], "default-bold-small")
guiSetProperty(registered.radiobutton[2], "NormalTextColour", "FFFBFCFE")
guiRadioButtonSetSelected(registered.radiobutton[2], true)    

guiSetVisible( registered.button[1], false)
guiSetVisible( registered.button[2], false)
guiSetVisible( registered.button[3], false)
guiSetVisible( registered.button[3], false)

guiSetVisible( registered.radiobutton[1], false)
guiSetVisible( registered.radiobutton[2], false)

function timestamp( )
	time = getRealTime()
	hours = time.hour
	minutes = time.minute
	seconds = time.second
	setTime(hours, minutes) -- реальное время на сервере
	if hours <= 9 then -- если час меньше двухзначного числа, то автоматически добавляется ноль в начале
		hours = "0"..hours
	end
	if minutes <= 9 then -- такая же ситуация, как и с часами
		minutes = "0"..minutes
	end
	if seconds <= 9 then -- такая же ситуация, как и с часами
		seconds = "0"..seconds
	end
	if minutes == "00" and seconds == "00" then
		triggerServerEvent("onPayDay",lp)
	end
end
addEventHandler("onClientRender",root,timestamp)
