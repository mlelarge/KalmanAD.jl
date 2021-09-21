differ = -(@view(states[1:end-1]), @view(states[2:end]))
emp_var = empirical_var(differ,n, k)#sum(sum([d .^2 for d in differ]))/(2*k)
epsilon = 5*q/√(n*k)
@test abs(emp_var-q) < epsilon
