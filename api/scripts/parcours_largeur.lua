-- local args = { ... }

-- -- Vérifier s'il y a au moins un argument
-- if #args < 1 then
--     print("Aucune donnée fournie.")
-- else
--     -- Récupérer la première valeur de la liste des arguments
--     local data = args[1]

--     -- Séparer les éléments de la chaîne formatée
--     local keyValuePairs = {}
--     for pair in string.gmatch(data, "([^,]+)") do
--         local key, value = pair:match("([^:]+):(.+)")
--         if key and value then
--             keyValuePairs[key] = value
--         end
--     end

--     -- Afficher chaque paire clé-valeur
--     for key, value in pairs(keyValuePairs) do
--         print(key .. " = " .. value)
--     end
-- end

-- Structure de graphe représentée sous forme de liste d'adjacence
local graph = {
    {2, 3},   -- Sommet 1 est relié à 2 et 3
    {3, 5},   -- Sommet 2 est relié à 4 et 5
    {},      -- Sommet 3 est relié à 6
    {2},       -- Sommet 4 n'a pas de successeurs
    {4,6},      -- Sommet 5 est relié à 6
    {3}        -- Sommet 6 n'a pas de successeurs
}

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
      local visited = {}  -- Tableau pour marquer les sommets visités
      local queue = ListNew()    -- File pour le parcours en largeur
      local preVisitOrder = {}  -- Tableau pour l'ordre de pré-visite
      local postVisitOrder = {} -- Tableau pour l'ordre de post-visite
  
      -- Fonction pour visiter un sommet
      local function visit(vertex)
          table.insert(preVisitOrder, vertex)
      end
  
      -- Fonction pour fermer un sommet
      local function close(vertex)
          table.insert(postVisitOrder, vertex)
      end
  
      -- Parcourir tous les sommets du graphe
      for vertex = 1, #graph do
          if not visited[vertex] then
              ListPushRight(queue, vertex)
              visited[vertex] = true
  
              while queue.first <= queue.last do
                  local currentVertex = ListPopLeft(queue)
                  visit(currentVertex)
  
                  for _, successor in ipairs(graph[currentVertex]) do
                      if not visited[successor] then
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
  
  parcoursEnLargeur(graph)
  