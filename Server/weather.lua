function setupWeatherChanger()
	setTimer(changeWeather, 30*60000, 0)
end

function changeWeather()
	local time = getRealTime()
	math.randomseed(time.timestamp)
	local weatherId = math.random(0, 20)
	local w = setWeatherBlended(weatherId)
	if not(w) then
		outputServerLog('An error occurred when changing weather')
	else
		outputDebugString('Weather succesfully changed to ' .. tostring(weatherId))
	end
end

addEventHandler("onResourceStart", getRootElement(), setupWeatherChanger)
