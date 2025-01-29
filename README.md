# README - Sistema de Alocação de Datashows

## Descrição

Este sistema foi desenvolvido em **Prolog** para gerenciar a alocação de datashows em salas, evitando conflitos e garantindo que cada sala tenha no máximo um datashow alocado por vez.

## Requisitos

- Interpretador **SWI-Prolog** instalado no sistema.

## Como Executar

1. **Abra o SWI-Prolog**.
2. **Carregue o arquivo** contendo o código-fonte:
   ```prolog
   ?- [nome_do_arquivo].
   ```
3. **Utilize os predicados abaixo para interagir com o sistema.**

## Predicados e Consultas

### 1. Alocar um Datashow

Para alocar um datashow a uma sala, use:

```prolog
?- alocar_datashow(sala1, d1).
```

Saída esperada:

```
Datashow d1 alocado para a sala sala1.
```

### 2. Desalocar um Datashow

Para liberar um datashow previamente alocado, use:

```prolog
?- desalocar_datashow(sala1, d1).
```

Saída esperada:

```
Datashow d1 liberado da sala sala1.
```

### 3. Consultar Alocações Ativas

Para verificar as alocações atuais, utilize:

```prolog
?- findall((Sala, Datashow), alocada(Sala, Datashow), Alocacoes), writeln(Alocacoes).
```

Saída esperada (exemplo):

```
[(sala1, d1), (sala2, d2)].
```

### 4. Verificar Disponibilidade de um Datashow

Para saber se um datashow está disponível:

```prolog
?- disponivel(d1).
```

Se `d1` estiver disponível, o Prolog retornará `true`. Caso contrário, retornará `false`.

## Exemplo de Uso Interativo

```prolog
?- alocar_datashow(sala1, d1).
?- alocar_datashow(sala2, d2).
?- findall((Sala, Datashow), alocada(Sala, Datashow), Alocacoes), writeln(Alocacoes).
?- desalocar_datashow(sala1, d1).
?- findall((Sala, Datashow), alocada(Sala, Datashow), Alocacoes), writeln(Alocacoes).
```

## Considerações

- O sistema impede que uma sala tenha mais de um datashow simultaneamente.
- Apenas datashows disponíveis podem ser alocados.
- Alocações podem ser consultadas a qualquer momento.

Este README fornece um guia claro e prático de como utilizar o sistema de alocação de datashows utilizando a linguagem Prolog para o seu desenvolvimento.
