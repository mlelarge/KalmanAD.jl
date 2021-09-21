estimates = collect(KalmanFilter(lssm, lobs), measures)
mu = [e[1] for e in estimates]
emp_var = empirical_var(mu-states,n,k)
@test emp_var < n*2.