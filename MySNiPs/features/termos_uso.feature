#language:pt
Funcionalidade: Aceite de termos de uso
  Como usuário final
  Quando que eu fizer login pela primeira vez
  Gostaria de ler os termos e condições de uso do relatório
  Para que eu possa confirmar que estou satisfeito em aceitá-los

  Cenário: Exibe termos de uso no primeiro aceso ao relatório
    Dado que existe um usuário login:"novo_login_valido", senha:"senha_valida"
    E que o usuário "novo_login_valido" nunca logou
    E que estou na página "/login"
    Quando inserir "novo_login_valido" no campo login
    E inserir "senha_valida" no campo senha
    E clicar no botão "Log In"
    Então os termos de uso devem ser exibidos em um modal na tela

  Cenário: Não exibe os termos de uso em acessos subsequentes
    Dado que existe um usuário login:"login_valido", senha:"senha_valida"
    E que o usuário "login_valido" não está logado
    E que o usuário login: "login_valido", senha: "senha_valida" já logou ao menos uma vez
    E que estou na página "/login"
    Quando inserir "login_valido" no campo login
    E inserir "senha_valida" no campo senha
    E clicar no botão "Log In"
    Então os termos de uso não devem ser exibidos na tela