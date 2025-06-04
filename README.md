# Rocket Pocket 🚀

**Rocket Pocket** é um projeto Flutter que oferece uma **experiência de webapp otimizada** para o site da [Rocketseat](https://www.rocketseat.com.br). A proposta é simples, direta e eficiente: transformar a navegação no site mobile da Rocketseat em uma **experiência fluida, responsiva e com aparência de app**.

## 🚀 Tecnologias Utilizadas

- [Dart](https://dart.dev/)
- [Flutter](https://flutter.dev/)
- [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons)
- [Flutter Native Splash](https://pub.dev/packages/flutter_native_splash)
- [Web View Flutter](https://pub.dev/packages/webview_flutter)
- [JavaScript](https://developer.mozilla.org/pt-BR/docs/Web/JavaScript)
- [DOM](https://developer.mozilla.org/pt-BR/docs/Web/API/Document_Object_Model/Introduction)

## ✨ Funcionalidades

- Interface otimizada para dispositivos móveis.
- Integração com o site da Rocketseat.
- Experiência de navegação fluida e responsiva.

## 🎯 Objetivo

- Proporcionar uma experiência semelhante a um aplicativo nativo para o site da Rocketseat.
- Foco na parte de cursos para quem quiser estudar em momentos que só tem acesso pelo celular.

## 📦 Estrutura do Projeto

```
webrocket/
├── assets/                # Arquivos estáticos como imagens e fontes
├── android/               # Arquivos de build Android
├── ios/                   # Arquivos de build iOS
├── lib/
    └── data               # Camada responsável pelo serviço principal do app
    └── ui                 # Camada responsável pela interface visual do app
    └── app.dart           # Configurações do app
    └── env.dart           # Variáveis de ambiente do app
│   └── main.dart          # Ponto de entrada do app
├── pubspec.yaml           # Dependências do projeto
```

## 🚀 Como Executar

1. **Pré-requisitos**:
   - Flutter instalado. Caso não tenha, siga as instruções em: [Flutter - Instalação](https://docs.flutter.dev/get-started/install)

2. **Clone o repositório**:
   ```bash
   git clone https://github.com/edusantsales/rocket_pocket.git
   cd rocket_pocket
   ```

3. **Instale as dependências**:
   ```bash
   flutter pub get
   ```

4. **Execute o app**:
   ```bash
   flutter run -d android     # Para testar em dispositivo Android
   flutter run -d ios         # Para testar no iOS
   ```

## 📱 Capturas de Tela

(Adicione aqui capturas de tela do aplicativo em funcionamento para ilustrar a interface e funcionalidades.)
