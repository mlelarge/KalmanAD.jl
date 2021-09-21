module KalmanAD
using LinearAlgebra
using Transducers
using Transducers: R_, start, next, complete, inner, xform, wrap, unwrap, wrapping

include("utils.jl")

export LinearStateSpaceModel
export Simulator
include("statespacemodel.jl")

export LinearObservation
export observe
include("observer.jl")

export KalmanFilter
include("filter.jl")

export energy
include("energy.jl")
end # module
