-- CreateTable
CREATE TABLE "Disciplina" (
    "id_disciplina" SERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,

    CONSTRAINT "Disciplina_pkey" PRIMARY KEY ("id_disciplina")
);

-- CreateTable
CREATE TABLE "Profesor" (
    "id_profesor" UUID NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,

    CONSTRAINT "Profesor_pkey" PRIMARY KEY ("id_profesor")
);

-- CreateTable
CREATE TABLE "Profesor_Disciplina" (
    "id_profesor" UUID NOT NULL,
    "id_disciplina" INTEGER NOT NULL,

    CONSTRAINT "Profesor_Disciplina_pkey" PRIMARY KEY ("id_profesor","id_disciplina")
);

-- CreateTable
CREATE TABLE "Tutor" (
    "id_tutor" UUID NOT NULL,
    "nombre" VARCHAR(150) NOT NULL,
    "dni" VARCHAR(20) NOT NULL,
    "telefono" VARCHAR(50),
    "email" VARCHAR(100),

    CONSTRAINT "Tutor_pkey" PRIMARY KEY ("id_tutor")
);

-- CreateTable
CREATE TABLE "Alumna" (
    "id_alumna" UUID NOT NULL,
    "nombre" VARCHAR(150) NOT NULL,
    "fecha_nacimiento" DATE NOT NULL,
    "id_tutor" UUID NOT NULL,
    "se_retira_sola" BOOLEAN NOT NULL DEFAULT false,
    "permiso_fotos" BOOLEAN NOT NULL DEFAULT false,
    "observaciones_salud" TEXT,
    "apto_medico" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Alumna_pkey" PRIMARY KEY ("id_alumna")
);

-- CreateTable
CREATE TABLE "Grupo" (
    "id_grupo" UUID NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,
    "id_disciplina" INTEGER NOT NULL,
    "capacidad" INTEGER NOT NULL,
    "monto_cuota_base" DECIMAL(10,2) NOT NULL,

    CONSTRAINT "Grupo_pkey" PRIMARY KEY ("id_grupo")
);

-- CreateTable
CREATE TABLE "Inscripcion_Grupo" (
    "id_inscripcion" UUID NOT NULL,
    "id_alumna" UUID NOT NULL,
    "id_grupo" UUID NOT NULL,
    "numero_orden_dia" INTEGER NOT NULL,

    CONSTRAINT "Inscripcion_Grupo_pkey" PRIMARY KEY ("id_inscripcion")
);

-- CreateTable
CREATE TABLE "Clase_Dictada" (
    "id_clase" UUID NOT NULL,
    "id_grupo" UUID NOT NULL,
    "fecha" DATE NOT NULL,

    CONSTRAINT "Clase_Dictada_pkey" PRIMARY KEY ("id_clase")
);

-- CreateTable
CREATE TABLE "Registro_Asistencia" (
    "id_registro" UUID NOT NULL,
    "id_clase" UUID NOT NULL,
    "id_alumna" UUID NOT NULL,
    "presente" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Registro_Asistencia_pkey" PRIMARY KEY ("id_registro")
);

-- CreateTable
CREATE TABLE "Cuota_Mensual" (
    "id_cuota" UUID NOT NULL,
    "id_alumna" UUID NOT NULL,
    "mes" INTEGER NOT NULL,
    "anio" INTEGER NOT NULL,
    "monto_total" DECIMAL(10,2) NOT NULL,
    "estado" VARCHAR(20) NOT NULL DEFAULT 'pendiente',

    CONSTRAINT "Cuota_Mensual_pkey" PRIMARY KEY ("id_cuota")
);

-- CreateIndex
CREATE UNIQUE INDEX "Tutor_dni_key" ON "Tutor"("dni");

-- CreateIndex
CREATE UNIQUE INDEX "Tutor_email_key" ON "Tutor"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Inscripcion_Grupo_id_alumna_id_grupo_key" ON "Inscripcion_Grupo"("id_alumna", "id_grupo");

-- CreateIndex
CREATE UNIQUE INDEX "Clase_Dictada_id_grupo_fecha_key" ON "Clase_Dictada"("id_grupo", "fecha");

-- CreateIndex
CREATE UNIQUE INDEX "Registro_Asistencia_id_clase_id_alumna_key" ON "Registro_Asistencia"("id_clase", "id_alumna");

-- CreateIndex
CREATE UNIQUE INDEX "Cuota_Mensual_id_alumna_mes_anio_key" ON "Cuota_Mensual"("id_alumna", "mes", "anio");

-- AddForeignKey
ALTER TABLE "Profesor_Disciplina" ADD CONSTRAINT "Profesor_Disciplina_id_profesor_fkey" FOREIGN KEY ("id_profesor") REFERENCES "Profesor"("id_profesor") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Profesor_Disciplina" ADD CONSTRAINT "Profesor_Disciplina_id_disciplina_fkey" FOREIGN KEY ("id_disciplina") REFERENCES "Disciplina"("id_disciplina") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Alumna" ADD CONSTRAINT "Alumna_id_tutor_fkey" FOREIGN KEY ("id_tutor") REFERENCES "Tutor"("id_tutor") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Grupo" ADD CONSTRAINT "Grupo_id_disciplina_fkey" FOREIGN KEY ("id_disciplina") REFERENCES "Disciplina"("id_disciplina") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inscripcion_Grupo" ADD CONSTRAINT "Inscripcion_Grupo_id_alumna_fkey" FOREIGN KEY ("id_alumna") REFERENCES "Alumna"("id_alumna") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inscripcion_Grupo" ADD CONSTRAINT "Inscripcion_Grupo_id_grupo_fkey" FOREIGN KEY ("id_grupo") REFERENCES "Grupo"("id_grupo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Clase_Dictada" ADD CONSTRAINT "Clase_Dictada_id_grupo_fkey" FOREIGN KEY ("id_grupo") REFERENCES "Grupo"("id_grupo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Registro_Asistencia" ADD CONSTRAINT "Registro_Asistencia_id_clase_fkey" FOREIGN KEY ("id_clase") REFERENCES "Clase_Dictada"("id_clase") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Registro_Asistencia" ADD CONSTRAINT "Registro_Asistencia_id_alumna_fkey" FOREIGN KEY ("id_alumna") REFERENCES "Alumna"("id_alumna") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cuota_Mensual" ADD CONSTRAINT "Cuota_Mensual_id_alumna_fkey" FOREIGN KEY ("id_alumna") REFERENCES "Alumna"("id_alumna") ON DELETE CASCADE ON UPDATE CASCADE;
