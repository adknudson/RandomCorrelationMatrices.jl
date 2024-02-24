using Test, Aqua
using RandomCorrelationMatrices
using LinearAlgebra: cholesky, diag, Diagonal, Hermitian
using Statistics: mean, median, std


Aqua.test_all(RandomCorrelationMatrices; ambiguities=false)
Aqua.test_ambiguities(RandomCorrelationMatrices)


@testset "Random Correlation Matrix" begin
    # Test the basic interface
    @test_nowarn randcormatrix(10, 4)
end


@testset "Random Covariance Matrix" begin
    s = [100, 200, 300, 400, 500]
    n = length(s)
    η = 10

    @test_nowarn randcovmatrix(n, η, s)

    Σ = randcovmatrix(n, η, s)
    chol = cholesky(Hermitian(Σ))
    samples = 100_000
    results = zeros(5, samples)
    for i in axes(results, 2)
        results[:,i] = chol.L * randn(5)
    end

    # TODO: what property is this testing?
    means = mean(results, dims=2)
    @test all(abs.(means) .<= 5)

    # TODO: what property is this testing?
    stddevs = std(results, dims=2)
    @test all(abs.(stddevs - s) .<= 5)
end
