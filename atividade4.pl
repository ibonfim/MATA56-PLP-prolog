:- dynamic alocada/4.
:- dynamic disponivel/1.
:- dynamic semaforo/1.
:- dynamic fila/1.

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
    assert(fila([])).

% Regras para alocar datashow com horários
alocar_datashow(Sala, Datashow, Inicio, Fim) :-
    semaforo(livre),
    sala(Sala),
    datashow(Datashow),
    \+ alocada(Sala, _, _, _),
    \+ conflito(Datashow, Inicio, Fim),
    retract(semaforo(livre)),
    assert(alocada(Sala, Datashow, Inicio, Fim)),
    retract(disponivel(Datashow)),
    assert(semaforo(livre)),
    format('Datashow ~w alocado para a sala ~w de ~w até ~w.~n', [Datashow, Sala, Inicio, Fim]).

% Verifica se há conflito de horários
conflito(Datashow, Inicio, Fim) :-
    alocada(_, Datashow, InicioExistente, FimExistente),
    (Inicio < FimExistente, Fim > InicioExistente).

% Regras para desalocar datashow
desalocar_datashow(Sala, Datashow) :-
    semaforo(livre),
    alocada(Sala, Datashow, _, _),
    retract(semaforo(livre)),
    retract(alocada(Sala, Datashow, _, _)),
    assert(disponivel(Datashow)),
    assert(semaforo(livre)),
    format('Datashow ~w liberado da sala ~w.~n', [Datashow, Sala]),
    processar_fila().

% Adicionar requisições na fila
adicionar_fila(Requisicao) :-
    fila(Fila),
    append(Fila, [Requisicao], NovaFila),
    retractall(fila(_)),
    assert(fila(NovaFila)),
    format('Requisição ~w adicionada à fila.~n', [Requisicao]),
    processar_fila().

processar_fila() :-
    fila([Requisicao|NovaFila]),
    retract(fila(_)),
    assert(fila(NovaFila)),
    format('Processando requisição: ~w.~n', [Requisicao]),
    executar_requisicao(Requisicao).

executar_requisicao(alocar_datashow(Sala, Datashow, Inicio, Fim)) :-
    alocar_datashow(Sala, Datashow, Inicio, Fim).

executar_requisicao(desalocar_datashow(Sala, Datashow)) :-
    desalocar_datashow(Sala, Datashow).

consultar_alocacoes :-
    findall((Sala, Datashow, Inicio, Fim), alocada(Sala, Datashow, Inicio, Fim), Alocacoes),
    (Alocacoes = [] -> writeln('Nenhuma sala possui datashows alocados.') ;
                       format('Alocações: ~w~n', [Alocacoes])).

% Inicialize a disponibilidade dos recursos
:- inicializar_disponibilidade.
