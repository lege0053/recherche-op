-- Algorithme de Bellman-Ford avec impression formatée
function bellman(graph, source)
    local numVertices = #graph
    local d = {}  -- Tableau pour stocker les valeurs d(t)

    -- Initialisation des distances
    for i = 1, numVertices do
        d[i] = math.huge
    end
    d[source] = 0

    -- Tant qu'il reste des sommets non fixés
    for _ = 1, numVertices - 1 do
        for t = 1, numVertices do
            if d[t] < math.huge then
                for u = 1, numVertices do
                    if graph[t][u] > 0 then
                        local dut = graph[t][u]
                        if d[u] > d[t] + dut then
                            d[u] = d[t] + dut
                        end
                    end
                end
            end
        end
    end

    -- Impression formatée des résultats
    for i = 1, numVertices do
        if i ~= source then
            print(string.format("Pour allez de %s vers %s : %d", string.char(source + 64), string.char(i + 64), d[i]))
        end
    end
end

-- Exemple d'utilisation
local dataString  = arg[1]
local success, result = pcall(load("return " .. dataString))

if success then
    local graph = result
    local sourceVertex = 1
    bellman(graph, sourceVertex)
else
    print("Erreur lors de la conversion de la chaîne en tableau Lua.")
end
