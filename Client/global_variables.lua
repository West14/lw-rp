--[[	
	ФАЙЛ СОЗДАН ДЛЯ ТОГО, ЧТОБЫ СКИДЫВАТЬ СЮДА ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ КЛИЕНТСКОЙ ЧАСТИ.
--]]

screenW, screenH = guiGetScreenSize() -- get player`s screen size
global_rendertarget = dxCreateRenderTarget( screenW, screenH, true )
api_key = "uRDWClUg73pUDRyrAqtS_5WYczuS7lDF"
DGS = exports.dgs -- exports from dgs
lp = getLocalPlayer() -- локальный игрок
clp = getCamera()
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

font_montmediumL = dxCreateFont("Fonts/Montserrat-Medium.ttf",10)
font_montmediumB = dxCreateFont("Fonts/Montserrat-Medium.ttf",10,true)

font_montregular = dxCreateFont("Fonts/Montserrat-Regular.ttf",10)

font_montlight = dxCreateFont("Fonts/Poppins-ExtraLight.ttf",9)

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

function dxDrawImage3D( x, y, z, width, height, material, color, rotation, ... )
    return dxDrawMaterialLine3D( x, y, z, x + width, y + height, z + tonumber( rotation or 0 ), material, height, color or 0xFFFFFFFF, ... )
end
