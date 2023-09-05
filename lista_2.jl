using LinearAlgebra

# Dada uma matrix A_nxn, retorna uma matrix Lower e uma matrix Upper que, multiplicadas, resultam em A. Útil para pré-processar dados.
function decomp_lu(A)
    ### Para cada iteração, pega a primeira coluna e seta as próximas como combinação linear. Salva as bases e os vetores em matrizes que serão multiplicadas.
    max = size(A)[1]
    L = zeros(size(A))
    U = zeros(size(A))
    for i in 1:max
        if A[i,i] != 0
            base = A[:,i]/A[i,i] 
        else
            base = zeros(max, 1)
        end        
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

function calc_determinante(L, U)
    tamanho = size(L)[1]
    detL = 1
    detU = 1
    for i in 1:tamanho
        detL *= L[i, i]
        detU *= U[i, i]
    end
    return detL * detU
end

# Para a questão 11 da lista de exercícios, alguns métodos foram implementados
function generate_matrix(tamanho)
    x = randn(tamanho, tamanho)
    y = randn(tamanho, tamanho)
    Q,r = qr(x)
    Z,r = qr(y)    
    L = zeros(tamanho, tamanho)
    for i in 1:tamanho
        for j in 1:tamanho
            if i >= j
                L[i, j] = rand(Int) % 100
            end
        end
    end    
    U = zeros(tamanho, tamanho)
    for i in 1:tamanho
        for j in 1:tamanho
            if i <= j
                U[i, j] = rand(Int) % 100
            end
        end
    end 
    b = rand(tamanho, 1)
    return Q, Z, L, U, b
end

# Para resolução, dados Q e R (ambas matrizes ortogomais), L (Lower) e U (Upper), alem do vetor b, todos gerados randômicamente pelo método anterior, acharmoos Ax = Lb, tal que A = LLQUZ'
function acha_x(Q, Z, L, U, b)
    A = L * L * Q * U * Z'
    
    y = L\b
    l = Q'y
    m = U\l
    x = Z * m
    return A, x
end
