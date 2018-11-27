#language:pt
@javascript
Funcionalidade: Filtros no relatório
  Como usuário final
  Para que eu consiga encontrar com maior facilidade as informações mais relevantes para mim
  Gostaria de poder filtrar os dados exibidos na tela.

  Contexto:
    Dado que existe um usuário login:"1123580", senha:"senha_valida"
    E que o usuário login:"1123580", senha:"senha_valida" está logado
    E que o usuário login:"1123580" possui um card "id1" com "magnitude": "0"
    E que o usuário login:"1123580" possui um card "id2" com "magnitude": "0"
    E que o usuário login:"1123580" possui um card "id3" com "repute": "1"
    E que o usuário login:"1123580" possui um card "id4" com "repute": "2"
    E que o usuário login:"1123580" possui um card "id5" com "summary": "teste"
    E que o usuário login:"1123580" possui um card "id6" com "summary": "etset"
  
  Cenário: Filtra cards pela string buscada
    Dado que estou na página "/report"
    E que existe um campo de busca
    Quando eu digitar "teste" no campo de busca
    E clicar no botão pesquisar
    Então apenas o card que contém "teste" deve ser exibido

  Cenário: Filtra cards por repute
    Dado que estou na página "/report"
    E que existe um botão para filtrar por repute
    Quando eu clicar no botão repute good
    E clicar no botão pesquisar
    Então apenas o card que contém repute good deve ser exibido
  
  Cenário: Reseta Filtros
    Dado que estou na página "/report"
    E que existe um botão para resetar filtros
    Quando eu clicar no botão de resetar filtros
    Então todos os cards devem ser exibidos
