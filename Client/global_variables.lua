--[[	
	ФАЙЛ СОЗДАН ДЛЯ ТОГО, ЧТОБЫ СКИДЫВАТЬ СЮДА ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ КЛИЕНТСКОЙ ЧАСТИ.
--]]


encKey = "c3CKcjgKDGiVfyN8"
screenW, screenH = guiGetScreenSize() -- get player`s screen size
global_rendertarget = dxCreateRenderTarget( screenW, screenH, true )
DGS = exports.dgs -- exports from dgs
lp = getLocalPlayer() -- локальный игрок
chat_messages = {} -- сообщения чата
registered = {
    button = {},
    radiobutton = {}
}
yposition = 225
yposition_new = 0 
yposition_max = 0
showChat(false)
-- регистрация и авторизация
editWidth = 400
editHeight = 35
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

function timestamp( )
	time = getRealTime()
	hours = time.hour
	minutes = time.minute
	seconds = time.second

	if hours <= 9 then -- если час меньше двухзначного числа, то автоматически добавляется ноль в начале
		hours = "0"..hours
	end
	if minutes <= 9 then -- такая же ситуация, как и с часами
		minutes = "0"..minutes
	end
	if seconds <= 9 then -- такая же ситуация, как и с часами
		seconds = "0"..seconds
	end
end
addEventHandler("onClientRender",root,timestamp)