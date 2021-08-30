export ReadInstance

"""
Lê um arquivo onde tem um Grafo e retorna um Grafo
"""
function ReadInstance(file_name)
    n = :Int64
    matrix = :Matrix 
    open(file_name, "r") do f
        n = parse(Int64, readline(f))
        matrix = zeros(Int64, n, n)
        i = 1
        while ! eof(f)
            line = readline(f)
            aux = split(line)
            aux = parse.(Int64, aux)
            matrix[i,:] = aux            
            i += 1
        end
    end
    return creat_graph(n, matrix)
end