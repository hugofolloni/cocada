# Dada uma matrix A_nxn, retorna uma matrix Lower e uma matrix Upper que, multiplicadas, resultam em A. Útil para pré-processar dados.
function decomp_lu(A)
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
