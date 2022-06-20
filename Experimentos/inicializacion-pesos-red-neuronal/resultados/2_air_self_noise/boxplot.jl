##################################################################
# Muestra en pantalla los diagramas de bigotes 
##################################################################
using PlotlyJS
using CSV
using DataFrames
limit = 16
path = "Memoria/img/7-algoritmo-inicializar-pesos/experimento/"

# Imprimimos  tabla bigotes tiempo
df = DataFrame(CSV.File("Experimentos/inicializacion-pesos-red-neuronal/resultados/2_air_self_noise/tiempos.csv"))
table_df = Tables.matrix(df)
traces = [
    box(
        y = table_df[i, 2:16],
        name = table_df[i, 1]
    )
    for i in 1:2
]
ref = plot(traces, Layout(yaxis_title="Tiempos en segundos", boxmode="group"))
savefig(ref, path*"grafico-bigotes-tiempo.png")



# Error cuadrático medio 
file_path = "Experimentos/inicializacion-pesos-red-neuronal/resultados/2_air_self_noise/error_entrenamiento.csv"
df = DataFrame(CSV.File(file_path))
table_df = Tables.matrix(df)
traces = [
    box(
        y = table_df[i, 2:limit],
        name = table_df[i, 1]
    )
    for i in 1:2
]
ref = plot(traces, Layout(yaxis_title="Error cuadrático medio", boxmode="group"))
savefig(ref, path*"grafico-bigotes-error_entrenamiento.png")


# Error cuadrático medio 
file_path = "Experimentos/inicializacion-pesos-red-neuronal/resultados/2_air_self_noise/error_test.csv"
df = DataFrame(CSV.File(file_path))
table_df = Tables.matrix(df)
traces = [
    box(
        y = table_df[i, 2:limit],
        name = table_df[i, 1]
    )
    for i in 1:2
]
ref = plot(traces, Layout(yaxis_title="Error cuadrático medio", boxmode="group"))
path = "Memoria/img/7-algoritmo-inicializar-pesos/experimento/"
savefig(ref, path*"grafico-bigotes-error_test.png")