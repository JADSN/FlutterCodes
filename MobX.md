# MobX

1. Padrão para gerenciamento de estados (veio do Javascript).
2. Manipulação de streams.
3. Evitar que um conjunto de reatividades(ValueNotifier's) seja de díficil manutenção e dificulte o projeto seja escalável
4. Obrigar o usuário a realizar uma ação ao invés de somente observar o estado atual.
    

## Funcionamento

1. Publisher e Subscriber para ouvir o que está contido na store e atualizar o `state` do widget, ou seja, reatividade.

# Tipos de reatividade

1. Lista de funções
2. Streams

## Significado

3. Ação
4. Reação
5. Mudança de estado.

Toda mudança no estado ela causa uma reação e toda ação causa uma mudança do estado que gera por sua vez uma reação.
Toda vez que modificar um observable por meio de uma ação por sua vez terá uma reação.

## Depencias

1. mobx
2. flutter_mobx

## Dependências de desenvolvimento

1. mobx_codegen
2. build_runner

## Regras

1. Todo action altera um observável.

## Uso

1. Definação das `variáveis` utiliza o decorator: `@observable`.
2. Definação dos `action` utiliza o decorator: `@action`.
   1. Sempre passar por parâmtro as entidades. Ex. User.
3. Torna a classe `abstract`
4. Torna a classe privada.
5. Extende a classe com `with Store`
6. part `<entity_name>.store.g.dart`
7. Juntar com a parte gerada pelo MobX
   1. `class <entity_name>Store = _<entity_name>Store with $<entity_name>Store;`
8. Executar `flutter packages pub run build_runner build`
9.  Envoler o widget que terá o estado modificado com:
    1.  `Observer(builder: (_) => Widget) `
