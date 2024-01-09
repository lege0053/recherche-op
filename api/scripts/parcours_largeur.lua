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

function parcoursEnLargeur(graph)
    local visited = {}  -- Sommets visités
    local queue = ListNew()    -- File pour le parcours en largeur
    local preVisitOrder = {}  -- Ordre de pré-visite
    local postVisitOrder = {} -- Ordre de post-visite

    -- Fonction pour visiter un sommet
    local function visit(vertex)
        table.insert(preVisitOrder, string.char(vertex + 64)) -- Utilisation de la valeur ASCII pour obtenir la lettre correspondante
    end

    -- Fonction pour fermer un sommet
    local function close(vertex)
        table.insert(postVisitOrder, string.char(vertex + 64))
    end

    -- Parcourir tous les sommets du graphe
    for vertex = 1, #graph do
        if not visited[vertex] then
            ListPushRight(queue, vertex)
            visited[vertex] = true

            while queue.first <= queue.last do
                local currentVertex = ListPopLeft(queue)
                visit(currentVertex)

                for successor = 1, #graph[currentVertex] do
                    if graph[currentVertex][successor] == 1 and not visited[successor] then
                        ListPushRight(queue, successor)
                        visited[successor] = true
                    end
                end

                close(currentVertex)
            end
        end
    end

    print("Ordre de visite:", table.concat(preVisitOrder, ", "))
    print("Ordre de fermeture:", table.concat(postVisitOrder, ", "))
end

local dataString  = arg[1]
local success, result = pcall(load("return " .. dataString))

if success then
    local graph = result
    parcoursEnLargeur(graph)
else
    print("Erreur lors de la conversion de la chaîne en tableau Lua.")
end
