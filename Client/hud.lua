local walletrectangle = dxCreateRoundedTexture(screenW * 0.8931, screenH * 0.1178, screenW * 0.1215, screenH * 0.0400,12,"Images/wallet-mask.png")
function dxDrawLogo()
    if isLogged(lp) then
        dxDrawImage(screenW * 0.8833, screenH * 0.0111, screenW * 0.0431, screenH * 0.0711, "Images/auth-logo.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawText("LYNCHWOOD", screenW * 0.9056, screenH * 0.0333, screenW * 0.9931, screenH * 0.0489, guiColor, 1.00, font_montmediumXX, "center")
        dxDrawText("ROLEPLAY", screenW * 0.9056, screenH * 0.0489, screenW * 0.9931, screenH * 0.0644, guiColor, 1.00, font_montregularB, "center")
        dxDrawImage(screenW * 0.8931, screenH * 0.1178, screenW * 0.1215, screenH * 0.0400,walletrectangle)

        dxDrawImage(screenW * 0.9028, screenH * 0.1267, screenW * 0.0125, screenH * 0.0200, "Images/wallet.png")

        dxDrawText(getPlayerMoney(), screenW * 0.9222, screenH * 0.1244, screenW * 0.9951, screenH * 0.1467, tocolor(255, 255, 255, 255), 1.00, font_montlightX, "center", "center")
    end
end
addEventHandler("onClientRender",root,dxDrawLogo)