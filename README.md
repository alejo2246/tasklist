# Task List App

Esta es una aplicación simple de lista de tareas desarrollada con Flutter y conectada a Firebase Firestore. La aplicación permite a los usuarios agregar, marcar como completadas e eliminar tareas.

## Requisitos del Sistema

- Tener Flutter instalado en su máquina. Puede seguir las [instrucciones de instalación de Flutter](https://flutter.dev/docs/get-started/install).
- Tener un emulador de Android configurado en su máquina o un dispositivo Android conectado.

## Configuración del Proyecto

1. Abra una terminal en el directorio de la aplicación.

2. Ejecute el siguiente comando para asegurarse de que todos los paquetes de dependencias estén instalados:

   ```bash
   flutter pub get
   ```

1. Inicie su emulador de Android o conecte su dispositivo Android a la máquina.

2. Ejecute la aplicación con el siguiente comando:

   ```bash
   flutter run
   ```
Esto instalará la aplicación en su emulador o dispositivo y la ejecutará.

## Características Principales
**Agregar Tarea**: Toque el botón de adición en la esquina inferior derecha para agregar una nueva tarea.

**Marcar como Completada**: Toque una tarea para marcarla como completada. Puede deshacer esta acción volviendo a tocar la tarea.

**Eliminar Tarea**: Toque el ícono de basura junto a una tarea para eliminarla. Se solicitará confirmación antes de eliminar la tarea.

**Filtrar Tareas**: Utilice los botones de filtro en la parte superior para ver todas las tareas, tareas completadas o tareas incompletas.

La aplicación utiliza Firebase Firestore para almacenar y recuperar las tareas, y todo el manejo de la aplicación está construido con Riverpod.

¡Disfrute organizando sus tareas con esta simple y efectiva aplicación de lista de tareas!