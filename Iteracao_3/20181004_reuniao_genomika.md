Notas para reunião com Marcel

-- Falar sobre o postmortem 1:
    - Consumo da API da SNPedia completo;
        - 12 mil genes aproveitados de 110 mil
            - Apenas os com rsid ou que possuem cromossomo/posição;
            - Apenas genes que possuem ao menos um genótipo válido;
        - 17 mil genotipos de 90 mil:
            - Apenas genotipos com sumário;
            - Repute > 0 ou Magnitude > 0;
            - Apenas genotipos que possuem genes válidos;
        - Testamos com o arquivo de genotipos da 23andme (>600mil linhas), houveram 679 combinações entre SNPedia vs. arquivo;
    - Front:
        - Estruturamos o layout da landing page, mostrar o que está feito e o que tem em mente;
        - Apresentar os planos da pagina de relatório:
            - busca por strings;
            - classificação, se possível;
            - codificação por cor dependendo da magnitude e repute;
            - ordenação padrão por magnitude e repute;
        - validar se ele tem alguma outra sugestão para a tela de relatorio;
    - Login:
        - validar:
            - via api ele envia um id numerico + arquivo;
            - quando relatorio estiver completo, disponibilizamos a senha;
    - Validar se há interesse de traduzir os textos através do google translate; n há
    - Validar se existem outras bases de dados publicas alem da SNPedia;
    - Validar os endpoints da GenomikAPI e quem vai ser a pessoa de contato; va
    - Detalhar melhor as histórias de usuário - já temos a ideia principal, mas enfrentamos dificuldades em relação à validação BDD e subdivisão das issues.

    -- Cliente final da Genomika tem senha

    -- API python/django


-- durante a reunião

Funcionalidades do relatorio
- Escala de cor de acordo com magnitude e repute segumentada;

Login:
    - agora:
        (não existe ainda) - genomika teria uma api para passar os dados - dados do paciente - login e senha no portal (que possui todos os dados do cliente) com protocolo Oauth;
        - envia csv via api com id, csv
    - 

Histórias de usuário:
foco: b2b (laboratorio) - landing page deve refletir isso
Analista Genomika
    vai mandar os dados do paciente para mysnips via api
    analista deve poder acompanhar se o relatório está pronto (ver status)
    sistema deve informar login e senha para acessar o relatorio

Usuário final
    quando o cliente receber o login e senha da genomika, ele pode logar na aplicação
    o usuario final deve aceitar um termo de uso antes de visualizar o relatorio
        - se não aceitar ele volta pra pagina inicial
    quando estiver no relatorio o usuário poderá seguir um guia para entender o relatório
    quando estiver no relatorio o usuario poderá buscar por termos, snp, repute
    quando estiver no relatorio o usuário poderá filtrar por repute, magintude
    o relatório deve ser paginado
    cada snp deve ter link para página da snpedia7

Sugestão: mapa da jornada do usuário - passo a pas
Login:
    - agora:
        (não existe ainda) - genomika teria uma api para passar os dados - dados do paciente - login e senha no portal (que possui todos os dados do cliente) com protocolo Oauth;
        - envia csv via api com id, csv
    - 

Histórias de usuário:
foco: b2b (laboratorio) - landing page deve refletir isso
Analista Genomika
    vai mandar os dados do paciente para mysnips via api
    analista deve poder acompanhar se o relatório está pronto (ver status)
    sistema deve informar login e senha para acessar o relatorio

Usuário final
    quando o cliente receber o login e senha da genomika, ele pode logar na aplicação
    o usuario final deve aceitar um termo de uso antes de visualizar o relatorio
        - se não aceitar ele volta pra pagina inicial
    quando estiver no relatorio o usuário poderá seguir um guia para entender o relatório
    quando estiver no relatorio o usuario poderá buscar por termos, snp, repute
    quando estiver no relatorio o usuário poderá filtrar por reso do usuário
    - definir persona do laboratório
        dor: não tem base aberta com laudos personalizados
    - definir persona do usuário final
    
Sugestão: pesquisa de satisfação


Observações dúvidas Rafael:
Se no snpidia tiver (minus), inverter o nucleotídeo (A<->T, G<->C);
Ignorar genotipos que tenham mais do que duas letras no nucleotídeo

Validação da Landing page:
    - depoimentos entre o banner e as métricas;
    - slides cada vez menos usados na web - sugestão mudar para imagem fixa impactante;
    - inserir logo na landing page;
    - reforçar 'entre em contato conosco' - mailto inicialmente;
    - carinho com tipografia;
    - padrão do botão da ação principal que desejamos que o cliente clique deve ser diferente;

Para dia 31/10 (pode ser v):
    - história de usuários;
    - landing page voltada para o laboratório;
    - fluxo de login;
