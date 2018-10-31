local renderMainTarget = dxCreateRenderTarget(700,250,true) --рендертаргет

function dxDrawBorderedText( text,xposit,yposit,zposit,top ) -- ИСПОЛЬЗОВАТЬ ТОЛЬКО С РЕНДЕРТАРГЕТОМ!!!!!!!!
    dxDrawText ( "#000000"..removeHex(text), xposit+1, yposit + 1, zposit+1, top+1, tocolor ( 0, 0, 0, 255 ), 1.00, "default-bold", "left", "top",false,false,false,true)
    dxDrawText ( "#000000"..removeHex(text), xposit+1, yposit - 1, zposit+1, top-1, tocolor ( 0, 0, 0, 255 ), 1.00, "default-bold", "left", "top",false,false,false,true)
    dxDrawText ( "#000000"..removeHex(text), xposit-1, yposit + 1, zposit-1, top+1, tocolor ( 0, 0, 0, 255 ), 1.00, "default-bold", "left", "top",false,false,false,true)
    dxDrawText ( "#000000"..removeHex(text), xposit-1, yposit - 1, zposit-1, top-1, tocolor ( 0, 0, 0, 255 ), 1.00, "default-bold", "left", "top",false,false,false,true)
    dxDrawText ( "#000000"..removeHex(text), xposit-1, yposit, zposit, top, tocolor ( 0, 0, 0, 255 ), 1.00, "default-bold", "left", "top",false,false,false,true)
    dxDrawText ( "#000000"..removeHex(text), xposit, yposit - 1, zposit, top, tocolor ( 0, 0, 0, 255 ), 1.00, "default-bold", "left", "top",false,false,false,true)
    dxDrawText ( "#000000"..removeHex(text), xposit, yposit, zposit-1, top, tocolor ( 0, 0, 0, 255 ), 1.00, "default-bold", "left", "top",false,false,false,true)
    dxDrawText ( "#000000"..removeHex(text), xposit, yposit, zposit, top-1, tocolor ( 0, 0, 0, 255 ), 1.00, "default-bold", "left", "top",false,false,false,true)

    dxDrawText (text, xposit, yposit, zposit,top,nil, 1.00, "default-bold", "left", "top",false,false,false,true)
end

function TextFuel() -- описано ниже в скролле
    local ypos = yposition
    dxSetRenderTarget(renderMainTarget,true)
    for i = #chat_messages, 1, -1 do
        if ypos < 0 or ypos > 227 then 
           i = #chat_messages-1
           ypos = ypos - 17
        else
            dxDrawBorderedText(chat_messages[i],5,ypos,250,5)
            ypos = ypos - 17
        end
    end
    dxSetRenderTarget()
end

function TextScroll(ypos) -- скролл чата
    dxSetRenderTarget(renderMainTarget,true)
        for i = #chat_messages, 1, -1 do -- перебор сообщений с ходом -1
        if ypos < 0 or ypos > 225 then -- если позиция собщения дальше рендертаргета
            i = #chat_messages-1 
            ypos = ypos - 17 -- позиция сообщения-17
        else
            dxDrawBorderedText(chat_messages[i],5,ypos,250,5) -- отрисовка сообщения 
            ypos = ypos - 17
        end
    end
    dxSetRenderTarget()
end

function chatKey( btn, press ) -- когда игрок нажал кнопку
    if chat_opened == 1 then -- если чат виден
         if press then -- если нажал
            if btn == "mouse_wheel_up" then -- если кнопка = колёсико вверх
                yposition = yposition + 17 -- скроллим позицию вверх
                TextScroll(yposition) -- функция скролла чата
            elseif btn == "mouse_wheel_down" then -- если кнопка = колёсико вниз
                yposition = yposition - 17 -- скроллим позицию вниз
                TextScroll(yposition) -- функция скролла чата
			end
        end
    end
end
addEventHandler("onClientKey", root, chatKey)


function RenderMainTarget()
    if isElement(renderMainTarget) then
        dxDrawImage(0,0,700,250,renderMainTarget)
    end
end
addEventHandler("onClientRender" , root, RenderMainTarget)

function handleRestore( didClearRenderTargets )
    if didClearRenderTargets then
        TextFuel()
    end
end
addEventHandler("onClientRestore",root,handleRestore)