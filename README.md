# ACROSS Backend — API REST & Base de Datos 🤸‍♀️

Backend y servicio central de datos para el ecosistema **ACROSS**, sistema integral de gestión para gimnasios de Gimnasia Artística.

Este servicio centraliza la lógica del negocio: control digital de asistencias (incluyendo el sistema de **Orden del Día** para pasadas en aparatos), administración de alumnas, gestión de cuotas mensuales y seguros deportivos.

---

## 🛠️ Stack Tecnológico

- **Runtime:** [Node.js](https://nodejs.org/) (>= 18.x)
- **Lenguaje:** [TypeScript](https://www.typescriptlang.org/) (Modo estricto)
- **Framework Web:** [Express.js](https://expressjs.com/) v5
- **ORM & Base de Datos:** [Prisma ORM](https://www.prisma.io/) + [PostgreSQL](https://www.postgresql.org/)
- **Herramientas de Desarrollo:** `ts-node`, `nodemon`, `dotenv`, `cors`

---

## 📁 Arquitectura y Estructura del Proyecto

El proyecto sigue una arquitectura por capas orientada a separación de responsabilidades:

```text
across-backend/
├── prisma/
│   ├── migrations/           # Historial inmutable de migraciones SQL aplicadas
│   └── schema.prisma         # Definición de modelos relacionales y datasource Neon
├── src/
│   ├── config/               # Configuración de entorno y clientes (BD, Prisma)
│   ├── controllers/          # Manejadores de peticiones HTTP
│   ├── middlewares/          # Validaciones, autenticación y manejo global de errores
│   ├── routes/               # Definición de rutas y endpoints de la API
│   ├── services/             # Lógica de negocio (asistencias, cuotas, orden del día)
│   ├── types/                # Interfaces y tipos TypeScript
│   ├── utils/                # Utilidades y formateadores
│   └── server.ts             # Punto de entrada y levantamiento del servidor Express
├── docs/
│   └── REGLAS_DE_NEGOCIO.md  # Especificación oficial del dominio ACROSS
├── .env.example              # Plantilla de variables de entorno (SIEMPRE commitear)
├── .gitignore                # Archivos y carpetas excluidos del control de versiones
├── RULES.md                  # Reglas de desarrollo estrictas para pair-programming
├── package.json              # Dependencias y scripts
└── tsconfig.json             # Configuración del compilador TypeScript
```

---

## ☁️ Base de Datos en la Nube: Neon Serverless PostgreSQL

El proyecto utiliza **[Neon](https://neon.tech/)** como motor de base de datos PostgreSQL Serverless, organizado bajo el proyecto `bold-mode-69632863`:

### Entornos Configurados (Branching en Neon):
1. **Staging (`across-staging`):**
   - Base de datos aislada para desarrollo activo, pruebas locales y validación de nuevas migraciones.
   - Endpoint: `ep-steep-water-b45us12d` (Región AWS `us-east-2`).
2. **Producción (`across-production` / `production`):**
   - Base de datos principal de producción.

### Arquitectura de Conexión (Pooler vs Conexión Directa):
Para evitar problemas de saturación de conexiones en arquitecturas Serverless y permitir que Prisma ejecute migraciones sin bloqueos, se utilizan dos URLs complementarias:
- **`DATABASE_URL` (Connection Pooling):** Utiliza el host `-pooler` (`ep-steep-water-b45us12d-pooler...`). Recomendado para todas las consultas en tiempo de ejecución del servidor Express.
- **`DIRECT_URL` (Direct Connection):** Conexión directa sin pasar por el pooler de PgBouncer. Utilizada exclusivamente por Prisma para aplicar migraciones (`npx prisma migrate dev`) y gestionar bloqueos de esquema.

---

## 🚀 Instalación y Puesta en Marcha Local

### 1. Prerrequisitos
- Tener instalado [Node.js](https://nodejs.org/) (v18 o superior).
- Cuenta/acceso a la instancia de **Neon** (o PostgreSQL compatible).

### 2. Clonar e Instalar Dependencias
```bash
git clone https://github.com/Gimnasio-Across/across-backend.git
cd across-backend
npm install
```

### 3. Configurar Variables de Entorno
Copia la plantilla `.env.example` y crea tu archivo `.env`:
```bash
cp .env.example .env
```
Edita `.env` con las cadenas de conexión a Neon (ejemplo para **Staging**):
```env
PORT=4000
NODE_ENV=development

# Conexión a Neon PostgreSQL (Staging)
DATABASE_URL="postgresql://neondb_owner:<PASSWORD>@ep-steep-water-b45us12d-pooler.c-6.us-east-2.aws.neon.tech/across-staging?sslmode=require"
DIRECT_URL="postgresql://neondb_owner:<PASSWORD>@ep-steep-water-b45us12d.c-6.us-east-2.aws.neon.tech/across-staging?sslmode=require"

CORS_ORIGIN_ADMIN="http://localhost:5173"
CORS_ORIGIN_PWA="http://localhost:5174"
```

### 4. Sincronizar o Ejecutar Migraciones en Neon
Para sincronizar las tablas y generar el cliente de Prisma:
```bash
npx prisma migrate dev --name <descripcion_en_espanol>
```
*(Para verificar el estado actual de la base de datos en Neon sin crear archivos de migración: `npx prisma db push`).*

### 5. Levantar el Servidor de Desarrollo
```bash
npm run dev
```
El servidor escuchará por defecto en `http://localhost:4000`.

---

## 📜 Scripts Disponibles

| Script | Descripción |
| :--- | :--- |
| `npm run dev` | Inicia el servidor en modo desarrollo con recarga automática (`nodemon`). |
| `npm run build` | Compila el código TypeScript a JavaScript en `dist/`. |
| `npm run start` | Ejecuta el build de producción desde `dist/server.js`. |
| `npx prisma studio` | Abre la interfaz web gráfica de Prisma para inspeccionar datos. |

---

## 📐 Estándares de la API

### Formato de Respuestas JSON
Todas las respuestas de los endpoints siguen una estructura homogénea:

**Respuesta Exitosa (HTTP 200 / 201):**
```json
{
  "success": true,
  "data": {
    "id_alumna": "e4b5...",
    "nombre": "Martina",
    "apellido": "González"
  }
}
```

**Respuesta con Error (HTTP 4xx / 5xx):**
```json
{
  "success": false,
  "error": "La alumna indicada no pertenece al grupo seleccionado"
}
```

---

## 🛡️ Reglas de Desarrollo
Consulta el archivo [RULES.md](file:///c:/Users/usuario/Desktop/proyecto%20ACROSS/repos%20across/across-backend/RULES.md) para conocer las pautas obligatorias de nomenclatura en español, uso de UUIDs en Prisma, TypeScript estricto y retornos tempranos (*early returns*).
