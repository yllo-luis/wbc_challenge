# wbc_challenge

Projeto voltado para a implementação do desafio proposto pela empresa WBC. O foco foi criar um sistema de reservas para churrascarias em um condomínio ou qualquer outro ambiente.

O aplicativo conta com uma implementação de banco de dados local ([sqflite](https://pub.dev/packages/sqflite)) e também com implementações de elementos básicos de uma aplicação flutter (como [gerenciamento de dependências](https://pub.dev/packages/flutter_modular), por exemplo).

O layout da aplicação foi prototipado e está disponível para [visualização](https://www.figma.com/file/0wteQW45RA1HmKWhGHDhhQ/Desafio-WBC---Figma?node-id=0%3A1&t=ZMdldqhCjn7EgBVB-1).

# Iniciando a aplicação

Para iniciar esta aplicação, basta instalar o APK anexado a este e-mail ou executar o código-fonte utilizando o comando `flutter run`.

Dependendo da quantidade de dispositivos plugados, uma escolha deverá ser feita. Considere que o aplicativo foi pensado para o ambiente mobile.

Também foram implementados testes unitários para garantir a qualidade do código. Para iniciá-los, basta executar o comando `flutter test test/helper/database_helper_tests.dart`.