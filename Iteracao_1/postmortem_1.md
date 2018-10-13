# Post Mortem 1

## Período

De         | Até
---------- | ----------
25/09/2018 | 08/10/2018

## O que foi planejado

Planejado | Responsável
--------- | -----------
Validar UI com o cliente | José Reginaldo + Ricardo Ebbers
Criar objetos da landing page na View | José Reginaldo
Definir entidades dos dados extraídos do SNPedia no Model | João Lira
Automatizar processo de extração de dados do SNPedia no Controller | João Rafael
Criar scripts de testes para as primeiras implementações | Ricardo Ebbers

## O que foi entregue

Planejado | Responsável | Observações
--------- | ----------- | -----------
Criar objetos da landing page na View | José Reginaldo | -
Definir entidades dos dados extraídos do SNPedia no Model | João Lira | -
Automatizar processo de extração de dados do SNPedia no Controller | João Rafael | Processo semi-automático, depende de trigger manual

## O que não foi entregue

Planejado | Responsável | Impedimentos
--------- | ----------- | ------------
Validar UI com o cliente | José Reginaldo + Ricardo Ebbers | Decidimos que seria mais interessante apresentar ao cliente o layout hi-fi implementado ao invés do lo-fi entregue na Iteração 0
Criar scripts de testes para as primeiras implementações | Ricardo Ebbers | Foi entendido durante a sprint que era necessário focar mais no desenvolvimento das outras atividades 


## Foi feito algo que não estava planejado?

Atividade | Responsável | Justificativa
--------- | ----------- | -------------
Spike para receber upload de grandes arquivos via API | Ricardo Ebbers + João Lira | Percebemos durante a sprint que implementar a API não será trivial e necessitou de um esforço

## Próxima iteração

Planejado | Responsável
--------- | -----------
Validar, corrigir e refinar UI da landing page com o cliente | José Reginaldo + Ricardo Ebbers
Automatizar 100% extração e tratamento de dados do SNPedia | João Rafael
Criar ferramentas para manipular dados no banco | João Rafael
Modelar a API que o lab vai consumir | Ricardo Ebbers
Criar login para usuario | João Lira
Criar testes para o login | Ricardo Ebbers

## Lições aprendidas

* Apresentar o conteúdo para o usuário de forma menos agressiva e com foco na UX;
* Faltou domínio sobre o Rails e estimar melhor a complexidade das atividades;
* Já tinhamos uma noção que os dados do SNPedia estavam desorganizados, mas subestimamos o potencial dessa desorganização.