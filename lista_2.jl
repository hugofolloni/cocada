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
    
# Nesse método, por meio da decomposição LU de uma matrix A, podemos achar sua inversa.
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

# Nesse método, por meio da decomposição LU de uma matrix A, podemos achar seu determinante.
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

function fatoracao_qr_3_x_3(A)
        q = zeros(size(A)[1], size(A)[2])
        r = zeros(size(A)[1], size(A)[2])
        
        r[1, 1] = norm(A[:,1])
        q[:,1] = A[:,1] / r[1, 1]
        r[1, 2] = A[:,2]' * q[:,1]
        p12 = r[1, 2] * q[:,1]
        p22 = A[:,2] - p12
        r[2, 2] = norm(A[:,2])
        q[:,2] = p22/r[2, 2]
        r[1, 3] = A[:,3]' * q[:,1]
        p13 = r[1, 3] * q[:,1]
        r[2, 3] = A[:,3]' * q[:,2]
        p23 = r[2, 3] * q[:,2]
        p33 = A[:,3] - (p13 + p23)
        r[3, 3] = norm(A[:, 3])
        q[:,3] = p33/r[3, 3]
        
        return q, r
end
