-- Function to reverse a table
function reverseTable(tbl)
    local reversed = {}
    local length = #tbl
    for i = length, 1, -1 do
        table.insert(reversed, tbl[i])
    end
    return reversed
end

-- Algorithme de Ford pour le chemin de valeur maximale avec impression formatée
function fordMaxValuePath(graph, source)
    local numVertices = #graph
    local t = {}  -- Tableau pour stocker les valeurs ti

    for i = 1, numVertices do
        t[i] = -math.huge
    end

    t[source] = 0

    local maxPath = {}  -- Tableau pour stocker le chemin de valeur maximale
    local maxPathValue = 0

    repeat
        local updated = false

        for i = 1, numVertices do
            for j = 1, numVertices do
                if graph[i][j] > 0 then
                    local dij = graph[i][j]

                    if t[j] < t[i] + dij then
                        t[j] = t[i] + dij
                        updated = true

                        -- Mise à jour du chemin de valeur maximale
                        maxPath[j] = i

                        -- Mise à jour de la valeur maximale
                        maxPathValue = t[j]
                    end
                end
            end
        end
    until not updated

    -- Impression formatée des résultats
    for i = 1, numVertices do
        if i ~= source then
            local path = {}
            local currentVertex = i

            -- Reconstitution du chemin
            while currentVertex do
                table.insert(path, string.char(currentVertex + 64)) -- Utilisation de la valeur ASCII pour obtenir la lettre correspondante
                currentVertex = maxPath[currentVertex]
            end

            -- Inversion du chemin pour l'affichage correct
            path = reverseTable(path)

            -- Impression du résultat
            print(string.format("%s : %d", table.concat(path, " -> "), t[i]))
        end
    end
end

local dataString  = arg[1]
local success, result = pcall(load("return " .. dataString))

if success then
    local graph = result
    local sourceVertex = 1
    fordMaxValuePath(graph, sourceVertex)
else
    print("Erreur lors de la conversion de la chaîne en tableau Lua.")
end


