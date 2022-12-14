#
Siga os seguintes passos:
Declare uma variável do tipo lista com vários números
Crie uma keyword que percorra essa lista usando o FOR
Dentro do FOR, faça um bloco IF que imprima no Log a frase "Eu sou o número 5!" e "Eu sou o número 10!", ou seja, só pode imprimir quando o número atual da lista for 5 ou 10.
Use o ELSE para imprimir no Log a frase "Eu não sou o número 5 e nem o 10!"
#

*** Variables ***
@{LISTA_NUMEROS}    1    2    3    4    5    6    7    8    9    10

*** Test Cases ***
Teste usando o FOR
    Teste com uma lista de numeros

*** Keywords ***
Teste com uma lista de numeros
    Log To Console  ${\n}
    FOR    ${NUMEROS}    IN    @{LISTA_NUMEROS}
        IF    ${NUMEROS} == 5
            Log To Console    "Eu sou o número 5!"
        ELSE IF    ${NUMEROS} == 10
            Log To Console    "Eu sou o número 10!"
        ELSE
            Log To Console    "Eu não sou o número 5 e nem o 10!"
        END
        
    END

  Log To Console  ${\n}

# Existem outros modos de fazer:
    FOR    ${numero}    IN   @{NUMEROS}
        IF  ${numero} == 5 or ${numero} == 10
            Log To Console    Eu sou o número ${numero}!
        ELSE
            Log To Console    Eu não sou o número 5 e nem o 10!
        END
    END

    Log To Console  ${\n}
    FOR    ${numero}    IN   @{NUMEROS}
        IF  ${numero} in (5, 10)
            Log To Console    Eu sou o número ${numero}!
        ELSE
            Log To Console    Eu não sou o número 5 e nem o 10!
        END              
    END
