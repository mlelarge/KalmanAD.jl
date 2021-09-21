function Gaussian(Q)
    cholesky(Q).L*randn(size(Q, 1))
end