###################################################
#   Test inicialización de pesos 
################################################### 
using Test 
using Random 
Random.seed!(2);

include("single-input-single-output.test.jl")
include("multiple-input-single-output.test.jl")
include("multiple-input-multiple-output.test.jl")