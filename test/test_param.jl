using LinearAlgebra
using Transducers
n = 3
q = 4*rand(Float64)
r = 2*rand(Float64)
k = 10000
actions = 1:k

function empirical_var(diffs,n,k)
    sum(sum([d .^ 2 for d in diffs]))/(n*k)
end

lssm = LinearStateSpaceModel(Matrix{Float64}(I, n, n), q .* Matrix{Float64}(I, n, n))
states = collect(Simulator(lssm), actions)
lobs = LinearObservation(Matrix{Float64}(I, n, n), r .* Matrix{Float64}(I, n, n))
measures = states |> Map(s -> observe(s,lobs)) |> collect