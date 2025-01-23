:- dynamic alocada/2.
:- dynamic disponivel/1.

% Definindo os datashows e salas = constantes nomeadas
datashow(d1).
datashow(d2).
datashow(d3).

sala(sala1).
sala(sala2).
sala(sala3).

% Estado inicial de disponibilidade dos datashows
disponivel(d1).
disponivel(d2).
disponivel(d3).

 
% Regras para alocar datashow -  Fato que armazena as alocações feitas
alocar_datashow(Sala, Datashow) :-
    sala(Sala),
    datashow(Datashow),
    \+ alocada(Sala, _),             % Verifica se a sala não tem datashow
    disponivel(Datashow),            % Verifica se o datashow está disponível
     
    assert(alocada(Sala, Datashow)), % Realiza a alocação
    retract(disponivel(Datashow)),   % Marca o datashow como não disponível
    format('Datashow ~w alocado para a sala ~w.', [Datashow, Sala]).

% Regras para liberar datashow
desalocar_datashow(Sala, Datashow) :-
    alocada(Sala, Datashow),         % Verifica se o datashow está alocado na sala
    retract(alocada(Sala, Datashow)),% Remove a alocação
    assert(disponivel(Datashow)),    % Marca o datashow como disponível
    format('Datashow ~w liberado da sala ~w.', [Datashow, Sala]).