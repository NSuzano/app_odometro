# app_odometro

# Documentação do Aplicativo "Odômetro e Despesas"

## Introdução
### O aplicativo "Odômetro e Despesas" foi desenvolvido em Flutter para auxiliar motoristas a rastrear suas viagens e despesas associadas. O aplicativo permite aos usuários capturar fotos do odômetro e recibos de despesas e armazenar esses dados de forma organizada.


## Recursos

### Captura de Fotos: Os usuários podem tirar fotos do odômetro e de suas despesas.
### ● Localização: É recebido os dados de latitude e longitude do usuário.
### ● Interface Amigável: UI intuitiva para fácil navegação e uso.
### ● Relatórios de Viagem: Geração de relatórios de despesas e quilometragem

## Requisitos

### ● Flutter SDK (versão mais recente recomendada)
### ● Dart (compatível com a versão do Flutter)
### ● Dependências Flutter:
###   ○ image_picker: para captura de imagens.
###   ○ geolocator: para captura a localização.
###   ○ jwt_decoder: para a decodificalção do jwt.
###   ○ intl: para a internacionalização.
###   ○ shared_preferences: para o salvamento dos dados offline.
###   ○ provider: para gerenciamento de estado.

## Estrutura do Projeto

```
/app_odometro
│
├── /lib
│ ├── /models
│ │ ├── expenses.dart
│ │ ├── branch.dart
│ │ ├── categories.dart
│ │ ├── driver.dart
│ │ ├── payment.dart
│ │ ├── race.dart
│ │ ├── survey.dart
│ │ └── car.dart
│ ├── /pages
│ │ ├── /car
│ │ │ ├── car_card.dart
│ │ │ ├── car_form.dart
│ │ │ └── car_page.dart
│ │ ├── /driver
│ │ │ └── driver_page.dart
│ │ ├── /expenses
│ │ │ ├── expenses_card.dart
│ │ │ ├── expenses_form.dart
│ │ │ └── expenses_page.dart
│ │ ├── /home
│ │ │ └── home.dart
│ │ ├── /login
│ │ │ └── login.dart
│ │ ├── /race
│ │ │ ├── list_race.dart
│ │ │ ├── race_card.dart
│ │ │ └── race_form.dart
│ │ ├── /survey
│ │ │ ├── survey_card.dart
│ │ │ └── survey_page.dart
│ ├── /widgets
│ │ ├── custom_button.dart
│ │ └── expense_card.dart
│ ├── main.dart
├── /assets
│ ├── /icons
│ └── fonts
├── pubspec.yaml
└── README.md
```
## Instalação

Clone o Repositório:
  git clone https://github.com/NSuzano/app_odometro.git
  cd app_odometro
1. Instale as Dependências:
  flutter pub get
2. Execute o Aplicativo:
  flutter run

## Imagens


## Informações Adicionais
O módulo de Vistoria ainda não está implementado, é preciso
implementá-lo e também algumas funções de refinamento.

## Conclusão

Este aplicativo fornece uma base sólida para criar um sistema de
rastreamento de odômetro e despesas. É possível expandir este app
adicionando mais funcionalidades, como relatórios detalhados,
integração com armazenamento na nuvem, e muito mais.

