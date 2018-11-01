local chatBox = DGS:dgsCreateEdit(14,269,471,26,"",false,nil,tocolor(255,255,255),1,1,nil,tocolor(0, 0, 0, 255))
DGS:dgsSetVisible(chatBox,false)
DGS:dgsEditSetMaxLength ( chatBox, 62 )
chat_opened = 0
chat_focus = 0
chat_entries = {} 
function openChat( )
	dxDrawRectangle(10, 265, 479, 34, tocolor(55, 55, 55, 255), false)
end


function onPlayerPressKey( btn,press )
	if isLogged(lp) then
		if (press) then
			if btn == "F6" then
					chatCheck()
				end
			else
				if chat_focus == 0 then -- если чат в фокусе(курсор стоит в нём)
					chatCheck()
				end
			end
		end
	end
end

function chatCheck( )
	if chat_opened == 0 then -- если чат не открыт
		addEventHandler("onClientRender",root,openChat) -- отрисовка обводки
		chat_opened = 1 
		DGS:dgsSetVisible(chatBox,true) -- показываем чатбокс
		DGS:dgsBringToFront( chatBox ) -- переместить на передний фон
		DGS:dgsEditSetCaretPosition( chatBox, 1 ) -- установить курсор на 1 символ
		chat_focus = 1
		showCursor(true)
	elseif chat_opened == 1 then -- если чат открыт
		removeEventHandler("onClientRender",root,openChat) -- убираем отрисовку обводки
		chat_opened = 0
		DGS:dgsSetVisible(chatBox,false) -- убираем чатбокс
		showCursor(false)
	end
end

function onPlayerEnterMessage( ... )
	local text = removeHex(DGS:dgsGetText( chatBox )) -- текст из эдитбокса
	local iftext = string.gsub(text,"%s+", "") -- проверка не пустой ли текст без пробелов
	if #iftext > 0 then
		if (text:sub(1,1) == "/") then -- если текст команда
			-- LATER
		else
			triggerServerEvent("sendMessage",lp, "msg",lp, getElementData(lp,"nick").."[ "..getElementData(lp,"id").." ]: "..text)
		end
		clearChatBox()
	end
end

function chat_onDGSFocus() -- фокус чатбокса
	chat_focus = 1
	--outputDebugString("Editbox focused")
end

function chat_onDGSBlur()
	chat_focus = 0
	--outputDebugString("Editbox blured")
end

function outputChatMessage( msg ) -- написать сообщение
	table.insert(chat_messages,"[ "..hours..":"..minutes..":"..seconds.." ] "..msg) -- исёртим сообщение в таблицу
	TextFuel() -- отрисовываем чат
	outputChatBox(msg)
	outputConsole("Chat: "..msg)
end
addEvent("outputChatMessage",true) -- добавляем ивент для триггера с серверной части
addEventHandler("outputChatMessage",root,outputChatMessage) -- добавляем хандлер ивента

function outputError( msg )
	table.insert(chat_messages,"#990000[ "..hours..":"..minutes..":"..seconds.." ] "..msg) -- исёртим сообщение в таблицу
	TextFuel() -- отрисовываем чат
	outputChatBox(msg)
	outputConsole("Chat: "..msg)
end
addEvent("outputError",true) -- добавляем ивент для триггера с серверной части
addEventHandler("outputError",root,outputError) -- добавляем хандлер ивента

function outputSuccess( msg )
	table.insert(chat_messages,"#009900[ "..hours..":"..minutes..":"..seconds.." ] "..msg) -- исёртим сообщение в таблицу
	TextFuel() -- отрисовываем чат
	outputChatBox(msg)
	outputConsole("Chat: "..msg)
end
addEvent("outputSuccess",true) -- добавляем ивент для триггера с серверной части
addEventHandler("outputSuccess",root,outputSuccess) -- добавляем хандлер ивента

function clearChatBox( )
	DGS:dgsSetText ( chatBox, "" ) -- обнуление текста
	DGS:dgsSetVisible(chatBox, false ) -- скрытие эдитбокса
	showCursor (false) -- скрытие курсора
	chat_visible = false -- переменная чата
	removeEventHandler("onClientRender",root,openChat) -- убираем отрисовку обводки
	chat_opened = 0
	chat_focus = 0
end


addEventHandler("onDgsFocus", chatBox, chat_onDGSFocus) --true because for the example we want propagated events
addEventHandler("onDgsBlur", chatBox, chat_onDGSBlur) --true because for the example we want propagated events
addEventHandler( "onDgsEditAccepted", chatBox, onPlayerEnterMessage) -- когда игрок нажал ентер в чатбокс
addEventHandler("onClientKey",root,onPlayerPressKey) -- когда игрок нажал кнопку