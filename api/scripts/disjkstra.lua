function dijkstra(graph, source)
    local numVertices = #graph
    local d = {}  -- Tableau pour stocker les valeurs d(t)
    local visited = {}  -- Tableau pour marquer les sommets visités

    -- Initialisation des distances
    for i = 1, numVertices do
        d[i] = math.huge
        visited[i] = false
    end
    d[source] = 0

    -- Tant qu'il reste des sommets non fixés
    for iteration = 1, numVertices do
        local u = -1
        for i = 1, numVertices do
            if not visited[i] and (u == -1 or d[i] < d[u]) then
                u = i
            end
        end

        visited[u] = true

        print("Iteration " .. iteration .. ": Visite du sommet " .. string.char(u + 64))

        for v = 1, numVertices do
            if graph[u][v] > 0 then
                local duv = graph[u][v]
                if d[v] > d[u] + duv then
                    d[v] = d[u] + duv
                    print(string.format("    Mise à jour de la distance de %s à %s : %d", string.char(source + 64), string.char(v + 64), d[v]))
                end
            end
        end
    end

    -- Impression formatée des résultats
    for i = 1, numVertices do
        if i ~= source then
            print(string.format("Pour aller de %s vers %s : %d", string.char(source + 64), string.char(i + 64), d[i]))
        end
    end
end

-- Exemple d'utilisation
local dataString  = arg[1]
local success, result = pcall(load("return " .. dataString))

if success then
    local graph = result
    local sourceVertex = 1
    dijkstra(graph, sourceVertex)
else
    print("Erreur lors de la conversion de la chaîne en tableau Lua.")
end
