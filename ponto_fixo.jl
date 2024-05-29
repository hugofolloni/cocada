using LinearAlgebra

function q22()
    println("Questão 22")

    matriz = [ 0    0.5   0.8
            0.8  0     0
            0    0.5   0]

    println("a) ", matriz)

    vetor = [250; 0; 0]

    println()
    println("b)")
    println(vetor)
    for i in 1:4
        vetor = matriz * vetor
        println(vetor)
    end

    println()
    println("c)")
    x = ponto_fixo(matriz, vetor, 1000)
    println(x)

    println()
    println("d) Utilizamos o método do ponto fixo, que por meio de repetidas iterações vai transformando o nosso vetor que descreve a população. Ele funciona pois a os autovalores da matriz são todos menores que 1, logo ela é convergente.")

end

function q23()
    println("Questão 23")
    println()
    matriz = [0 0 1 1/2
             1/3 0 0 0
             1/3 1 0 1/2 
             1/3 0 0 0 ]

    println("a) ", matriz)
    println()
    
    println("b)")
    println(roda_page_rank([100; 0; 0; 0], matriz))
    println(roda_page_rank([0; 100; 0; 0], matriz))
    println(roda_page_rank([0; 0; 100; 0], matriz))
    println(roda_page_rank([0; 0; 0; 100], matriz))
    println(roda_page_rank([25; 25; 25; 25], matriz))

    convergencia = acha_autovetor_associado_ao_maior_autovalor(matriz)

    println()
    println("Os resultados são similares para diversos estados iniciais. Utilizando o método das potências, que indica que a proporção é o autovetor associado ao autovalor de maior módulo, encontramos exatamente essa razão.")
    println(convergencia)

end

function q25()
    println("Questão 25")
    println()

    matriz = [1.01 0
            0.01 0.99]

    println("a)", matriz)
    println()

    println("b)")
    convergencia = acha_autovetor_associado_ao_maior_autovalor(matriz)
    println("Baseando-se no autovetor associado ao maior autovalor da matriz que define o sistema, sabemos que não existirá extinção. Isso se deve ao fato de que a proporção quando tende ao infinito ser completamente não-negativa.")
    println("Vetor de convergência> ", convergencia)
    println()

    vetor_teste = [10000, 1]
    println("c) Pra testar tal caso, começaremos com os vampiros com proporção ", vetor_teste[2], '/', vetor_teste[1], ".")
    vetor = ponto_fixo(matriz, vetor_teste, 10000)
    println("Ao fim de 10000 iterações, teremos que a proporção será de ",(100 * vetor[2] / (vetor[1] + vetor[2])))
    println("Como podemos ver, segue a mesma proporção do vetor de convergência descrito acina. Como passa de 1%, eles serão descobertos.")
end

function roda_page_rank(vetor, matriz)
    for i in 1:100
        vetor = matriz * vetor
    end
    return vetor
end

function ponto_fixo(M,c,passos)
  n, = size(M)  
  x=zeros(n) #chute é o vetor nulo
    for i=1:passos
      x=M*x+c
    end
    return x
end

function acha_autovetor_associado_ao_maior_autovalor(matriz)
    data = eigen(matriz)
    values = data.values
    max =  -Inf 
    max_index = -1
    for i in 1:length(values)
        if max < real.(values[i])
            max = real.(values[i])
            max_index = i
        end
    end
    # println("Maior autovalor ", max, " na posicão ", max_index)
    
    convergencia = real.(data.vectors[:,max_index ])
    return convergencia
end

q22()
println()
println()

q23()
println()
println()

q25()

