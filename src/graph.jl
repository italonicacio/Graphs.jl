
export  Graph, 
        δ, delta, 
        Δ, Delta,
        mean_degree

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
δ(G) = delta(G)

"""
Grau maximo de um Grafo
"""
Δ(G) = Delta(G)

"""
Grau minimo de um Grafo
"""
function delta(G)
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
function Delta(G)
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

function mean_degree(G) 
    return Int64(round(2*G.m/G.n))
end
