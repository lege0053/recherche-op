function ListNew()
    return {first = 0, last = -1}
end

function ListPushRight(list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
end

function ListPopLeft(list)
    local first = list.first
    if first > list.last then error("liste vide") end
    local value = list[first]
    list[first] = nil
    list.first = first + 1
    return value
end

function plusCourtChemin(graph)
    local visited = {}  -- Sommets visités
    local queue = ListNew()    -- File pour le parcours en largeur
    local distance = {}  -- Distance depuis le sommet initial
    local ordreVisite = {}  -- Ordre de visite
    local ordreFermeture = {} -- Ordre de fermeture

    -- Initialisation des distances
    for i = 1, #graph do
        distance[i] = math.huge
    end

    -- Fonction pour visiter un sommet
    local function visit(vertex)
        table.insert(ordreVisite, string.char(vertex + 64)) -- Utilisation de la valeur ASCII pour obtenir la lettre correspondante
    end

    -- Fonction pour fermer un sommet
    local function close(vertex)
        table.insert(ordreFermeture, string.char(vertex + 64))
    end

    -- Parcours en largeur
    ListPushRight(queue, 1)
    visited[1] = true
    distance[1] = 0

    while queue.first <= queue.last do
        local currentVertex = ListPopLeft(queue)
        
        for successor = 1, #graph[currentVertex] do
            if graph[currentVertex][successor] == 1 and not visited[successor] then
                ListPushRight(queue, successor)
                visited[successor] = true
                distance[successor] = distance[currentVertex] + 1
            end
        end

        visit(currentVertex)
        close(currentVertex)
    end

    -- Affichage des résultats
    print("Ordre de visite:", table.concat(ordreVisite, ", "))
    print("Ordre de fermeture:", table.concat(ordreFermeture, ", "))

    for i = 1, #graph do
        print("d(" .. string.char(i + 64) .. ") =", distance[i])
    end
end

local dataString  = arg[1]
local success, result = pcall(load("return " .. dataString))

if success then
    local graph = result
    plusCourtChemin(graph)
else
    print("Erreur lors de la conversion de la chaîne en tableau Lua.")
end
