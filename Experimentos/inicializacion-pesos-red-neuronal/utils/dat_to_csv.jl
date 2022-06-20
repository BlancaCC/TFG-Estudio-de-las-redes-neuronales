#################################################################
#       Fichero para convertir el formato .dat en .csv
#################################################################
# Fuente: https://stackoverflow.com/questions/61665998/reading-a-dat-file-in-julia-issues-with-variable-delimeter-spacing
function dat2csv(dat_path::AbstractString, csv_path::AbstractString)
    open(csv_path, "w") do io
        for line in eachline(dat_path)
            join(io, split(line), ',')
            println(io)
        end
    end

    return csv_path
end
function dat2csv(dat_path::AbstractString)
    base, ext = splitext(dat_path)
    ext == ".dat" ||
        throw(ArgumentError("file name doesn't end with `.dat`"))
    return dat2csv(dat_path, "$base.csv")
end

t = dat2csv("Experimentos/inicializacion-pesos-red-neuronal/data/airfoil_self_noise.dat")
println(t)