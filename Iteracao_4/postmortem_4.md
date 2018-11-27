# Post Mortem 4

## Período

De         | Até
---------- | ----------
08/11/2018 | 26/11/2018

## O que foi planejado

Planejado | Responsável
--------- | -----------
Modelar e implementar o layout do Relatorio | José Reginaldo
Implementar upload via API | João Rafael
Criar testes para a GenomikAPI | Ricardo Ebbers
Criar testes para o match genoma vs base SNPedia | Ricardo Ebbers
Implementar buscas no relatório | João Lira
Implementar filtros com base em repute e magnitude | João Lira
Aplicar últimos ajustes solicitados na landing page | José Reginaldo
Permitir que um relatório possa ser exibido sem estar logado (para usar como exemplo) | João Rafael
Elaborar termos de uso | José Reginaldo + Ricardo Ebbers

## O que foi entregue

Planejado | Responsável | Observações
--------- | ----------- | -----------
Modelar e implementar o layout do Relatorio | José Reginaldo
Implementar upload via API | João Rafael
Criar testes para a GenomikAPI | Ricardo Ebbers
Criar testes para o match genoma vs base SNPedia | João Rafael
Implementar buscas no relatório | João Lira
Implementar filtros com base em repute e magnitude | João Lira
Aplicar últimos ajustes solicitados na landing page | José Reginaldo
Permitir que um relatório possa ser exibido sem estar logado (para usar como exemplo) | João Rafael
Elaborar termos de uso | José Reginaldo + Ricardo Ebbers

## O que não foi entregue

Entregamos tudo que foi planejado


## Foi feito algo que não estava planejado?

Atividade | Responsável | Justificativa
--------- | ----------- | -------------
Criar página html de exemplo para laboratório usar o API | Ricardo Ebbers | Apresentar a API diretamente no terminal não estava legal
Adicionar botão de reset dos filtros | João Lira + José Reginaldo | Sentimos a necessidade dessa funcionalidade a mais tendo em vista uma melhor experiência do usuário
Otimizar utilização de RAM na leitura e criação de cards | João Rafael + Ricardo Ebbers | O Rails/Heroku estava guardando uma quantidade absurda de objetos na memória, derrubando o servidor

## Próxima iteração

N/A

## Lições aprendidas

* Saber as limitações da infraestrutura a ser utilizada e programar pensando nesses limites desde o início
* Programar defensivamente
* Nos orientar ainda mais à visão de negócio proposta
* Saber o momento de repriorizar quando nada parece estar funcionando (quando tentávamos corrigir os memory leaks do Rails)
