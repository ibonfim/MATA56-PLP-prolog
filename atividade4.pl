:- dynamic alocada/4.  % aloca a sala, o datashow, o horário de início e fim
:- dynamic disponivel/1.

% Definindo os datashows e salas = constantes nomeadas
datashow(d1).
datashow(d2).
datashow(d3).

sala(s1).
sala(s2).
sala(s3).

% Estado inicial de disponibilidade dos datashows
disponivel(d1).
disponivel(d2).
disponivel(d3).

% Regras para alocar datashow com horários
alocar_datashow(Sala, Datashow, Inicio, Fim) :-
    sala(Sala),
    datashow(Datashow),
    \+ alocada(Sala, _, _, _),              % Verifica se a sala não tem datashow alocado
    \+ conflito(Datashow, Inicio, Fim),     % Verifica se o datashow está disponível no horário
    assert(alocada(Sala, Datashow, Inicio, Fim)),  % Realiza a alocação com os horários
    retract(disponivel(Datashow)),                % Marca o datashow como não disponível
    format('Datashow ~w alocado para a sala ~w de ~w até ~w.~n', [Datashow, Sala, Inicio, Fim]).

% Verifica se há conflito de horários com o datashow em qualquer sala
conflito(Datashow, Inicio, Fim) :-
    alocada(_, Datashow, InicioExistente, FimExistente),
    (Inicio < FimExistente, Fim > InicioExistente), 
    % Confirma que os horários se sobrepõem
    format('Não é possível alocar o datashow ~w devido a conflito de horário.~n', [Datashow]).

% Regras para liberar datashow
desalocar_datashow(Sala, Datashow) :-
    alocada(Sala, Datashow, _, _),           % Verifica se o datashow está alocado na sala
    retract(alocada(Sala, Datashow, _, _)),  % Remove a alocação
    assert(disponivel(Datashow)),            % Marca o datashow como disponível
    format('Datashow ~w liberado da sala ~w.~n', [Datashow, Sala]).