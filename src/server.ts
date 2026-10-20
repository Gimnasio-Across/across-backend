import express, { Request, Response } from "express";
import cors from "cors";
import dotenv from "dotenv";
import { prisma } from "./config/prisma";

// Cargar variables de entorno
dotenv.config();

const app = express();
const puerto = process.env.PORT || 4000;

// Middlewares globales
app.use(express.json());
app.use(
  cors({
    origin: [
      process.env.CORS_ORIGIN_ADMIN || "http://localhost:5173",
      process.env.CORS_ORIGIN_PWA || "http://localhost:5174",
    ],
    credentials: true,
  })
);

// Ruta de estado general del servidor
app.get("/api/salud", (_req: Request, res: Response) => {
  return res.json({
    success: true,
    data: {
      mensaje: "Servidor ACROSS Backend operativo",
      entorno: process.env.NODE_ENV || "development",
      timestamp: new Date().toISOString(),
    },
  });
});

// Ruta para verificar conectividad con la base de datos Neon
app.get("/api/salud/db", async (_req: Request, res: Response) => {
  try {
    // Consulta de prueba a la base de datos Neon
    const cantidadDisciplinas = await prisma.disciplina.count();

    return res.json({
      success: true,
      data: {
        estado_base_datos: "Conectada a Neon PostgreSQL",
        cantidad_disciplinas: cantidadDisciplinas,
      },
    });
  } catch (error) {
    const mensajeError =
      error instanceof Error ? error.message : "Error desconocido al conectar con Neon";

    return res.status(500).json({
      success: false,
      error: `Error de conexión a la base de datos: ${mensajeError}`,
    });
  }
});

// Levantar el servidor
if (process.env.NODE_ENV !== "test") {
  app.listen(puerto, () => {
    console.log(`🚀 Servidor ACROSS corriendo en http://localhost:${puerto}`);
  });
}

export default app;
