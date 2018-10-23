--[[	
	ФАЙЛ СОЗДАН ДЛЯ ТОГО, ЧТОБЫ СКИДЫВАТЬ СЮДА ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ КЛИЕНТСКОЙ ЧАСТИ.
--]]

screenW, screenH = guiGetScreenSize() -- get player`s screen size
DGS = exports.dgs -- exports from dgs
-- регистрация и авторизация
login = DGS:dgsCreateEdit( (screenW - editWidth) / 2, (screenH - editHeight ) / 2 - 35, editWidth, editHeight, "Логин", false, false, tocolor(0,0,0,255),1,1,false,tocolor(109, 118, 120) )
pass = DGS:dgsCreateEdit( (screenW - editWidth) / 2, (screenH - editHeight ) / 2 + 35, editWidth, editHeight, "Пароль", false, false, tocolor(0,0,0,255),1,1,false,tocolor(109, 118, 120) )
submit = DGS:dgsCreateButton( (screenW - editWidth) / 2, (screenH - editHeight ) / 2 + 75, editWidth, editHeight, "Авторизация", false )
register = DGS:dgsCreateButton( (screenW - editWidth) / 2, (screenH - editHeight ) / 2 + 115, editWidth, editHeight, "Регистрация", false )