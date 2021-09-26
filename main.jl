using Revise
using Graphs

file_name = "instances/graph1.txt"

G = ReadInstance(file_name)


# I) Exibir os graus mínimo, máximo e medio
println("I)")
println("Grau minimo ", δ(G))
println("Grau maximo ", Δ(G))
println("Grau medio ", mean_degree(G))
println()



# II) Exibir a sequencia de graus de G
println("II)")
println("Sequencia de Graus de G:")
display(vertices_degree(G))
println()



# III) O grau e as vizinhancas aberta e fechada de um vertice v 
# informado pelo usuario
println("III)")
println("Grau, vizinhancas aberta e fechada do vertice v")
v = 1
println("Vertice v = ", v)
println("Grau de v")
println(d(G, v))
println()
println("Vizinhanca fechada:")
display(closed_neighbourhood(G, v))
println()
println("Vizinhanca aberta:")
display(open_neighbourhood(G, v))
println()




# IV) Determinar se dois vertices u e v 
# informados pelo usuario sao vizinhos
println("IV)")
println("Verificar se u e v são vizinhos:")
u = 2
v = 3
println("u = ", u)
println("v = ", v)
is_neighbor = isneighbor(G, v, u)

if is_neighbor
    println("u e v são vizinhos")
else 
    println("u e v não são vizinhos")
end

println()




# V) Informar se o grafo e k-regular, deixando claro o valor de k
println("V)")
k = isregular(G)

if k == 0
    println("O Grafo G não é regular")
else
    println("O Grafo G é ", k, " regular")
end

println()



# VI) Informar se G e completo
println("VI)")
is_complete = iscomplete(G)

if is_complete
    println("O Grafo G não é completo")
else
    println("O Grafo G é completo")
end

println()




# VII) Listar todos os vertices universais de G
println("VII)")
universal = universal_vertices(G)
display(universal)

println()




# VIII) Listar todos os vertices isolados de G
println("VIII)")
isolated = isolated_vertices(G)
display(isolated)

println()



# IX) Determinar o subgrafo de G induzido por um conjunto de vertices 
# S ⊆ V (G) informado pelo usuario. Tal subgrafo e denotado por G[S
println("IX)")
S = [1, 2, 3]
println("S:")
display(S)
println()

Gv_induced = vertex_induced(G, S)
println("G[S]: ")
println("V(G[S]):")
display(Gv_induced[1])
println()
println("E(G[S]):")
display(Gv_induced[2])

println()


# X) Determinar o subgrafo de G induzido por um conjunto de arestas E0 ⊆ E(G) 
# informado pelo usuario. Tal subgrafo e denotado por G[E']
println("X)")
E_ = [(1,2), (2,3), (5, 6)]
println("E':")
display(E_)
println()

Ge_induced = edge_induced(G, E_)
println("G[E']: ")
println("V(G[S]):")
display(Ge_induced[1])
println()
println("E(G[S]):")
display(Ge_induced[2])

println()



# XI) Decidir se uma sequencia de vertices v1, v2, ..., vk informada pelo usuario representa um passeio
# em G. Em casa afirmativo, informar se o passeio tambem constitui um ciclo ou um caminho;
println("XI)")
seq = [1, 2, 4, 3]

walk_path_cycle = is_walk_path_cycle(G, seq)
if walk_path_cycle[1]
    println("Essa sequencia é um passeio.")
    if walk_path_cycle[3]
        println("Essa sequencia é um ciclo.")
    elseif walk_path_cycle[2]
        println("Essa sequencia é um caminho.")
    end
end

println()




# XII) Determinar se um conjunto de vertices S ⊆ V (G) 
# informado pelo usuario e uma clique de G. Em caso afirmativo, 
# informar se a clique e maximal.
println("XII)")
println("Conjunto S:")
S_ = [1, 2, 3, 4]
display(S_)

is_clique = isclique(G, S_)
if is_clique > 0
    if is_clique == 1
        println("S é uma clique.")
    else
        println("S é uma clique maximal.")
    end
else
    println("Não é uma clique.")
end
