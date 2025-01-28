:- dynamic alocada/4.  % aloca a sala, o datashow, o horário de início e fim
:- dynamic disponivel/1.
:- dynamic semaforo/1.
:- dynamic fila/1.      % Declaração dinâmica para a fila

% Definindo os datashows e salas = constantes nomeadas
datashow(d1).
datashow(d2).
datashow(d3).

sala(s1).
sala(s2).
sala(s3).

% Estado inicial: todos os datashows disponíveis
inicializar_disponibilidade :-
    forall(datashow(D), assert(disponivel(D))),
    assert(semaforo(livre)),
    assert(fila([])).                      % Inicializa a fila como vazia

% Regras para alocar datashow com horários
alocar_datashow(Sala, Datashow, Inicio, Fim) :-
    semaforo(livre),                       % Verifica se o semáforo está livre
    sala(Sala),
    datashow(Datashow),
    \+ alocada(Sala, _, _, _),              % Verifica se a sala não tem datashow alocado
    \+ conflito(Datashow, Inicio, Fim),     % Verifica se o datashow está disponível no horário
    retract(semaforo(livre)),              % Bloqueia o semáforo
    assert(alocada(Sala, Datashow, Inicio, Fim)),  % Realiza a alocação com os horários
    retract(disponivel(Datashow)),                % Marca o datashow como não disponível
    assert(semaforo(livre)),               % Libera o semáforo após a operação
    format('Datashow ~w alocado para a sala ~w de ~w até ~w.~n', [Datashow, Sala, Inicio, Fim]).

% Verifica se há conflito de horários com o datashow em qualquer sala
conflito(Datashow, Inicio, Fim) :-
    alocada(_, Datashow, InicioExistente, FimExistente),
    (Inicio < FimExistente, Fim > InicioExistente),
    % Confirma que os horários se sobrepõem
    format('Não é possível alocar o datashow ~w devido a conflito de horário.~n', [Datashow]).

% Regras para desalocar datashow
desalocar_datashow(Sala, Datashow) :-
    semaforo(livre),                       % Verifica se o semáforo está livre
    alocada(Sala, Datashow, _, _),           % Verifica se o datashow está alocado na sala
    retract(semaforo(livre)),              % Bloqueia o semáforo
    retract(alocada(Sala, Datashow, _, _)),  % Remove a alocação
    assert(disponivel(Datashow)),            % Marca o datashow como disponível
    assert(semaforo(livre)),               % Libera o semáforo após a operação
    format('Datashow ~w liberado da sala ~w.~n', [Datashow, Sala]),
    processar_fila().                      % Processa a próxima requisição da fila

% Regras para adicionar à fila
adicionar_fila(Requisicao) :-
    retract(fila(Fila)),
    append(Fila, [Requisicao], NovaFila),
    assert(fila(NovaFila)),
    format('Requisição ~w adicionada à fila.~n', [Requisicao]).

processar_fila() :-
    fila([Requisicao|NovaFila]),            % Obtém a próxima requisição e a nova fila
    retract(fila([Requisicao|NovaFila])),
    assert(fila(NovaFila)),
    format('Processando requisição: ~w.~n', [Requisicao]),
    executar_requisicao(Requisicao).         % Executa a próxima requisição

executar_requisicao(alocar_datashow(Sala, Datashow, Inicio, Fim)) :-
    alocar_datashow(Sala, Datashow, Inicio, Fim).

executar_requisicao(desalocar_datashow(Sala, Datashow)) :-
    desalocar_datashow(Sala, Datashow).


% Regra para listar alocações
consultar_alocacoes :-
    findall((Sala, Datashow, Inicio, Fim), alocada(Sala, Datashow, Inicio, Fim), Alocacoes),
    (Alocacoes = [] ->
        writeln('Nenhuma sala possui datashows alocados.');
        format('Alocações: ~w\n', [Alocacoes])).
