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
│   └── schema.prisma         # Definición de modelos relacionales y migraciones
├── src/
│   ├── config/               # Configuración de entorno y clientes (BD, Prisma)
│   ├── controllers/          # Manejadores de peticiones HTTP
│   ├── middlewares/          # Validaciones, autenticación y manejo global de errores
│   ├── routes/               # Definición de rutas y endpoints de la API
│   ├── services/             # Lógica de negocio (asistencias, cuotas, orden del día)
│   ├── types/                # Interfaces y tipos TypeScript
│   ├── utils/                # Utilidades y formateadores
│   └── server.ts             # Punto de entrada y levantamiento del servidor Express
├── .env.example              # Plantilla de variables de entorno (SIEMPRE commitear)
├── .gitignore                # Archivos y carpetas excluidos del control de versiones
├── .cursorrules              # Reglas de desarrollo estrictas para pair-programming
├── package.json              # Dependencias y scripts
├── prisma.config.ts          # Configuración del CLI de Prisma
└── tsconfig.json             # Configuración del compilador TypeScript
```

---

## 🚀 Instalación y Puesta en Marcha Local

### 1. Prerrequisitos
- Tener instalado [Node.js](https://nodejs.org/) (v18 o superior).
- Tener una instancia de [PostgreSQL](https://www.postgresql.org/) en ejecución.

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
Edita `.env` con las credenciales de tu PostgreSQL local:
```env
PORT=4000
NODE_ENV=development
DATABASE_URL="postgresql://usuario:password@localhost:5432/across_db?schema=public"
```

### 4. Ejecutar Migraciones de Base de Datos
Crea las tablas en tu base de datos PostgreSQL:
```bash
npx prisma migrate dev --name init_across_schema
```

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
Consulta el archivo [.cursorrules](file:///c:/Users/usuario/Desktop/proyecto%20ACROSS/repos%20across/across-backend/.cursorrules) para conocer las pautas obligatorias de nomenclatura en español, uso de UUIDs en Prisma, TypeScript estricto y retornos tempranos (*early returns*).
