####################################################
#                   CONTAINS ALL THE TEST 
# Those test are: 
# - Activation functions
# - Neuronal network structure
# - Forward Propagation 
# - Our initialization algorithm
####################################################
println("Testing Activation functions...")
t = @elapsed include("activation_functions.test.jl")
println("done (took $t seconds).")

println("Testing Neuronal Network Data type")
t = @elapsed include("one_layer_neural_network.test.jl")
println("done (took $t seconds).")

println("Testing ForwardPropagation")
t = @elapsed include("forward_propagation.test.jl")
println("done (took $t seconds).")

println("Testing our initialization algorithm")
t = @elapsed include("weight-initializer-algorithm/main.test.jl")
println("done (took $t seconds).")

println("Testing metric estimation")
t = @elapsed include("metric_estimation.test.jl")
println("done (took $t seconds).")