# Trabalho 02 - Diogo e Mariana

## Descrição

Este é um jogo educativo desenvolvido em Flutter, projetado para ajudar os jogadores a aprenderem conceitos de endereçamento IPv4, incluindo Network ID, Broadcast e verificação de endereços IPv4 no mesmo segmento de rede. O jogo gera perguntas automaticamente com três níveis de dificuldade e armazena o score dos jogadores em uma base de dados SQLite.

## Funcionalidades

- **Registo e Login:** Permite que os utilizadores se registem e façam login.
- **Geração Automática de Perguntas:** Perguntas são geradas automaticamente com base no nível de dificuldade selecionado.
- **Pontuação:** O score é calculado com base nas respostas corretas e incorretas e armazenado no banco de dados.
- **Ranking:** Lista os 5 melhores scores.

## Estrutura do Projeto

- `lib/`
    - `main.dart`: Ponto de entrada da aplicação.
  - `screens/`  
    - `login_screen.dart`: Tela de login.
    - `register_screen.dart`: Tela de registo.
    - `ranking_screen.dart`: Tela do rank.
    - `gaming_screen.dart`: Tela principal do jogo.
  - `services/`
    - `auth_service.dart`: Serviço para gerenciar autenticação e pontuações.

## Configuração do Ambiente

### Pré-requisitos

- Flutter SDK: [Instalação do Flutter](https://flutter.dev/docs/get-started/install).
- Android Studio ou Visual Studio Code (ou outro editor de sua escolha).
- Dispositivo emulador ou físico para testar a aplicação.

### Dependências

Adicione as seguintes dependências ao arquivo `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: any
