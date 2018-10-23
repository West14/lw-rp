chat_range = 15 -- рейндж сообщения

function sendMessageToAll(typeMsg,player,...) -- Отправка сообщений всем, кто находится рядом
  if typeMsg == "msg" then -- если тип обычное сообщение
    local px,py,pz=getElementPosition(player) -- взять коордитаны игрока
    for _,v in ipairs(getElementsByType("player")) do -- перебор игроков 
      if isPlayerInRangeOfPoint(v,px,py,pz,chat_range) then  -- если игрок рядом
        triggerClientEvent(v, "outputChatMessage",v,...) -- отправить сообщение игрокам, которые находятся рядом
      end 
    end
  elseif typeMsg == "rp_command" then -- если это рп команда
      -- later
  end
end 
addEvent("sendMessage",true)
addEventHandler("sendMessage",root,sendMessageToAll)

function isPlayerInRangeOfPoint(player,x,y,z,range) 
   local px,py,pz=getElementPosition(player) 
   return ((x-px)^2+(y-py)^2+(z-pz)^2)^0.5<=range 
end 