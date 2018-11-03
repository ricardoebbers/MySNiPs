# Compilação das Histórias de Usuário

# 1. Landing page

<span style="color:green">

## 1.01. Conteúdo da landing page
**Como** usuário final  
**Antes** de fazer a contratação do serviço  
**Para** entender os benefícios de fazer uma análise genética  
**Gostaria** de ver uma página simples de ler e que contenha recursos visuais explicando a que tipos de informação terei acesso

</span>

### 1.01.01. Barra de navegação
**Como** usuário final  
**Quando** acessar o site  
**Gostaria** de ter uma barra de navegação no topo com a logo MySNiPs e links para as seções  
**Para** ir rapidamente à parte do site que me interessa

* __1.01.01.01. Link no logotipo__  
**Dado** que a barra de navegação está visível  
**Quando** clicar no logotipo MySNiPs  
**Então** devo ser redirecionado para a página principal

* __1.01.01.02. Links da barra de navegação__  
**Dado** que estou na página inicial  
**Quando** clicar em um dos atalhos na barra de navegação (inicio, relatos ou vantagens)  
**Então** meu navegador deve rolar para a seção correspondente

* __1.01.01.03. Link para tela de login__  
**Dado** que estou na página inicial  
**Quando** clicar no link "login"  
**Então** devo ser redirecionado para a página de login

* __1.01.01.04. Link para relatório de exemplo__  
**Dado** que estou na página inicial  
**Quando** clicar no link "amostra"  
**Então** devo ser redirecionado para o relatório de exemplo

* __1.01.01.05. Navbar fixa__  
**Dado** que estou na página inicial  
**Quando** rolar até o fim da página  
**Então** a navbar deve permanecer no topo do navegador

### 1.01.02. Links a partir do banner
**Como** usuário final  
**Quando** carregar a página principal  
**Para** ter facilidade em navegação  
**Gostaria** de ver imediatamente o botão para fazer login  
**E** o botão para testar o relatório de exemplo

* __1.01.02.01. Botão no banner para a tela de login__  
**Dado** que estou na página inicial  
**E** existe um botão "login" no banner  
**Quando** eu clicar neste botão  
**Então** devo ser direcionado para a página de login

* __1.01.02.02. Botão no banner para a tela de relatório exemplo__  
**Dado** que estou na página inicial  
**E** existe um botão "amostra" no banner  
**Quando** eu clicar neste botão  
**Então** devo ser direcionado para o relatório de exemplo

### 1.01.03. Depoimentos de usuários
**Como** usuário final  
**Quando** acessar a página principal  
**Gostaria** de ver depoimentos de outros usuários  
**Para** validar a escolha pela aquisição do serviço

* __1.01.03.01. Depoimentos de usuários__  
**Dado** que estou na página inicial  
**Quando** a página terminar de carregar  
**Então** devo ver uma seção contendo depoimentos de outros usuários

### 1.01.04. Resumo dos benefícios
**Como** usuário final  
**Quando** acessar a página principal  
**Gostaria** de ver os benefícios associados ao serviço resumidos em tópicos  
**Para** entender rapidamente os ganhos que terei ao fazer a aquisição

* __1.01.04.01. Resumo dos benefícios__  
**Dado** que estou na página inicial  
**Quando** a página terminar de carregar  
**Então** devo ver cards contendo uma imagem e uma frase cada contendo os resumos dos benefícios

### 1.01.05. Conteúdo do footer
**Como** usuário final  
**Quando** rolar até o final da página principal  
**Gostaria** de ver os dados de contato  
**Para** poder entrar em contato com os desenvolvedores quando necessário

* __1.01.05.01. Conteúdo do footer__  
**Dado** que estou na página inicial  
**Quando** rolar a página até o final  
**Então** devo ver uma div contendo informações de contato

## 1.02. Disponibilização de relatórios-exemplos
**Como** usuário final  
**Para** ter ainda mais certeza do que receberei ao contratar o serviço  
**Gostaria** de ter acesso a relatórios fictícios de exemplo

