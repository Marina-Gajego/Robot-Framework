*** Settings ***
Library    RequestsLibrary
Library    Collections 

*** Variables ***
${URL_API}    https://fakerestapi.azurewebsites.net/api/v1/
&{BOOK_15}    title=Book 15
              #id=15
              #pageCount=1500

*** Keywords ***
Conectar a minha API
    Create Session    fakeAPI    ${URL_API}

Requisitar todos os livros
    ${RESPOSTA}    Get Request    fakeAPI    Books
    Log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Conferir o status code
    [Arguments]    ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}    

Conferir o reason
    [Arguments]    ${REASON_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.reason}    ${REASON_DESEJADO}  

Conferir se retorna uma lista com "${QTD_LIVROS}" livros
    Length Should Be    ${RESPOSTA.json()}    ${QTD_LIVROS}

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}    Get Request    fakeAPI    Books/${ID_LIVRO}
    Log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Conferir se retorna todos os dados corretor do livro 15
    # Dictionary Should Contain Item    ${RESPOSTA.json()}    id    ${BOOK_15.id}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title    ${BOOK_15.title}
    # Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount    ${BOOK_15.pageCount}
    Should Not Be Empty    ${RESPOSTA.json()["description"]}
    Should Not Be Empty    ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty    ${RESPOSTA.json()["publishDate"]}

Cadastrar um novo livro
    ${HEADERS}    Create Dictionary    content-type=application/json
    ${RESPOSTA}    Post Request    fakeAPI    Books    
    ...                            data={"id": 0, "title": "teste", "description": "teste", "pageCount": 250, "excerpt": "teste", "publishDate": "2022-12-19T20:11:06.540Z"}
    ...                            headers=${HEADERS}
    Log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}
Alterar o livro "${ID_LIVRO}"
    ${HEADERS}    Create Dictionary    content-type=application/json
    ${RESPOSTA}    Put Request    FakeAPI    v1/Books/${ID_LIVRO}
    ...                data={"id": 0,"title": "string","description": "string","pageCount": 0,"excerpt": "string","publishDate": "2022-12-01T04:49:48.916Z"}
    ...                headers=${HEADERS}
    Log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Deletar o livro "${ID_LIVRO}"
    ${RESPOSTA}    Delete Request    FakeAPI    v1/Books/${ID_LIVRO}
    Log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Conferir Status Code
    [Arguments]    ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

Consultar se livro foi deletado
    Should Be Equal    ${RESPOSTA.text}    ${EMPTY}


    