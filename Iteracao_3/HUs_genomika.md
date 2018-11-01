# Compilação das Histórias de Usuário

## 1. Landing page

### 1.01. Conteúdo da landing page
**Como** usuário final  
**Antes** de fazer a contratação do serviço  
**Para** entender os benefícios de fazer uma análise genética  
**Gostaria** de ver uma página simples de ler e que contenha recursos visuais explicando a que tipos de informação terei acesso

#### 1.01.01. Barra de navegação
**Como** usuário final  
**Quando** acessar o site  
**Gostaria** de ter uma barra de navegação no topo com a logo MySNiPs e links para as seções  
**Para** ir rapidamente à parte do site que me interessa

##### 1.01.01.01. Link no logotipo
**Dado** que a barra de navegação está visível  
**Quando** clicar no logotipo MySNiPs  
**Então** devo ser redirecionado para a página principal

##### 1.01.01.02. Links da barra de navegação
**Dado** que estou na página inicial  
**Quando** clicar em um dos atalhos na barra de navegação (inicio, relatos ou vantagens)  
**Então** meu navegador deve rolar para a seção correspondente

##### 1.01.01.03. Link para tela de login
**Dado** que estou na página inicial  
**Quando** clicar no link "login"  
**Então** devo ser redirecionado para a página de login

##### 1.01.01.04. Link para relatório de exemplo
**Dado** que estou na página inicial  
**Quando** clicar no link "amostra"  
**Então** devo ser redirecionado para o relatório de exemplo

#### 1.01.02. Links a partir do banner
**Como** usuário final  
**Quando** carregar a página principal  
**Para** ter facilidade em navegação  
**Gostaria** de ver imediatamente o botão para fazer login  
**E** o botão para testar o relatório de exemplo

##### 1.01.02.01. Botão no banner para a tela de login
**Dado** que estou na página inicial  
**E** existe um botão "login" no banner  
**Quando** eu clicar neste botão  
**Então** devo ser direcionado para a página de login

##### 1.01.02.02. Botão no banner para a tela de relatório exemplo
**Dado** que estou na página inicial  
**E** existe um botão "amostra" no banner  
**Quando** eu clicar neste botão  
**Então** devo ser direcionado para o relatório de exemplo

#### 1.01.03. Depoimentos de usuários
**Como** usuário final
**Quando** acessar a página principal
**Gostaria** de ver depoimentos de outros usuários
**Para** validar a escolha pela aquisição do serviço

#### 1.01.04. Resumo dos benefícios
**Como** usuário final
**Quando** acessar o site
**Gostaria** de ver os benefícios associados ao serviço resumidos em tópicos
**Para** entender rapidamente os ganhos que terei ao fazer a aquisição

### 1.02. Disponibilização de relatórios-exemplos
**Como** usuário final  
**Para** ter ainda mais certeza do que receberei ao contratar o serviço  
**Gostaria** de ter acesso a relatórios fictícios de exemplo

## 2. Relatório

### 2.01. Geração do relatório
**Como** usuário final  
**Dado** que eu já fiz a coleta de material genético previamente  
**Eu** gostaria de ter acesso a um relatório contendo informações relevantes derivadas desse material e pesquisas científicas, que seja possível filtrar e pesquisar e tenha links para recursos extras  
**Para** que eu possa aprender mais sobre mim mesmo

### 2.02. Acesso ao relatório por login
**Como** usuário final  
**Para** ter garantia que só eu acessarei meu relatório  
**Gostaria** de poder acessar o sistema através de meu login e senha

### 2.03. Aceite de termos de uso
**Como** usuário final  
**Assim** que eu fizer login pela primeira vez  
**Gostaria** de ler os termos e condições de uso do relatório  
**Para** que eu possa confirmar que estou satisfeito em aceitá-los

### 2.04. Guia explicativo do relatório
**Como** usuário final  
**Ao** acessar o meu relatório pela primeira vez  
**Gostaria** de ter um guia visual explicando o que é cada parte do relatório  
**E** as ações que posso tomar  
**Para** que eu possa usar o sistema com maior facilidade

### 2.05. Filtros no relatório
**Como** usuário final  
**Para** que eu consiga encontrar com maior facilidade as informações mais relevantes para mim  
**Gostaria** de poder filtrar os dados exibidos na tela

### 2.06. Buscas no relatório
**Como** usuário final  
**Gostaria** de poder realizar buscas com base no conteúdo do relatório  
**Para** que eu tenha acesso facilitado às informações que mais me interessam

### 2.07. Relatório com categorias
**Como** usuário final  
**Ao** ler meu relatório  
**Gostaria** de poder agrupar as informações por categorias

### 2.08. Paginação do relatório
**Como** usuário final  
**Para** que eu tenha acesso rápido às informações  
**Gostaria** que o relatório só carregasse uma parcela das informações por vez

### 2.09. Relatório responsivo
**Como** usuário final  
**Gostaria** de poder navegar no relatório a partir do navegador do meu smartphone  
**Para** que eu possa usufruir do sistema em qualquer lugar

## 3. GenomikAPI

### 3.01. Documentação da API
**Como** membro da equipe técnica do laboratório  
**Para** saber como usar a API para envio dos dados genéticos  
**Gostaria** de ter acesso a uma documentação concisa e com exemplos de uso

### 3.02. Disponibilização de API
**Como** membro da equipe técnica do laboratório  
**Considerando** que eu tenho uma chave de acesso  
**Gostaria** de poder enviar via API os dados resultantes do sequenciamento genético para serem analisados e gerarem o relatório para o cliente final  
**Para** que assim eu possa automatizar o processo internamente