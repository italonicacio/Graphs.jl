
export  Graph, 
        δ, delta, 
        Δ, Delta,
        mean_degree,
        d,
        vertices_degree_unordered,
        vertices_degree,
        closed_neighbourhood,
        open_neighbourhood,
        isneighbor,
        isregular,
        iscomplete,
        universal_vertices,
        isolated_vertices,
        vertex_induced,
        subgraph_vertex_induced,
        edge_induced,
        subgraph_edge_induced,
        is_walk_path_cycle,
        isclique

struct Graph
    n
    m
    adjacency_matrix
    adjacency_list
    
    Graph(n, m, adjacency_matrix, adjacency_list) = new(n, m, adjacency_matrix, adjacency_list)
end

"""
Cria e retorna um grafo com a matriz de adjacencia e a lista de adjacencia
"""
function creat_graph(n, matrix)
    adj_list = []
    m = 0
    for i = 1:n
        aux_list = []
        for j = 1:n
            if matrix[i,j] != 0
                push!(aux_list, j)
                m += 1
            end
        end
        push!(adj_list, aux_list)
    end
    m = Int64(m/2)
    return Graph(n, m, matrix, adj_list)
end

"""
Grau minimo de um Grafo
"""
δ(G::Graph) = delta(G)

"""
Grau maximo de um Grafo
"""
Δ(G::Graph) = Delta(G)

"""
Grau minimo de um Grafo
"""
function delta(G::Graph)
    min = Inf
    vertex = 0
    for i = 1:G.n
        aux_min = length(G.adjacency_list[i])
        
        if aux_min < min
            min = aux_min
            vertex = i
        end
    end

    return min
end


"""
Grau maximo de um Grafo
"""
function Delta(G::Graph)
    max = -1
    vertex = 0
    for i = 1:G.n
        aux_max = length(G.adjacency_list[i])
        
        if aux_max > max
            max = aux_max
            vertex = i
        end
    end

    return max
end

"""
Retorna o grau medio do Grafo
"""
function mean_degree(G::Graph) 
    return 2*G.m/G.n
end


"""
Retorna o grau do vertice v
"""
function d(G, v) 
    return length(G.adjacency_list[v])
end

"""
Retorna o Grau dos Vertices do Grafo não ordenado
"""
function vertices_degree_unordered(G)
    unordered_degrees = []
    for i = 1:G.n
        push!(unordered_degrees, length(G.adjacency_list[i]))
    end

    return unordered_degrees
end

"""
Retorna o Grau dos Vertices do Grafo
"""
function vertices_degree(G)
    vertices_degree = vertices_degree_unordered(G)
    sort!(vertices_degree)
    return vertices_degree
end

"""
Retorna a vizinhança fechada do vertice v, a primeira posição do array com a vizinhança é o vertice v
"""
function closed_neighbourhood(G, v)
    closed_neigh = G.adjacency_list[v]
    return append!([v], closed_neigh)
end

"""
Retorna a vizinhança fechada do vertice v
"""
function open_neighbourhood(G, v)
    return G.adjacency_list[v]
end


"""
Retorna true ou false se os vertices u e v forem vizinhos ou não respectivamente
"""
function isneighbor(G, v, u)
    if G.adjacency_matrix[v, u] == 1
        return true
    else
        return false
    end
end


"""
Verifica se um Grafo G é k-regular e retorna 0 se G não for regular e se for regular retorna o valor de k
"""
function isregular(G)
    vertex_degrees = vertices_degree(G)
    
    if all(i -> i == vertex_degrees[1], vertex_degrees)
        return vertex_degrees[1]
    else
        return 0
    end

end

"""
Verifica se um Grafo G é completo e retorna true se G for completo e false se não
"""
function iscomplete(G)
    if isregular(G) > 0
        if G.m == G.n*(G.n-1)/2
            return true
        else
            return false
        end
    else
        return false 
    end
    
end

"""
Retorna os vertices universais do Grafo G, se não houver vertices universais retorna um array vazio
"""
function universal_vertices(G)
    vertex_degrees = vertices_degree_unordered(G)
    universal_vertices = []

    for i = 1:G.n
        if vertex_degrees[i] == G.n - 1
            push!(universal_vertices, i)
        end
    end
    

    return universal_vertices
end

"""
Retorna os vertices isolados do Grafo G, se não houver vertices isolados retorna um array vazio
"""
function isolated_vertices(G)
    vertex_degrees = vertices_degree_unordered(G)
    isolated_vertices = []
    
    for i = 1:G.n
        if vertex_degrees[i] == 0
            push!(isolated_vertices, i)
        end
    end
    
    return isolated_vertices
end

