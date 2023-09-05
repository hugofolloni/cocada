using LinearAlgebra

# Dada uma matrix A_nxn, retorna uma matrix Lower e uma matrix Upper que, multiplicadas, resultam em A. Útil para pré-processar dados.
function decomp_lu(A)
    ### Para cada iteração, pega a primeira coluna e seta as próximas como combinação linear. Salva as bases e os vetores em matrizes que serão multiplicadas.
    max = size(A)[1]
    L = zeros(size(A))
    U = zeros(size(A))
    for i in 1:max
        base = A[:,i]/A[i,i]
        vector = A[i,:]'
        A = A - base * vector
        L[:,i] = base
        U[i,:] = vector    
    end
    return L, U
end

function calc_inversa(L, U)
    tamanho = size(L)[1]
    inversa = zeros(tamanho, tamanho)
    identidade = Matrix{Int}(I, tamanho, tamanho)
    
    for i in 1:tamanho
        y = L\identidade[:,i]
        x = U\y
        inversa[:,i] = x
    end
    return inversa
end
