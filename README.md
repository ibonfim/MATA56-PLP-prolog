# Sistema de Alocação de Datashows

Este sistema permite gerenciar a alocação de datashows para salas, verificando sua disponibilidade, alocando e desalocando conforme necessário.

## Funcionalidades

- Verificar disponibilidade de datashows.
- Alocar datashows para salas.
- Desalocar datashows.

## Requisitos

- **SWI-Prolog** ou **SWISH Prolog** (opcional, versão online).

## Como Usar

1. **Verificar a disponibilidade** de um datashow:
   ```prolog
   ?- disponivel(d1).
   ?- alocada(sala1, d1).
   ?- desalocar_datashow(d1).

2. **Exemplo de fluxo completo** de um datashow:
  ```prolog
   % Verificar disponibilidade antes da alocação
   ?- disponivel(d1);
   O datashow d1 está disponível.

   % Alocar o datashow
   ?- alocar_datashow(sala1, d1);
   O datashow d1 foi alocado para a sala sala1.

   % Verificar disponibilidade após a alocação
   ?- disponivel(d1);
   O datashow d1 não está disponível.

   % Desalocar o datashow
   ?- desalocar_datashow(sala1,d1).
   O datashow d1 foi desalocado.

3. é possivel alocar e desalocar sequencialmente os datashow com:

    ?- alocar_datashow(Sala, Datashow).
    para desalocar:
    ?- desalocar_datashow(Sala, Datashow).

    Caso nao queira passar um dos parametros a consulta ficaria assim e ocorreria para todos que estiverem alocados:

    ?- desalocar_datashow(Sala,_).

4.Verificar todos os datashow disponivéis 
    ?- disponivel(Datashow).






