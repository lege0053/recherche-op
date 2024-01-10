function parcourProfondeur(graph)
    local visited = {}  -- Sommets visités
    local stack = {}    -- Pile pour le parcours en profondeur
    local ordreVisite = {}  -- Ordre de visite
    local ordreFermeture = {} -- Ordre de fermeture

    -- Fonction pour prévisiter un sommet
    local function previsit(vertex)
        table.insert(ordreVisite, string.char(vertex + 64)) -- Utilisation de la valeur ASCII pour obtenir la lettre correspondante
    end

    -- Fonction pour postvisiter un sommet
    local function postvisit(vertex)
        table.insert(ordreFermeture, string.char(vertex + 64))
    end

    -- Fonction pour vérifier si tous les successeurs d'un sommet ont été visités
    local function allSuccessorsVisited(vertex)
        for _, successor in ipairs(graph[vertex]) do
            if successor == 1 and not visited[_] then
                return false
            end
        end
        return true
    end

    -- Parcours en profondeur
    for i = 1, #graph do
        if not visited[i] then
            table.insert(stack, i)
            visited[i] = true
            previsit(i)

            while #stack > 0 do
                local currentVertex = stack[#stack]

                local foundSuccessor = false
                for successor = 1, #graph[currentVertex] do
                    if graph[currentVertex][successor] == 1 and not visited[successor] then
                        table.insert(stack, successor)
                        visited[successor] = true
                        previsit(successor)
                        foundSuccessor = true
                        break
                    end
                end

                if not foundSuccessor then
                    postvisit(currentVertex)
                    table.remove(stack)
                end
            end
        end
    end

    -- Affichage des résultats
    print("Ordre de visite:", table.concat(ordreVisite, ", "))
    print("Ordre de fermeture:", table.concat(ordreFermeture, ", "))
end

local dataString  = arg[1]
local success, result = pcall(load("return " .. dataString))

if success then
    local graph = result
    parcourProfondeur(graph)
else
    print("Erreur lors de la conversion de la chaîne en tableau Lua.")
end