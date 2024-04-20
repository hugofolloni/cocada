# Trabalho 1 - Computação Científica e Análise de Dados - Hugo Folloni Guarilha - 121085854

## Esse trabalho tem como objetivo encontrar os melhores parâmetros para funções:
## - Constante
## - Reta
## - Quadrática
## - Cúbica

## Para os pontos: (2, 1), (5, 10), (8, 11), (10, 4)

## Devemos minimizar os erros associados.

using LinearAlgebra

# Geração dos vetores base
A_0 = [2; 5; 8; 10]
vetor_unitario = [1; 1; 1; 1]
b = [1; 10; 11; 4]
# println("Foram gerados os vetores base para a resolução.")

# Constante
coeficientes_constante = vetor_unitario \ b
println("\nA constante encontrada é ", coeficientes_constante[1], ".")
erro_constante = norm((vetor_unitario * coeficientes_constante) - b)
println("O erro absoluto da constante encontrado é ", erro_constante)

# Reta
A_reta = hcat(A_0, vetor_unitario)
coeficientes_reta = A_reta \ b
println("\nA função afim encontrada é ", coeficientes_reta[1], "x + ", coeficientes_reta[2], ".")
erro_reta = norm((A_reta * coeficientes_reta) - b)
println("O erro absoluto afim encontrado é ", erro_reta)

# Quadrática
vetor_quadratico = zeros(4)
for i in 1:4
    vetor_quadratico[i] = A_0[i] ^ 2
end
A_quad = hcat(vetor_quadratico, A_0, vetor_unitario)
coeficientes_quad = A_quad \ b
println("\nA função quadrática encontrada é ", coeficientes_quad[1], "x² + ", coeficientes_quad[2], "x + ", coeficientes_quad[3], ".")
erro_quad = norm((A_quad * coeficientes_quad) - b)
println("O erro absoluto quadrático encontrado é ", erro_quad)

# Cúbica
vetor_cubico = zeros(4)
for i in 1:4
    vetor_cubico[i] = A_0[i] ^ 3
end
A_cub = hcat(vetor_cubico, vetor_quadratico, A_0, vetor_unitario)
coeficientes_cub = A_cub \ b
println("\nA função cúbica encontrada é ", coeficientes_cub[1], "x³ + ", coeficientes_cub[2], "x² + ", coeficientes_cub[3], "x + ", coeficientes_cub[4], ".")
erro_cub = norm((A_cub * coeficientes_cub) - b)
println("O erro absoluto cúbico encontrado é ", erro_cub)

# Plotagem dos erros (para rodar essa seção, você deve ter instalado o pacote Plots)
# using Plots 

# label = range(0, 3)
# errors = [erro_constante, erro_reta, erro_quad, erro_cub]
# plot(label, errors, title = "Erro associado ao grau da função", label = "Erro absoluto", linewidth = 3)

# Plotagem das funções com os pontos (para rodar essa seção, você deve ter instalado o pacote Plots)
# x = range(0, 15, length=100)

# function constante(x)
#     return 6.5
# end

# function reta(x)
#     return ([x 1] * coeficientes_reta)[1]
# end

# function quad(x)
#     return ([x^2 x 1] * coeficientes_quad)[1]
# end

# function cub(x)
#     return ([x^3 x^2 x 1] * coeficientes_cub)[1]
# end

# function create_y(function_type)
#     y = zeros(100)
#     for i in 1:100
#         y[i] = function_type(x[i])
#     end
#     return y
# end

# function plot_function(functions, labels)
#     plot(x, functions, title = "Plot das funções", label = labels)
#     plot!(A_0, b, seriestype=:scatter, label="Pontos")
# end

# plot_function([create_y(constante), create_y(reta), create_y(quad), create_y(cub)], ["Constante" "Afim" "Quadrática" "Cúbica"])