## Ata de Reunião

Data         | Local
------------ | -------------
03/09/2018   | Escritório da Genomika


### Participantes
* Marcel Caraciolo (_Product owner_)
* [Jaime Fernandes de Araujo Neto](https://github.com/jfernan10) (jfan)
* [João Rafael Santos Camelo](https://github.com/JoaoRafaelCamelo) (jrsc2)
* [Ricardo Ebbers Carneiro Leão](https://github.com/ricardoebbers) (recl)

### Objetivos
1. Validar escopo do projeto;
2. Alinhar o cronograma;
3. Determinar as _personas_ para as histórias de usuários;
4. Discutir pontos essenciais para desenvolver os _Lo-Fi mockups_.

### Tópicos debatidos
* Ficaram definidas duas _personas_:
    1. Usuário final - cliente da Genomika que tratará diretamente com eles durante o processo de coleta e sequenciamento genético **e** receberá o acesso ao relatório personalizado gerado pelo MySNiPs;
        * Nosso ponto focal para essa _persona_ será o Dyego Carlos (dyego@genomika.com.br);
        * Os integrantes do time que deverão dar atenção especial ao Dyego são Jaime e Reginaldo;
    2. Integrante da equipe técnica da Genomika - será o _developer_ da Genomika que consumirá a API, será notificado quando o relatório estiver pronto e receberá os dados de acesso para repasse ao usuário final;
        * Ainda não fomos introduzidos ao integrante do cliente que será o ponto focal dessa _persona_;
* Foram selecionadas as principais _features_ que deverão ser entregues no MVP do projeto até o final da disciplina:
    1. Iremos expor uma API para a Genomika enviar os arquivos com os sequenciamentos genéticos do usuário final;
    2. O serviço consumirá uma base de dados pública ([SNPedia](https://www.snpedia.com/)) que possui informações curadas pela comunidade sobre genética humana (e manterá uma cópia dessa base internamente);
    3. Será feito, então, um cruzamento dos registros da base de dados com as informações contidas no sequenciamento genético fornecido pela Genomika;
    4. O serviço, por fim, classificará as informações geradas a partir das duas fontes de dados acima e entregará como _output_ um relatório fácil de ser entendido pelo usuário final;
    5. Cada relatório terá um endereço único acessível apenas com um login e senha gerados automaticamente e entregue à Genomika, que ficará responsável por repassar esse login ao usuário final;
        * Essa medida visa mantermos o sigilo do usuário final. Não faremos qualquer associação com os dados genéticos recebidos a dados reais que possam vir a identificá-lo;
* Conversamos com o Marcel sobre as iterações da disciplina e suas respectivas entregas intermediárias. Não foram definidas as datas das próximas reuniões ainda, mas o contato com o cliente tem sido direto e fácil;
* Reforçamos que os próximos passos serão:
    1. Criar **histórias de usuários** para as _personas_ definidas;
    2. Validar os _mockups Lo-Fi_ que serão desenvolvidos nas próximas sprints;
* Deverá haver uma rotação nas entregas para que todos os integrantes do grupo tenham contato direto com o cliente.

### Tasks
Tarefa | Responsável
------ | -----------
Desenvolvimento dos _mockups_ | Jaime
Criar historia de usuários | Ricardo
Estudo para expor API em Rails | João Rafael
Estudo direcionado para modelar o BD | João Lira
Definição e estudo do _framework front-end_ | Reginaldo
