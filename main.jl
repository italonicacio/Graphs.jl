using Revise
using Graphs

file_name = "instances/in/graph_1"

G = ReadInstance(file_name)

ei = bfs(G, 1)[1]

all_e = all_eccentricities(G)

println("raio = ", radius(G))

println("Diametro = ", diameter(G))

println("distancia media do Grafo = ", mean_distance(G))


out_file = "out_graph.gdf"
save_gdf(G, ei, out_file)


