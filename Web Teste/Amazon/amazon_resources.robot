*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${url}                 https://www.amazon.com.br
${MENU_ELETRONICOS}    //a[@href='/Eletronicos-e-Tecnologia/b/?ie=UTF8&node=16209062011&ref_=nav_cs_electronics'][contains(.,'Eletrônicos')]
${TITULO_PAGINA}       //h1[contains(.,'Eletrônicos e Tecnologia')]
${TEXTO_HEADER_ELETRONICOS}    Eletrônicos e Tecnologia
${BTN_PESQUISA}      //input[contains(@type,'submit')]
${BTN_CARRINHO}    //input[contains(@name,'submit.add-to-cart')]

    
*** Keywords ***
Abrir o navegador
    Open Browser    browser=chrome
    Maximize Browser Window    

Fechar o navegador
    Close Browser

Acessar a home page do site Amazon.com.br
    Go To    url=${url}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}

Entrar no menu "Eletrônicos"
    Click Element    locator=${MENU_ELETRONICOS}
    Wait Until Element Is Visible    locator=${TITULO_PAGINA}

Verificar se aparece a frase "${TITULO}"
    Wait Until Page Contains    text=${TITULO}

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=//a[@aria-label='${NOME_CATEGORIA}']

Digitar o nome de produto "${NOME_PRODUTO}" no campo de pesquisa
    Click Element    locator=${BTN_PESQUISA}
    Wait Until Element Is Visible    locator=twotabsearchtextbox
    Input Text    locator=twotabsearchtextbox    text=${NOME_PRODUTO}

Clicar no botão de pesquisa
    Click Element    locator=${BTN_PESQUISA}

Verificar o resultado da pesquisa se está listando o produto pesquisado "Console Xbox Series S"
    Wait Until Element Is Visible    locator=//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'Console Xbox Series S')]

#Casos de teste em BDD
Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br

Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"
    Verificar se aparece a frase "Eletrônicos e Tecnologia"

Então o título da página deve ficar "${TITULO}"
    Title Should Be    title=${TITULO}

E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"

E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"

#Caso de teste 02
Quando pesquisar pelo produto "${NOME_PRODUTO}"
        Click Element    locator=${BTN_PESQUISA}
        Wait Until Element Is Visible    locator=twotabsearchtextbox
        Input Text    locator=twotabsearchtextbox    text=${NOME_PRODUTO}
        Click Element    locator=${BTN_PESQUISA}

Então o título da página deve ficar "${TITULO}"
    Title Should Be    title=${TITULO}

E um produto da linha "Xbox Series S" deve ser mostrado na página
    Wait Until Element Is Visible    locator=//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'Console Xbox Series S')]

Adicionar o produto "Console Xbox Series S" no carrinho
    Click Element    locator=//h2[@class='a-size-mini a-spacing-none a-color-base s-line-clamp-4'][contains(.,'Console Xbox Series S')] 
    Wait Until Element Is Visible    locator=//span[@class='a-size-large product-title-word-break'][contains(.,'Console Xbox Series S')]
    Click Element    locator=${BTN_CARRINHO}

Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso
    Wait Until Element Is Visible    locator=//span[@class='a-size-medium-plus a-color-base sw-atc-text a-text-bold'][contains(.,'Adicionado ao carrinho')]

Remover o produto "Console Xbox Series S" do carrinho
    Click Element    locator=//a[contains(@data-csa-c-type,'button')]
    Wait Until Element Is Visible    locator=//span[@class='a-truncate-cut'][contains(.,'Console Xbox Series S')]
    Click Element    locator=//input[contains(@name,'submit.delete.Ca6becb22-cd81-41e1-a632-72d9ede43bd9')]

Verificar se o carrinho fica vazio
    Wait Until Element Is Visible    locator=//h1[@class='a-spacing-mini a-spacing-top-base'][contains(.,'Seu carrinho de compras da Amazon está vazio.')]

#Caso de teste 3 em BDD
Quando adicionar o produto "Console Xbox Series S" no carrinho
    Quando pesquisar pelo produto "Xbox Series S"
    Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    E um produto da linha "Xbox Series S" deve ser mostrado na página
    Adicionar o produto "Console Xbox Series S" no carrinho

Então o produto "Console Xbox Series S" deve ser mostrado no carrinho
    Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso

#Caso de teste 4 em BDD
E existe o produto "Console Xbox Series S" no carrinho
    Quando adicionar o produto "Console Xbox Series S" no carrinho
    Então o produto "Console Xbox Series S" deve ser mostrado no carrinho

Quando remover o produto "Console Xbox Series S" do carrinho
    Remover o produto "Console Xbox Series S" do carrinho

Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio

