local function fileExists(path)
    return fs.exists(path) and not fs.isDir(path)
end

if not fileExists("update.lua") then
    shell.run("wget", "https://github.com/Dartsgame974/animesame-rss/raw/main/update.lua", "update.lua")
end

if not fileExists("boot.nfp") then
    shell.run("wget", "https://github.com/Dartsgame974/animesame-rss/raw/main/boot.nfp", "boot.nfp")
end

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

local function afficherDiapositive(episode)
    term.clear()
    term.setCursorPos(1, 1)
    print(episode.day)
    print(episode.nom)
    print("Heure : " .. episode.heure)
    if episode.probleme == "Report?" then
        term.setTextColor(colors.red)
        print("Reporté")
        term.setTextColor(colors.white)
    else
        print("Langue : " .. episode.langue)
    end
    sleep(4)
end

-- Chargement de l'image "boot.nfp" depuis le fichier local
local function afficherBootImage()
    term.clear()
    local bootImage = paintutils.loadImage("boot.nfp")
    paintutils.drawImage(bootImage, 1, 1)
    sleep(3)
end

local jsonContent = getJSON(url)

if jsonContent then
    local jsonData = textutils.unserializeJSON(jsonContent)
    local jours = {}
    for _, dayData in ipairs(jsonData) do
        table.insert(jours, dayData.day)
    end

    local function displayMenu()
        local selectedIndex = 1
        local totalOptions = #jours

        while true do
            term.clear()
            term.setCursorPos(1, 1)
            print("Sélectionnez un jour :")

            for index, jour in ipairs(jours) do
                if index == selectedIndex then
                    term.setTextColor(colors.green)
                else
                    term.setTextColor(colors.white)
                end
                print("  " .. jour)
            end

            local _, key = os.pullEvent("key")
            if key == keys.up then
                selectedIndex = selectedIndex - 1
                if selectedIndex < 1 then
                    selectedIndex = totalOptions
                end
            elseif key == keys.down then
                selectedIndex = selectedIndex + 1
                if selectedIndex > totalOptions then
                    selectedIndex = 1
                end
            elseif key == keys.enter then
                local selectedDay = jsonData[selectedIndex]
                local episodes = selectedDay.items

                local pageSize = 3
                local totalPages = math.ceil(#episodes / pageSize)
                local currentPage = 1

                while true do
                    term.clear()
                    term.setCursorPos(1, 1)
                    print(selectedDay.day .. " - Épisodes :")

                    local startIndex = (currentPage - 1) * pageSize + 1
                    local endIndex = math.min(startIndex + pageSize - 1, #episodes)

                    for index = startIndex, endIndex do
                        local episode = episodes[index]
                        print("  " .. episode.nom)
                        print("  Heure : " .. episode.heure)
                        if episode.probleme == "Report?" then
                            term.setTextColor(colors.red)
                            print("  Reporté")
                            term.setTextColor(colors.white)
                        else
                            print("  Langue : " .. episode.langue)
                        end
                        print()
                    end

                    local _, key = os.pullEvent("key")
                    if key == keys.left then
                        currentPage = currentPage - 1
                        if currentPage < 1 then
                            currentPage = totalPages
                        end
                    elseif key == keys.right then
                        currentPage = currentPage + 1
                        if currentPage > totalPages then
                            currentPage = 1
                        end
                    elseif key == keys.enter then
                        break
                    end
                end
            end
        end
    end

    afficherBootImage()
    displayMenu()
end
