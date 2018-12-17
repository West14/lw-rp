Fraction_list = {
	[1] = "LSPD",
	[2] = "Mayor"
}
Fraction_spawn = {
	[1] = {
		["x"] = {391.658203125},
		["y"] = {-1524.560546875},
		["z"] = {52.266296386719}
	},
	[2] = {
		["x"] = {0},
		["y"] = {0},
		["z"] = {0}
	}
}

function setPlayerLeader(player, fr_id )
	if fr_id > 0 and fr_id <= #Fraction_list then
		setElementData( player, "leader", fr_id )
	elseif fr_id == 0 then
		setElementData(player, "leader",false)
	end 
end

function getPlayerFraction(player)
	player = getPlayer( player )
	return getElementData( player, "fraction")
end

function fraction_invite()
	-- body
end

function fraction_uninvite()
	-- body
end