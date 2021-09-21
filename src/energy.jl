function energy(v, S)
    1/2*(dot(v,inv(S)*v) + log(det(S)))
end

#to do: add prior
function energy(estimates)
    foldxl(+, estimates |> Map(x -> x[end-1:end]) |> Map(x -> energy(x...)))
end