"""
Retorna um conjunto de vertices e arestas que representa um subgrafo de G
"""
function vertex_induced(G, V)
    E = []
    n = length(V)

    for i = 1:n
        v = V[i]
        for j = i+1:n
            u = V[j]
            if G.adjacency_matrix[v, u] != 0
                push!(E, (v, u))
            end
        end
    end

    return (V, E)
end

"""
Retorna um subgrafo induzido por um subconjunto de vertices do Grafo G
"""
function subgraph_vertex_induced(G, V)
    E = []
    n = length(V)
    adj_matrix = zeros(Int64, n, n)

    for i = 1:n 
        v = V[i]
        for j = i+1:n
            u = V[j]
            if G.adjacency_matrix[v, u] != 0
                push!(E, (v, u))
            end
        end
    end


    for i = 1:n
        v = V[i]
        
        for j = i+1:n
            u = V[j]
            if G.adjacency_matrix[v, u] != 0
                adj_matrix[i, j] = G.adjacency_matrix[v, u]
                adj_matrix[j, i] = G.adjacency_matrix[u, v]
            end

            # Necessario apenas quando utilizar multigrafos
            # if G.adjacency_matrix[u, v] != 0
            #     adj_matrix[j, i] = G.adjacency_matrix[u, v]
            # end

        end
    end

    return creat_graph(n, adj_matrix)
end

"""
Retorna um conjunto de vertices e arestas que representa um subgrafo de G
"""
function edge_induced(G, E)

    V = []
    for i = 1:length(E)
        e = E[i]

        if !(e[1] in V)
            push!(V, e[1])
        end

        if !(e[2] in V)
            push!(V, e[2])
        end

    end

    return (V, E)
end

"""
Retorna um subgrafo induzido por um subconjunto de arestas do Grafo G
"""
function subgraph_edge_induced(G, E)

    V = []
    for i = 1:length(E)
        e = E[i]

        if !(e[1] in V)
            push!(V, e[1])
        end

        if !(e[2] in V)
            push!(V, e[2])
        end

    end

    n = length(V)
    adj_matrix = zeros(Int64, n, n)
    
    for i = 1:n
        for j = i+1:n

        end
    end
    
    for k = 1:length(E)
        u = E[k][1]
        v = E[k][2]

        i = -1
        j = -1
        for w = 1:n
            
            if u == V[w]
                i = w
            end

            if v == V[w]
                j = w
            end

            if i != -1 && j != -1
                break
            end
        end

        adj_matrix[i, j] = G.adjacency_matrix[u, v]
        adj_matrix[j, i] = G.adjacency_matrix[v, u]
    end


    return creat_graph(n, adj_matrix)
end

"""
Retorna um array de boleanos com 3 posições onde cada uma diz respeito 
se a sequencia é um passeio, um caminho ou um ciclo respectivamente
"""
function is_walk_path_cycle(G, sequence)
    walk_path_cycle = [true, true, false]
    
    n = length(sequence)
    is_visited = Dict(sequence[i] => false for i = 1:n)

    current_vertex = sequence[1]
    is_visited[current_vertex] = true
    for i = 2:n-1
        aux_vertex = sequence[i]

        if G.adjacency_matrix[current_vertex, aux_vertex] != 1
            walk_path_cycle[1] = false
            walk_path_cycle[2] = false
            return walk_path_cycle
        end
        
        if is_visited[aux_vertex] == false
            is_visited[aux_vertex] = true
        else
            walk_path_cycle[2] = false
        end

        current_vertex = aux_vertex
        
    end

    if G.adjacency_matrix[current_vertex, sequence[n]] == 0
        walk_path_cycle[1] = false
        walk_path_cycle[2] = false
        walk_path_cycle[3] = false
        return walk_path_cycle
        
    elseif walk_path_cycle[2]
        
        if sequence[1] == sequence[n]
            walk_path_cycle[3] = true
            return walk_path_cycle
        elseif is_visited[sequence[n]]
            walk_path_cycle[2] = false
            walk_path_cycle[3] = false
        end
    end

    return walk_path_cycle
end


"""
Retorna 0 se o conjunto de vertices v não é uma clique, retorna 1 se for uma clique
e retorna 2 se for uma clique maximal
"""
function isclique(G, S)
    
    H = subgraph_vertex_induced(G, S)
    d_G = vertices_degree_unordered(G)
    is_clique = 0
    if iscomplete(H)
        is_clique = 1
        
        is_visited = [false for i = 1:G.n]
        for i in S
            is_visited[i] = true
        end
        
        aux = S
        is_maximal = true
        for i = 1:G.n
        
            if !is_visited[i]
                push!(aux, i)

                aux_G = subgraph_vertex_induced(G, aux)

                if iscomplete(aux_G)
                    is_maximal = false
                end

                aux = S
            end
            
        end

        if is_maximal
            is_clique = 2
        end
    end


    return is_clique
end