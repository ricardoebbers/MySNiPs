#language:pt
@javascript
Funcionalidade: Acesso ao relatório por login
  Como usuário final
  Para ter garantia que só eu acessarei meu relatório
  Eu quero acessar o sistema através de meu login e senha

  Contexto:
    Dado que existe um usuário login:"1123580", senha:"senha_valida"

  Cenário: Redireciona para relatório quando login e senha são válidos
    Dado que estou na página "/login"
    Quando inserir "1123580" no campo login
    E inserir "senha_valida" no campo senha
    E clicar no botão "Log In"
    Então devo ser redirecionado para "/report"
  
  Cenário: Permanece em "/login" quando senha inserida for incorreta
    Dado que estou na página "/login"
    Quando inserir "1123580" no campo login
    E inserir "senha_errada" no campo senha
    E clicar no botão "Log In"
    Então devo receber notificação que o login falhou
    E devo permanecer em "/login"

  Cenário: Permanece em "/login" quando login inserido for inválido
    Dado que estou na página "/login"
    Quando inserir "login_invalido" no campo login
    E inserir "senha_qualquer" no campo senha
    E clicar no botão "Log In"
    Então devo receber notificação que o login falhou
    E devo permanecer em "/login"

  Cenário: Permanece em "/login" quando login estiver em branco
    Dado que estou na página "/login"
    Quando inserir "" no campo login
    E inserir "senha_qualquer" no campo senha
    E clicar no botão "Log In"
    Então devo receber notificação que o login falhou
    E devo permanecer em "/login"

  Cenário: Permanece em "/login" quando senha estiver em branco
    Dado que estou na página "/login"
    Quando inserir "1123580" no campo login
    E inserir "" no campo senha
    E clicar no botão "Log In"
    Então devo receber notificação que o login falhou
    E devo permanecer em "/login"

  Cenário: Redireciona para "/report" quando tentar acessar "/login" estando logado
    Dado que estou na página "/"
    E que o usuário login:"1123580", senha:"senha_valida" está logado
    Quando acessar "/login"
    Então devo ser redirecionado para "/report"
