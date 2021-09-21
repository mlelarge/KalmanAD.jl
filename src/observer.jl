struct LinearObservation{T}
    H::Array{T}
    R::Array{T}
end

function observe(s, lo::LinearObservation)
    return lo.H * s + Gaussian(lo.R)
end