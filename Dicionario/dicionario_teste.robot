*** Settings ***
Documentation    Essa switch imprime todos os meses do ano
Resource         dicionario_resources.robot

*** Test Cases ***
Caso de teste 01 - Imprimir meses do ano e seus dias
    [Documentation]    Esse teste imprime todos os meses do ano
    [Tags]             meses    dias
    Imprimir todos os meses do ano e seus respectivos dias