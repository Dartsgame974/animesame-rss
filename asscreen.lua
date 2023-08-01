local url = "https://raw.githubusercontent.com/Dartsgame974/animesame-rss/main/flux.json"

local function getJSON(url)
	local response = http.get(url)
	if response then
		local data = response.readAll()
		response.close()
		return data
	else
		print("Impossible de récupérer les données JSON.")
	end
end

local function afficherEpisodeSurMoniteur(episode, moniteur)
	local largeurMoniteur, hauteurMoniteur = moniteur.getSize()
	local centreX = math.floor(largeurMoniteur / 2)
	local centreY = math.floor(hauteurMoniteur / 2)

	moniteur.clear()
	moniteur.setCursorPos(centreX - 10, centreY - 2)
	moniteur.write("------------------------------------------------")
	moniteur.setCursorPos(centreX - 10, centreY - 1)
	moniteur.write("Jour: " .. episode.day)
	moniteur.setCursorPos(centreX - 10, centreY)
	moniteur.write("Nom : " .. episode.nom)
	moniteur.setCursorPos(centreX - 10, centreY + 1)
	moniteur.write("Heure: " .. episode.heure)
	moniteur.setCursorPos(centreX - 10, centreY + 2)
	if episode.probleme == "Report?" then
		moniteur.setTextColor(colors.red)
		moniteur.write("Statut : Reporté")
		moniteur.setTextColor(colors.white)
	else
		moniteur.write("Langue: " .. episode.langue)
	end
	moniteur.setCursorPos(centreX - 10, centreY + 3)
	moniteur.write("------------------------------------------------")
	sleep(4)
end

local function getCurrentTime()
	local response = http.get("http://worldtimeapi.org/api/timezone/Europe/Paris")
	if response then
		local result = response.readAll()
		response.close()
		local timeTable = textutils.unserializeJSON(result)
		return timeTable.datetime
	else
		return nil
	end
end

local jsonContent = getJSON(url)

if jsonContent then
	local jsonData = textutils.unserializeJSON(jsonContent)

	local moniteur = peripheral.find("monitor")
	if moniteur then
		moniteur.setTextScale(1)
		moniteur.setBackgroundColor(colors.black)
		moniteur.setTextColor(colors.white)
	else
		print("Aucun moniteur n'a été trouvé.")
		return
	end

	local lastHour = ""
	while true do
		local currentTime = getCurrentTime()
		if currentTime then
			local hour = string.sub(currentTime, 12, 13)
			if hour ~= lastHour then
				lastHour = hour
				for _, dayData in ipairs(jsonData) do
					local jour = dayData.day
					for _, episode in ipairs(dayData.items) do
						episode.day = jour
						afficherEpisodeSurMoniteur(episode, moniteur)
					end
				end
			end
		else
			print("Erreur de connexion pour l'heure.")
		end
		sleep(20)
	end
end
