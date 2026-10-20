# Contexto y Reglas de Negocio - Ecosistema ACROSS

Este documento contiene las reglas de negocio oficiales del gimnasio ACROSS. **Instrucción para el Agente de IA:** Debes leer y aplicar estas reglas estrictamente al diseñar esquemas de base de datos (Prisma), crear endpoints (Express) o sugerir lógica de negocio.

## 1. Visión General y Nomenclatura
- El sistema gestiona las disciplinas, profesores, alumnas, asistencias y pagos del gimnasio.
- **MVP Actual:** Enfocado 100% en "Gimnasia Artística".
- **Idioma estricto:** Las tablas, columnas y variables de dominio DEBEN estar en español (Ej: `Alumna`, `Tutor`, `Grupo`, `ClaseDictada`, `RegistroAsistencia`). Nunca usar "Student" o "Group".

## 2. Reglas del Módulo: Asistencias y "Orden del Día"
En las clases de niñas pequeñas (ej: Escuelita, Iniciación), existe una dinámica llamada "Orden del Día" para determinar quién lidera la fila.

- **Regla 1 (Lista Fija):** Cada grupo tiene una lista secuencial estricta de alumnas. Un campo numérico (`numero_orden_dia`) en la inscripción de la alumna determina su posición en esa lista.
- **Regla 2 (Asignación Automática de "Primera"):** El sistema debe saber a quién le toca ser la "Primera" de la clase de hoy, continuando el ciclo desde la última vez.
- **Regla 3 (Ausencia y Recálculo):** Si el profesor marca como **Ausente** a la alumna que debía ser la "Primera" hoy, esta pierde su turno en la ronda actual. El sistema debe asignar automáticamente el turno de "Primera" a la siguiente alumna de la lista que esté **Presente**.
- **Regla 4 (Reordenamiento Manual):** Los profesores pueden alterar el orden secuencial de las alumnas manualmente (para separarlas por comportamiento). El backend debe soportar la actualización masiva del campo `numero_orden_dia`.
- **Regla 5 (Forzar "Primera"):** Los profesores pueden anular el cálculo automático y forzar que una alumna específica sea la "Primera" de la clase actual. Esta decisión manual anula cualquier lógica del sistema para ese día.
- **Regla 6 (Historial):** Se debe guardar un registro histórico inmutable de quién fue la "Primera" en cada `ClaseDictada` pasada.

## 3. Reglas del Módulo: Cuotas y Recargos
- Cada `Grupo` tiene un `monto_cuota_base` definido.
- **Regla de Vencimiento:** Los pagos realizados entre el día 1 y el día 10 de cada mes inclusive abonan el valor base.
- **Regla de Recargo:** A partir del día 11 de cada mes, se aplica un porcentaje de recargo automático sobre la cuota mensual.
- **Tutor vs Alumna:** Las cuotas y autorizaciones pertenecen a la `Alumna`, pero los datos de facturación/contacto pertenecen al `Tutor`. Varias hermanas (Alumnas) pueden compartir un mismo Tutor.