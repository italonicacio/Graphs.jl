
export bfs, dfs, save_gdf, all_distances, all_eccentricities, radius, diameter, mean_distance


"""
Busca em largura:
Retorna a busca para salvar no formato GDF e os niveis da arvore
"""
function bfs(G, root)

    father = "0,0,255"
    brother = "255,0,0"
    cousin = "255,255,0"
    uncle = "0,255,0"

    queue = []
    is_visited = [0 for i = 1:G.n]
    parent = [0 for i = 1:G.n]
    level = [0 for i = 1:G.n]
    
    
    edge_information = Dict()
    t = 1
    is_visited[root] = t
    level[root] = 0

        
    push!(queue, root)


    while !isempty(queue)
        v = popfirst!(queue)
        
        for w in G.adjacency_list[v]
            
            if is_visited[w] == 0
                t += 1
                
                parent[w] = v
                level[w] = level[v] + 1
                is_visited[w] = t

                #If necessario para n gerar duplicatas e manter v < w
                if v < w
                    edge_information[v, w] = father
                else
                    edge_information[w, v] = father
                end

                push!(queue, w)
            elseif level[w] == level[v]
                if parent[w] == parent[v]
                    #If necessario para n gerar duplicatas e manter v < w
                    if v < w
                        edge_information[v, w] = brother
                    else
                        edge_information[w, v] = brother
                    end
                    
                else 
                    #If necessario para n gerar duplicatas e manter v < w
                    if v < w
                        edge_information[v, w] = cousin
                    else
                        edge_information[w, v] = cousin
                    end
                    
                end

            elseif level[w] == level[v] + 1
                
                 #If necessario para n gerar duplicatas e manter v < w
                 if v < w
                    edge_information[v, w] = uncle
                else
                    edge_information[w, v] = uncle
                end
            end
        end
    end
    
    return sort(collect(edge_information)), level

end



"""
Busca em profundidade:
Retorna a busca para salvar no formato GDF
"""
function dfs(G, root)

    edge_information = Dict()
    
    DI = [0 for i = 1:G.n] # profundidade de entrada
    DO = [0 for i = 1:G.n] # profundidade de saida
    parent = [0 for i = 1:G.n]
    global t = 0
    dfs_recursive!(G, root, t, DI, DO, parent, edge_information)

    return sort(collect(edge_information))
end

"""
Recursividade da busca em profundidade
"""
function dfs_recursive!(G, v, t, deep_in, deep_out, parent, edge_information)
    blue = "0,0,255"
    red = "255,0,0"

    global t += 1
    deep_in[v] = t
    for w in G.adjacency_list[v]
        if deep_in[w] == 0
            
            #If necessario para n gerar duplicatas e manter v < w
            if v < w 
                edge_information[v, w] = blue
            else 
                edge_information[w, v] = blue
            end
            parent[w] = v
            dfs_recursive!(G, w, t, deep_in, deep_out, parent, edge_information)
        else
            if deep_out[w] == 0 && w != parent[v]
                #If necessario para n gerar duplicatas e manter v < w
                if v < w 
                    edge_information[v, w] = red
                else 
                    edge_information[w, v] = red
                end
            end
        end
    end

    global t += 1
    deep_out[v] = t
end


"""
Salvar o Grafo simples no formato GDF
"""
function save_gdf(G, edge_information, out_file)
    header_1 = "nodedef>name VARCHAR,label VARCHAR"
    header_2 = "edgedef>node1 VARCHAR,node2 VARCHAR,directed BOOLEAN,color VARCHAR"

    open(out_file, "w") do io
        println(io, header_1)

        for i = 1:G.n
            println(io, "$i,$i")
        end

        println(io, header_2)


        for i in edge_information
            key = i[1]
            node1 = key[1]
            node2 = key[2]
            value = i[2]
            
            println(io, "$node1,$node2,false,'$value'")
        end

    end

end

function all_distances(G)

    all_d = [[] for i = 1:G.n]
    for i = 1:G.n
        all_d[i] = bfs(G, i)[2]
    end

    return all_d
end

function all_eccentricities(G)
    all_d = all_distances(G)
    all_e = [0 for i = 1:G.n]
    for i = 1:G.n
        all_e[i] = maximum(all_d[i])
    end

    return all_e
end

function radius(G)
    all_e = all_eccentricities(G)
    return minimum(all_e)
end

function diameter(G)
    all_e = all_eccentricities(G)
    return maximum(all_e)
end

function mean_distance(G)
    all_d = all_distances(G)
    total_mean_distance = 0.0

    for i = 1:G.n
        mean_distance = 0.0
        for j = 1:G.n
            mean_distance += all_d[i][j]
        end
        total_mean_distance += mean_distance
    end

    return total_mean_distance *= 1/(G.n*(G.n - 1))
end