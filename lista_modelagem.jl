using LinearAlgebra

function exercise_1()
    user_feature_matrix = [ 0.9 0.1
                            0.8 0.2
                            0.3 0.7
                            0.6 0.4
                            0 1 ]

    movie_feature_matrix = [ 0.9 0.1
                            0.1 0.9
                            0.5 0.5 
                            0 1
                            0.2 0.8]


    user_movie_matrix = user_feature_matrix * movie_feature_matrix'

    println("O usuário E gosta ", user_movie_matrix[5, 2], " de Rocky.")
    println("A matriz que descreve o gosto de cada usuário é: ")
    for i in 1:5
        for j in 1:5
            number = round(user_movie_matrix[i, j], sigdigits = 2)
            if length(string(number)) == 3
                print(number, "0 ")
            else
                print(number, " ")
            end
        end
        print('\n')
    end

end

function exercise_2()
    A = [ 50 100
          20 15
          2 1]
    
    b_letra_a = [350; 65; 5]
    b_letra_b = [350; 65; 8]

    println(A\b_letra_a)
    println(A\b_letra_b)

end

function calcula_interpolacao(A, b)
    constantes = A\b

    if norm(A * constantes - b) < 0.01
        return constantes
    else
        return "Não existe"
    end
end

function exercise_3()
    println("a) ", calcula_interpolacao([1 1; 4 1], [3; 5]))
    println("b) ", calcula_interpolacao([1 1; 4 1; 2 1], [3; 5; 4]))
    println("c) ", calcula_interpolacao([1^2 1 1; 4^2 4 1], [3; 5]))
    println("d) ", calcula_interpolacao([1^2 1 1; 4^2 4 1; 2^2 2 1; 3^2 3 1], [3; 5; 4; 5]))
end

function passa_tempo_voto(v, i)
    if i == 0
       return v
    else
        return [0.7 0.2; 0.3 0.8] * passa_tempo_voto(v, i - 1)
    end
end

function exercise_4()
    votantes = [500.0; 500.0]

    println(passa_tempo_voto(votantes, 15))

end

# exercise_1()

# exercise_2()

# println("Resolução do exercício 3: ")
# exercise_3()

exercise_4()

