# Aplicación de reparto con sistema de control horario (Frontend)

## 1. Introducción
Este proyecto consiste en la creación de un sistema de control de horario que involucra un servidor middleware desarrollado en Go y una aplicación móvil para Android en Flutter. El sistema permitirá a los usuarios autenticarse, registrar su jornada laboral y gestionar visitas a clientes mediante geolocalización.

## 2. Arquitectura del Sistema
El sistema se divide en dos partes principales:
- **Servidor Middleware (Go):** Gestiona usuarios, autentica sesiones mediante tokens y almacena datos en una base de datos MySQL.
- **Aplicación Android (Flutter):** Permite a los usuarios iniciar, pausar y finalizar su jornada laboral, además de gestionar visitas a clientes con geolocalización.

## 3. Requisitos Funcionales

### 3.1 Servidor Middleware
- Recibir y almacenar datos de usuarios (usuario, dominio, contraseña, token).
- Generar un token de autenticación para cada usuario y enviarlo al cliente.
- Permitir el inicio de sesión simultáneo de varios usuarios.
- Gestionar la conexión con la base de datos MySQL (llamada `security`).

### 3.2 Aplicación Cliente (Android)
1. **Pantalla de Inicio:**
   - Título: "Control de horario".
   - Botón para "Iniciar Jornada" (activo solo cuando la jornada no ha iniciado).
   
2. **Obtención de Ubicación:**
   - La aplicación intenta obtener la ubicación del usuario mediante GPS.
   - Si no es posible, se muestra un mensaje de advertencia, pero no impide continuar.

3. **Pantalla de Jornada Activa:**
   - Muestra el tiempo transcurrido desde el inicio de la jornada.
   - Contiene los botones "Pausar" y "Finalizar Jornada".

4. **Gestor de Clientes:**
   - Lista de clientes asignados para la jornada.
   - Cada cliente tiene un botón de "Visitar" junto con su ubicación.
   - Si una visita está más cercana que otra, la lista se reordena dinámicamente.

5. **Pantalla de Cliente:**
   - Muestra los datos detallados del cliente.
   - Incluye un mapa con la ubicación del cliente.
   - Mantiene visible el temporizador de jornada junto con los botones "Pausar" y "Finalizar Jornada".

## 4. Instalación

### 4.1 Requisitos Previos

- **Aplicación Android:**
  - Flutter 3.0 o superior.
  - Android Studio o Visual Studio Code.

### 4.2 Instrucciones para Aplicación Android
1. Clonar el repositorio de la aplicación:
   ```bash
    git clone https://github.com/JuanCarlos92/Flutter_app_reparto.git
   ```
2. Navegar al directorio del proyecto y ejecutar:
   ```bash
    flutter pub get
    flutter run
   ```
5. Contribuciones

## 5. Si deseas contribuir a este proyecto, por favor sigue estos pasos:

1. Haz un fork del repositorio.

2. Crea una rama para tu nueva funcionalidad: git checkout -b nueva-funcionalidad.

<<<<<<< HEAD
3. Realiza tus cambios y confirma con un mensaje claro: git commit -am 'Agregado nueva funcionalidad'.
=======
3. Realiza tus cambios y confirma con un mensaje claro: git commit -m 'Agregado nueva funcionalidad'.
>>>>>>> cf20d64ee7d2aba3a5e40b7dc6bccad6d5caf675

4. Sube tus cambios: git push origin nueva-funcionalidad.

5. Crea un pull request con una descripción detallada de los cambios.
<<<<<<< HEAD

=======
>>>>>>> cf20d64ee7d2aba3a5e40b7dc6bccad6d5caf675
