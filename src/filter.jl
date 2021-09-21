struct KalmanFilter <: Transducer
    lssm::LinearStateSpaceModel
    lobs::LinearObservation
end

function predict(l::LinearStateSpaceModel,m,P)
    l.A*m, l.A*P*l.A'+l.Q
end

function update(l::LinearObservation,y,m,P)
    v = y-l.H*m
    S = l.H*P*l.H' + l.R
    K = P*l.H'*inv(S)
    mu = m + K*v 
    Pu = P - K*S*K'
    return mu, Pu, v, S
end

function kalman(lssm::LinearStateSpaceModel, lo::LinearObservation,y,m,P)
    m_i,P_i = predict(lssm,m,P)
    update(lo,y,m_i,P_i)
end

function Transducers.start(rf::R_{KalmanFilter}, result)
    private_state = (zeros(size(xform(rf).lssm.A,1)), one(xform(rf).lssm.A))
    return wrap(rf, private_state, start(inner(rf), result))
end

function Transducers.next(rf::R_{KalmanFilter}, result, input)
    wrapping(rf, result) do st, iresult
        (m, P) = st
        mu, Pu, v, S = kalman(xform(rf).lssm, xform(rf).lobs, input, m, P)
        iresult = next(inner(rf), iresult, (mu, Pu, v, S))
        return (mu, Pu), iresult
    end
end