* __1.02.01. Relatório-exemplo acessível sem login__  
**Dado** que estou na página inicial  
**E** não estou logado  
**Quando** clicar em um dos links para o relatório-exemplo  
**Então** devo ser redirecionado para a página do relatório-exemplo

# 2. Relatório

<span style="color:green">

## 2.01. Geração do relatório
**Como** usuário final  
**Dado** que eu já fiz a coleta de material genético previamente  
**Eu** gostaria de ter acesso a um relatório contendo informações relevantes derivadas desse material e pesquisas científicas, que seja possível filtrar e pesquisar e tenha links para recursos extras  
**Para** que eu possa aprender mais sobre mim mesmo

</span>


## 2.02. Acesso ao relatório por login
**Como** usuário final  
**Para** ter garantia que só eu acessarei meu relatório  
**Gostaria** de poder acessar o sistema através de meu login e senha

* __2.02.01. Redireciona para relatório quando login e senha são válidos__  
**Dado** que estou na página de login  
**E** não estou logado  
**Quando** inserir um login válido  
**E** inserir uma senha válida  
**E** clicar em logar  
**Então** devo ser redirecionado para o relatório  
**E** meu Id único deve ser exibido no relatório

* __2.02.02. Permanece em "/login" quando senha inserida for incorreta__  
**Dado** que estou na página de login  
**E** não estou logado  
**Quando** inserir um login válido  
**E** inserir uma senha inválida  
**E** clicar em logar  
**Então** devo receber notificação que o login falhou  
**E** devo permanecer em "/login"

* __2.02.03. Permanece em "/login" quando login inserido for inválido__  
**Dado** que estou na página de login  
**E** não estou logado  
**Quando** inserir um login inválido  
**E** inserir uma senha qualquer  
**E** clicar em logar  
**Então** devo receber notificação que o login falhou  
**E** devo permanecer em "/login"

* __2.02.04. Permanece em "/login" quando login ou senha estiverem em branco__  
**Dado** que estou na página de login  
**E** não estou logado  
**Quando** deixar o campo "login" vazio  
**OU** deixar o campo "senha" vazio  
**E** clicar em logar  
**Então** devo receber notificação que o login falhou  
**E** devo permanecer em "/login"

* __2.02.05. Não é possível acessar "/relatorio" sem estar logado__  
**Dado** que estou na página inicial  
**E** não estou logado  
**Quando** tentar acessar "/relatorio"  
**Então** devo ser redirecionado para "/login"

* __2.02.06. Redireciona para "/relatorio" quando tentar acessar "/login" estando logado__  
**Dado** que estou na página inicial  
**E** estou logado  
**Quando** tentar acessar "/login"  
**Então** devo ser redirecionado para "/relatorio"

## 2.03. Aceite de termos de uso
**Como** usuário final  
**Assim** que eu fizer login pela primeira vez  
**Gostaria** de ler os termos e condições de uso do relatório  
**Para** que eu possa confirmar que estou satisfeito em aceitá-los

* __2.03.01. Exibe termos de uso no primeiro aceso ao relatório__  
**Dado** que estou na página de login  
**E** não estou logado  
**E** nunca loguei anteriormente  
**Quando** inserir um login válido  
**E** inserir uma senha válida  
**E** clicar em logar  
**Então** devo ser redirecionado para o relatório  
**E** Os termos de uso devem ser exibidos em um modal

* __2.03.02. Não exibe os termos de uso em acessos subsequentes__  
**Dado** que estou na página de login  
**E** não estou logado  
**E** já loguei ao menos uma vez anteriormente  
**Quando** inserir um login válido  
**E** inserir uma senha válida  
**E** clicar em logar  
**Então** devo ser redirecionado para o relatório  
**E** Os termos de uso não devem ser exibidos

<span style="color:red">

## 2.04. Guia explicativo do relatório
**Como** usuário final  
**Ao** acessar o meu relatório pela primeira vez  
**Gostaria** de ter um guia visual explicando o que é cada parte do relatório  
**E** as ações que posso tomar  
**Para** que eu possa usar o sistema com maior facilidade

</span>

<span style="color:red">

