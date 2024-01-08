local args = { ... }

-- Vérifier s'il y a au moins un argument
if #args < 1 then
    print("Aucune donnée fournie.")
else
    -- Récupérer la première valeur de la liste des arguments
    local data = args[1]

    -- Séparer les éléments de la chaîne formatée
    local keyValuePairs = {}
    for pair in string.gmatch(data, "([^,]+)") do
        local key, value = pair:match("([^:]+):(.+)")
        if key and value then
            keyValuePairs[key] = value
        end
    end

    -- Afficher chaque paire clé-valeur
    for key, value in pairs(keyValuePairs) do
        print(key .. " = " .. value)
    end
end