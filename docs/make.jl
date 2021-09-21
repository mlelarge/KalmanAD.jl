using Documenter, KalmanAD

makedocs(
    modules = [KalmanAD],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Marc Lelarge",
    sitename = "KalmanAD.jl",
    pages = Any["index.md"]
    # strict = true,
    # clean = true,
    # checkdocs = :exports,
)

deploydocs(
    repo = "github.com/mlelarge/KalmanAD.jl.git",
    push_preview = true
)
