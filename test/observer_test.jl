emp_var = empirical_var(measures-states,n,k)
epsilon = 5*r/√(n*k)
@test abs(emp_var-r) < epsilon 