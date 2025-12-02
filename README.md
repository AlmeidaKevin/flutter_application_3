# 📘 README -- Flutter Pokédex App

## 🐱‍👤 Descripción del proyecto

<p align="center">
  <img src="https://github.com/user-attachments/assets/8eada7ed-90df-4ea6-b832-6029085c1091" width="45%">
  <img src="https://github.com/user-attachments/assets/4ac1b980-b5e6-493b-9083-b42b33c63ae1" width="45%">
</p>


Esta es una aplicación Flutter que muestra una lista de Pokémon
obtenidos desde la **PokéAPI**.\
Incluye consumo de APIs REST con `http`, manejo de modelos, servicios y
pantallas simples.

## 📁 Estructura del proyecto

    lib/
    │── main.dart
    │── models/
    │    └── pokemon.dart
    │── services/
    │    └── pokeapi_service.dart
    └── pages/
         └── home_page.dart

## main.dart

Punto de entrada de la app. Define tema y carga `HomePage()`.

## models/pokemon.dart

Modelo que representa un Pokémon. Convierte JSON → objeto Pokémon.

## services/pokeapi_service.dart

Lógica para conectarse a la PokéAPI usando `http`.

Ejemplo:

``` dart
import 'package:http/http.dart' as http;
```

Método principal: - Obtiene lista de Pokémon - Hace petición por cada
uno para obtener su imagen - Devuelve lista de modelos Pokémon

## pages/home_page.dart

Pantalla principal que: - Llama al servicio - Usa `FutureBuilder` -
Muestra nombre e imagen de cada Pokémon

## 🔧 Instalación

    flutter pub get
    flutter run

## 📦 Dependencias

``` yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0
```

## 🚀 Funcionalidades

✔ Lista de Pokémon\
✔ Consumo de API\
✔ Conversión JSON a modelos\
✔ UI simple


