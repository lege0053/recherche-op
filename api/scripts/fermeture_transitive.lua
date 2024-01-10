function royWarshall(graph)
    local n = #graph

    -- Création de la matrice d'identité
    local identityMatrix = {}
    for i = 1, n do
        identityMatrix[i] = {}
        for j = 1, n do
            identityMatrix[i][j] = (i == j) and 1 or 0
        end
    end

    -- Algorithme de Roy-Warshall
    for k = 1, n do
        for i = 1, n do
            for j = 1, n do
                graph[i][j] = graph[i][j] or (graph[i][k] and graph[k][j])
            end
        end
    end

    return graph
end

local dataString  = arg[1]
local success, result = pcall(load("return " .. dataString))

if success then
    local graph = result
    local transitiveClosure = royWarshall(graph)

    -- Affichage de la matrice de fermeture transitive
    for i = 1, #transitiveClosure do
        io.write("[")
        for j = 1, #transitiveClosure[i] do
            io.write(transitiveClosure[i][j])
            if j ~= #transitiveClosure then
                io.write(", ")
            end
        end
        io.write("]")
        if i ~= #transitiveClosure then
            print(",")
        end
    end
else
    print("Erreur lors de la conversion de la chaîne en tableau Lua.")
end