using Unitful, QuadGK

function q_2_6_1()
    L = 1
    left = 0.1
    right = 0.2
    ψ₁(z) = √(2 / L) * sin(π * z / L)
    integrand(z) = abs2(ψ₁(z))
    result, error = quadgk(integrand, left, right)
    println("Numerical probability:\t$result±$error")
    analytical_result = ((right - sin(2π * right) / (2π)) - (left - sin(2π * left) / (2π)))
    println("Analytical probability:\t$analytical_result")
end

q_2_6_1()
