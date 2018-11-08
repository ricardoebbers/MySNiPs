# Post Mortem 3

## Período

De         | Até
---------- | ----------
23/10/2018 | 07/11/2018

## O que foi planejado

Planejado | Responsável
--------- | -----------
Validar, corrigir e refinar UI da landing page com o cliente | José Reginaldo + Ricardo Ebbers
Modelar o layout do Relatorio | José Reginaldo
Criar ferramentas para manipular dados no banco | João Lira
Criar login para usuario | João Lira
Implementar a GenomikAPI no Rails | João Rafael
Implementar o backend do relatório | João Rafael + João Lira
Criar testes para o login | Ricardo Ebbers
Criar testes para a GenomikAPI | Ricardo Ebbers
Criar testes para o match genoma vs base SNPedia | Ricardo Ebbers

## O que foi entregue

Planejado | Responsável | Observações
--------- | ----------- | -----------
Validar, corrigir e refinar UI da landing page com o cliente | José Reginaldo + Ricardo Ebbers
Criar login para usuario | João Lira
Implementar o backend do relatório | João Rafael + João Lira
Criar testes para o login | Ricardo Ebbers
Criar testes para o match genoma vs base SNPedia | Ricardo Ebbers + João Rafael
Implementar a GenomikAPI no Rails | João Rafael

## O que não foi entregue

Planejado | Responsável | Impedimentos
--------- | ----------- | ------------
Modelar o layout do Relatorio | José Reginaldo | Dificuldades com incompatibilidades entre templates
Criar ferramentas para manipular dados no banco | João Lira | Despriorizado frente a outras demandas levantadas pelo cliente nas reuniões
Implementar upload via API | João Rafael | Dificuldades com o framework
Criar testes para a GenomikAPI | Ricardo Ebbers | A API foi despriorizada frente à entrega do relatório


## Foi feito algo que não estava planejado?

Atividade | Responsável | Justificativa
--------- | ----------- | -------------
Rolagem infinita no relatório | João Lira + Ricardo Ebbers | Melhoria percebida para o design do relatório
Definição de roles para usuários | João Lira + João Rafael | Reutilizar tabela users para usuario_final, admin e laboratorio
Criar modelo ER do BD | João Lira + João Rafael | Critério de avaliação que não mapeamos no postmortem anterior
Jornada do consumidor | Ricardo Ebbers | Sugestão do cliente
Refinamento e detalhamento das HUs | Ricardo Ebbers | Com base no feedback do cliente
Elaboração de logo | José Reginaldo | Sugestão do cliente


## Próxima iteração

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

## Lições aprendidas

* Deveriamos ter ficado mais proximo do cliente nas duas primeiras iterações como ficamos nessa terceira;
* Procurar entender mais e realizar testes prévios com os templates para possíveis adaptações
* Estar mais preparados para mudanças de prioridades durante a sprint
* Tentar sempre entregar algo ao final de cada dia, mesmo que seja uma parte pequena da task
