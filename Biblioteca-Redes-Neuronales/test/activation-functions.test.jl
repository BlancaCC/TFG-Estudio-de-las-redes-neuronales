using Test 

foo(x) = length(x)^2

@test foo("ala") == 2