## 2.05. Filtros no relatório
**Como** usuário final  
**Para** que eu consiga encontrar com maior facilidade as informações mais relevantes para mim  
**Gostaria** de poder filtrar os dados exibidos na tela

</span>

## 2.06. Buscas no relatório
**Como** usuário final  
**Gostaria** de poder realizar buscas com base no conteúdo do relatório  
**Para** que eu tenha acesso facilitado às informações que mais me interessam

* __2.06.01. Busca por strings__  
**Dado** que estou na página relatório  
**E** estou logado  
**E** tiver um campo de buscas visível  
**Quando** eu procurar por STRING  
**E** clicar no botão de procurar  
**Então** apenas os cards contendo a string STRING devem permanecer na tela

* __2.06.02. Opção de limpar busca__  
**Dado** que estou na página relatório  
**E** estou logado  
**E** tiver um campo de buscas visível  
**E** eu tiver feito uma busca previamente  
**Quando** eu clicar no botão "Limpar busca"  
**Então** o filtro aplicado anteriormente deve ser removido  
**E** todos os cards devem voltar a serem exibidos

* __2.06.03. Feedback quando resultado da busca for vazio__  
**Dado** que estou na página relatório  
**E** estou logado  
**E** tiver um campo de buscas visível  
**Quando** eu procurar por STRING  
**E** nenhum card conter STRING  
**Então** nenhum card deve ser exibido  
**E** o texto contendo "Não encontramos resultado para STRING" deve ser exibido

<span style="color:red">

## 2.07. Relatório com categorias
**Como** usuário final  
**Ao** ler meu relatório  
**Gostaria** de poder agrupar as informações por categorias

</span>

## 2.08. Navegação em páginas no relatório
**Como** usuário final  
**Para** que eu tenha acesso rápido às informações  
**Gostaria** que o relatório só carregasse uma parcela das informações por vez  
**E** que eu possa mudar de página quando preciso

* __2.08.01. Possibilidade de ir até uma página específica__  
**Dado** que estou na página relatório  
**E** estou logado  
**E** existe botões de paginação visíveis  
**Quando** eu clicar na página "5"  
**Então** a página "5" deve carregar  

* __2.08.02. Possibilidade de ir até a primeira página__  
**Dado** que estou na página relatório  
**E** estou logado  
**E** existe botões de paginação visíveis  
**E** eu não estou na primeira página
**Quando** eu clicar no botão "first"  
**Então** a primeira página deve carregar  

* __2.08.03. Possibilidade de ir até a próxima página__  
**Dado** que estou na página relatório  
**E** estou logado  
**E** existe botões de paginação visíveis  
**E** eu estou na primeira página
**Quando** eu clicar no botão "next"  
**Então** a página "2" deve carregar  

* __2.08.04. Possibilidade de ir até a última página__  
**Dado** que estou na página relatório  
**E** estou logado  
**E** existe botões de paginação visíveis  
**E** eu não estou na última página
**Quando** eu clicar no botão "last"  
**Então** a última página deve carregar  

* __2.08.05. Possibilidade de ir até a página anterior__  
**Dado** que estou na página relatório  
**E** estou logado  
**E** existe botões de paginação visíveis  
**E** eu estou na página "5"
**Quando** eu clicar no botão "previous"  
**Então** a página "4" deve carregar  

<span style="color:red">

## 2.09. Relatório responsivo
**Como** usuário final  
**Gostaria** de poder navegar no relatório a partir do navegador do meu smartphone  
**Para** que eu possa usufruir do sistema em qualquer lugar

</span>

# 3. GenomikAPI

## 3.01. Documentação da API
**Como** membro da equipe técnica do laboratório  
**Para** saber como usar a API para envio dos dados genéticos  
**Gostaria** de ter acesso a uma documentação concisa e com exemplos de uso

## 3.02. Disponibilização de API
**Como** membro da equipe técnica do laboratório  
**Considerando** que eu tenho uma chave de acesso  
**Gostaria** de poder enviar via API os dados resultantes do sequenciamento genético para serem analisados e gerarem o relatório para o cliente final  
**Para** que assim eu possa automatizar o processo internamente
