struct LinearStateSpaceModel{T}
    A::Matrix{T}
    B::Matrix{T}
    Q::Matrix{T}
end

function LinearStateSpaceModel(A::Matrix, Q::Matrix)
    LinearStateSpaceModel(A,zeros(size(A,1),1),Q)
end

struct Simulator <: Transducer
    lssm::LinearStateSpaceModel
end

function Transducers.start(rf::R_{Simulator}, result)
    private_state = (0, zeros(size(xform(rf).lssm.A,1)))
    return wrap(rf, private_state, start(inner(rf), result))
end

function step(l::LinearStateSpaceModel, x, input)
    l.A*x + l.B*input + Gaussian(l.Q)
end

function Transducers.next(rf::R_{Simulator}, result, input)
    wrapping(rf, result) do st, iresult
        (n, x) = st
        n += 1
        new_x = step(xform(rf).lssm,x,input)
        iresult = next(inner(rf), iresult, new_x)
        return (n, new_x), iresult
    end
end