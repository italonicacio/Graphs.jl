using Revise
using Graphs

file_name = "instances/graph1.txt"

G = ReadInstance(file_name)

mean_degree(G)

