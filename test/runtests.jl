using KalmanAD

using Test

include("test_param.jl")

@testset "statespacemodel" begin
    include("statespacemodel_test.jl")
end

@testset "observer" begin
    include("observer_test.jl")
end

@testset "filter" begin
    include("filter_test.jl")
end
