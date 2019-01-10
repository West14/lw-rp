local chatBox = DGS:dgsCreateEdit(14,269,471,26,"",false,nil,tocolor(255,255,255),1,1,nil,tocolor(0, 0, 0, 255))
DGS:dgsSetVisible(chatBox,false)
DGS:dgsEditSetMaxLength ( chatBox, 62 )
chat_opened = 0
chat_focus = 0
chat_mouse = 0
chat_entries = {} 
chat_index = 0
chat_index = 0
function openChat( )
	dxDrawRectangle(10, 265, 479, 34, tocolor(55, 55, 55, 255), false)
end


function onPlayerPressKey( btn,press )
	if isLogged(lp) then
		if hud_visible then
			if (press) then
				if btn == "F6" then
					chatCheck()
				elseif btn == "Y" then
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
		alpha = 0
	elseif chat_opened == 1 then -- если чат открыт
		removeEventHandler("onClientRender",root,openChat) -- убираем отрисовку обводки
		chat_opened = 0
		DGS:dgsSetVisible(chatBox,false) -- убираем чатбокс
		showCursor(false)
	end
end

function onPlayerEnterMessage( )
	local text = removeHex(DGS:dgsGetText( chatBox )) -- текст из эдитбокса
	local iftext = string.gsub(text,"%s+", "") -- проверка не пустой ли текст без пробелов
	if string.len(iftext) > 0 then
		if (text:sub(1,1) == "/") then -- если текст команда
			local cmd = split(text:sub(2), " ")
			triggerServerEvent("sendCommand", lp, cmd)
		else

			triggerServerEvent("sendMessage",lp,lp,15,nil, getElementData(lp,"nick")..": "..text)
		end
		clearChatBox()
	else
		removeEventHandler("onClientRender",root,openChat) -- убираем отрисовку обводки
		chat_opened = 0
		DGS:dgsSetVisible(chatBox,false) -- убираем чатбокс
		showCursor(false)
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

function outputChatMessage( msg, hexColor ) -- написать сообщение
	if hexColor == nil then
		hexColor = "#FFFFFF"
	end
	table.insert(chat_messages,hexColor .. "[ "..hours..":"..minutes..":"..seconds.." ] "..msg) -- исёртим сообщение в таблицу
	TextFuel() -- отрисовываем чат
	chat_index = chat_index + 1
end
addEvent("outputChatMessage",true) -- добавляем ивент для триггера с серверной части
addEventHandler("outputChatMessage",root,outputChatMessage) -- добавляем хандлер ивента

function outputAdminChatMessage( msgNick, msg )
	local message = ""
	for i, theMsg in pairs(msg) do
		message = message.." "..theMsg
	end
	outputChatMessage("[ Admin Chat ]: "..msgNick..message,"#ADFF2F")
end
addEvent( "outputAdminChatMessage",true)
addEventHandler( "outputAdminChatMessage", root, outputAdminChatMessage)


function clearChatBox( )
	DGS:dgsSetText ( chatBox, "" ) -- обнуление текста
	DGS:dgsSetVisible(chatBox, false ) -- скрытие эдитбокса
	showCursor (false) -- скрытие курсора
	removeEventHandler("onClientRender",root,openChat) -- убираем отрисовку обводки
	chat_opened = 0
	chat_focus = 0	
end


addEventHandler("onDgsFocus", chatBox, chat_onDGSFocus) --true because for the example we want propagated events
addEventHandler("onDgsBlur", chatBox, chat_onDGSBlur) --true because for the example we want propagated events
addEventHandler( "onDgsEditAccepted", chatBox, onPlayerEnterMessage) -- когда игрок нажал ентер в чатбокс
addEventHandler("onClientKey",root,onPlayerPressKey) -- когда игрок нажал кнопку