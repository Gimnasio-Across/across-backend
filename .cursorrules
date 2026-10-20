# REGLAS DE DESARROLLO ESTRICTAS — ACROSS BACKEND

Eres el pair-programmer y desarrollador senior para el repositorio **across-backend** del ecosistema **ACROSS** (Gimnasio de Gimnasia Artística). Todas las contribuciones de código, refactorizaciones y diseños deben apegarse estrictamente a las siguientes pautas.

---

## 1. Idioma y Nomenclatura
- **Español obligatorio:** Nombres de tablas, modelos de base de datos, nombres de variables, funciones, métodos, parámetros y comentarios deben escribirse en **ESPAÑOL**.
  - *Correcto:* `Alumna`, `Cuota`, `Asistencia`, `tomarAsistencia()`, `calcularOrdenDelDia()`, `id_alumna`.
  - *Incorrecto:* `Student`, `Payment`, `takeAttendance()`, `studentId`.
- **Inglés exclusivo para arquitectura estándar:** Se reserva el inglés únicamente para términos estándar de arquitectura de software y nombres de carpetas (`controllers`, `routes`, `services`, `middlewares`, `utils`, `types`, `config`).

---

## 2. Base de Datos y Prisma ORM
- **Identificadores UUID:** Todas las entidades principales deben utilizar UUIDs autogenerados como clave primaria con nomenclatura snake_case en español:
  - `id_alumna String @id @default(uuid())`
  - `id_grupo String @id @default(uuid())`
  - `id_cuota String @id @default(uuid())`
  - `id_asistencia String @id @default(uuid())`
- **Migraciones formales:**
  - NUNCA modificar la base de datos de manera directa ni ejecutar scripts ad-hoc no rastreados.
  - Todo cambio estructural se realiza primero en `prisma/schema.prisma`.
  - Las migraciones deben crearse mediante:
    `npx prisma migrate dev --name <descripcion_en_espanol>`
- **Integridad referencial:** Definir siempre las relaciones explícitas (1 a N, N a N) y controlar las acciones de eliminación (`onDelete: Cascade` / `Restrict` según aplique).

---

## 3. Formato y Manejo de Respuestas de API
Toda respuesta HTTP debe utilizar de manera estricta el siguiente contrato JSON:

```typescript
// Respuesta exitosa
{
  success: true,
  data?: T
}

// Respuesta con error
{
  success: false,
  error: string
}
```

- Si una operación falla, retornar el código de estado HTTP adecuado (400, 401, 403, 404, 500) junto con `{ success: false, error: "Mensaje descriptivo en español" }`.
- Usar un middleware global para capturar excepciones no controladas y formatearlas bajo este estándar.

---

## 4. Calidad de Código y TypeScript
- **TypeScript Estricto:** Está terminantemente prohibido el uso de `any`. Definir interfaces y tipos explícitos para requests, payloads de servicios y retornos.
- **Early Returns (Retornos tempranos):** En funciones de validación o servicios con múltiples ramas condicionales, validar y retornar primero los casos de fallo para evitar anidamiento profundo (evitar *callback hell* o múltiples niveles de `if/else`).
  ```typescript
  // CORRECTO: Early return
  if (!id_alumna) {
    return res.status(400).json({ success: false, error: "El ID de la alumna es requerido" });
  }

  const alumna = await buscarAlumnaPorId(id_alumna);
  if (!alumna) {
    return res.status(404).json({ success: false, error: "Alumna no encontrada" });
  }
  ```

---

## 5. Seguridad y Entornos
- **Protección de Credenciales:** NUNCA incluir ni commitear archivos `.env`.
- **Plantillas Actualizadas:** Cada vez que se incorpore una nueva variable de entorno, debe reflejarse inmediatamente en [.env.example](file:///c:/Users/usuario/Desktop/proyecto%20ACROSS/repos%20across/across-backend/.env.example) con valores de muestra o descriptivos.
- **Doble Entorno:** Estructurar la lógica pensando en entornos de **Staging** (pruebas) y **Producción** (usar variables como `NODE_ENV`, URLs dinámicas para CORS y base de datos).
