module calculations

using Unitful, QuadGK, PhysicalConstants.CODATA2018, LaTeXStrings

function q_2_6_1()
    println("Question 2.6.1:")
    L = 1
    left = 0.1
    right = 0.2
    ψ₁(z) = √(2 / L) * sin(π * z / L)
    integrand(z) = abs2(ψ₁(z))
    result, error = quadgk(integrand, left, right)
    println("Numerical probability:\t$result±$error")
    analytical_result = ((right - sin(2π * right) / (2π)) - (left - sin(2π * left) / (2π)))
    println("Analytical probability:\t$analytical_result")
    filename = "../assets/q_2_6_1.tex"
    open(filename, "w") do file
        write(file, "$(round(sigdigits=5, analytical_result))")
    end
    println("Output saved to $filename.\n")
end

function q_2_8_2()
    println("Question 2.8.2:")
    m = ElectronMass
    E = 0.5u"eV"
    ħ = ReducedPlanckConstant
    k = upreferred(√(2 * m * E / ħ^2))
    V₀ = 1u"eV"
    κ = upreferred(√(2 * m * (V₀ - E) / ħ^2))
    l = 1u"Å"
    C = 1u"Å^-1"
    p₁ = upreferred(C * abs2(2k / (k + 1im * κ)) * (exp(-2 * κ * l) / (-2κ) - 1 / (-2κ)))
    p₂ = upreferred(-C * abs2(2k / (k + 1im * κ)) * exp(-2 * κ * l) / (-2κ))
    println("Probability 1Å from the wall:\t\t$p₁")
    println("Probability beyond 1Å from the wall:\t$p₂")
    filename_1 = "../assets/q_2_8_2_a.tex"
    open(filename_1, "w") do file
        write(file, "$(round(sigdigits=5, p₁))")
    end
    println("Output saved to $filename_1.")
    filename_2 = "../assets/q_2_8_2_b.tex"
    open(filename_2, "w") do file
        write(file, "$(round(sigdigits=5, p₂))")
    end
    println("Output saved to $filename_2.")

    if p₁ > p₂
        conclusion = """It is more likely to find the electron within $(l) of the wall,
as \$$(round(sigdigits=5, p₁)) > $(round(sigdigits=5, p₂))\$."""
    elseif p₂ > p₁
        conclusion = """It is more likely to find the electron beyond $(l) of the wall,
as \$$(round(sigdigits=5, p₁)) < $(round(sigdigits=5, p₂))\$."""
    else
        conclusion = """It is equally likely to find the electron beyond or within $(l) of the wall,
as \$$(round(sigdigits=5, p₁)) = $(round(sigdigits=5, p₂))\$."""
    end
    println(conclusion)

    filename_3 = "../assets/q_2_8_2_conclusion.tex"
    open(filename_3, "w") do file
        write(file, "$conclusion")
    end
    println("Output saved to $filename_3.")
end

function main()
    q_2_6_1()
    q_2_8_2()
end

end


