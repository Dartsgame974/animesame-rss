local fileURL = "https://github.com/Dartsgame974/animesame-rss/raw/main/aspocket.lua"
local filePath = "aspocket.lua"

-- Supprimer l'ancien fichier aspocket.lua s'il existe
if fs.exists(filePath) then
    fs.delete(filePath)
end

-- Télécharger le nouveau fichier aspocket.lua depuis le lien
local response = http.get(fileURL)
if response then
    local fileContent = response.readAll()
    response.close()

    -- Écrire le contenu téléchargé dans un nouveau fichier aspocket.lua
    local file = fs.open(filePath, "w")
    file.write(fileContent)
    file.close()

    print("Le fichier aspocket.lua a été mis à jour.")
else
    print("Échec de la mise à jour du fichier aspocket.lua.")
end

