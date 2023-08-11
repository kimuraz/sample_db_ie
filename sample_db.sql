CREATE TABLE "public.aluno" (
	"id" serial NOT NULL UNIQUE,
	"sobrenome" VARCHAR(255) NOT NULL,
	"nome" VARCHAR(255) NOT NULL,
	"data_nascimento" DATE NOT NULL,
	"email" VARCHAR(255) NOT NULL,
	"endereco" TEXT NOT NULL,
	"telefone" VARCHAR(255) NOT NULL,
	CONSTRAINT "aluno_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.matricula" (
	"id" serial NOT NULL UNIQUE,
	"aluno_id" integer NOT NULL,
	"curso_id" integer NOT NULL,
	"data_inicio" DATE NOT NULL,
	"data_final" DATE NOT NULL,
	"ativo" bool NOT NULL DEFAULT 'true',
	"senha" VARCHAR(255) NOT NULL,
	CONSTRAINT "matricula_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.curso" (
	"id" serial NOT NULL UNIQUE,
	"id_coordenador" integer NOT NULL,
	"id_departamento" integer NOT NULL,
	"nome" VARCHAR(255) NOT NULL,
	"descricao" TEXT,
	"nota_mec" integer,
	"duracao_semestres" integer NOT NULL,
	CONSTRAINT "curso_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.professor" (
	"id" serial NOT NULL UNIQUE,
	"sobrenome" VARCHAR(255) NOT NULL,
	"nome" VARCHAR(255) NOT NULL,
	"data_nascimento" DATE NOT NULL,
	"email" VARCHAR(255) NOT NULL,
	"endereco" TEXT NOT NULL,
	"telefone" VARCHAR(255) NOT NULL,
	"especializacao" VARCHAR(255) NOT NULL,
	"senha" VARCHAR(255) NOT NULL,
	CONSTRAINT "professor_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.departamento" (
	"id" serial NOT NULL UNIQUE,
	"id_diretor" integer NOT NULL,
	"nome" VARCHAR(255) NOT NULL,
	"email_departamento" VARCHAR(255) NOT NULL,
	"descricao" TEXT,
	CONSTRAINT "departamento_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.avisos" (
	"id" serial NOT NULL UNIQUE,
	"id_turma" integer NOT NULL,
	"id_autor" integer NOT NULL,
	"titulo" VARCHAR(255) NOT NULL,
	"mensagem" TEXT NOT NULL,
	CONSTRAINT "avisos_pk" PRIMARY KEY ("id","id_turma","id_autor")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.turma" (
	"id" serial NOT NULL UNIQUE,
	"id_professor_resp" integer NOT NULL,
	"id_materia" integer NOT NULL,
	CONSTRAINT "turma_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.material_didatico" (
	"id" serial NOT NULL UNIQUE,
	"id_aula" integer NOT NULL,
	"titulo" VARCHAR(255) NOT NULL,
	"descricao" TEXT,
	"tipo" VARCHAR(255) NOT NULL,
	"conteudo" TEXT,
	"link_externo" VARCHAR(255),
	CONSTRAINT "material_didatico_pk" PRIMARY KEY ("id","id_aula")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.avaliacao" (
	"id" serial NOT NULL UNIQUE,
	"nome" VARCHAR(255) NOT NULL,
	"data_inicial" DATE NOT NULL,
	"data_final" DATE NOT NULL,
	"tipo" VARCHAR(255) NOT NULL,
	"nota_max" float4 NOT NULL,
	"peso" float4 NOT NULL,
	"id_turma" integer NOT NULL,
	CONSTRAINT "avaliacao_pk" PRIMARY KEY ("id","id_turma")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.aula" (
	"id" serial NOT NULL UNIQUE,
	"id_materia" integer NOT NULL,
	"titulo" VARCHAR(255) NOT NULL,
	"descricao" TEXT NOT NULL,
	"introducao" TEXT NOT NULL,
	"conclusao" TEXT,
	CONSTRAINT "aula_pk" PRIMARY KEY ("id","id_materia")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.materia" (
	"id" serial NOT NULL UNIQUE,
	"id_curso" integer NOT NULL,
	"nome" VARCHAR(255) NOT NULL,
	"descricao" TEXT,
	"carga_horaria_horas" integer NOT NULL,
	CONSTRAINT "materia_pk" PRIMARY KEY ("id","id_curso")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.nota" (
	"id" serial NOT NULL UNIQUE,
	"id_avaliacao" integer NOT NULL,
	"id_aluno" integer NOT NULL,
	"data_avaliacao" DATE NOT NULL,
	"data_correcao" DATE NOT NULL,
	"nota" float4 NOT NULL,
	CONSTRAINT "nota_pk" PRIMARY KEY ("id","id_avaliacao","id_aluno")
) WITH (
  OIDS=FALSE
);




ALTER TABLE "public.matricula" ADD CONSTRAINT "matricula_fk0" FOREIGN KEY ("aluno_id") REFERENCES "public.aluno"("id");
ALTER TABLE "public.matricula" ADD CONSTRAINT "matricula_fk1" FOREIGN KEY ("curso_id") REFERENCES "public.curso"("id");

ALTER TABLE "public.curso" ADD CONSTRAINT "curso_fk0" FOREIGN KEY ("id_coordenador") REFERENCES "public.professor"("id");
ALTER TABLE "public.curso" ADD CONSTRAINT "curso_fk1" FOREIGN KEY ("id_departamento") REFERENCES "public.departamento"("id");


ALTER TABLE "public.departamento" ADD CONSTRAINT "departamento_fk0" FOREIGN KEY ("id_diretor") REFERENCES "public.professor"("id");

ALTER TABLE "public.avisos" ADD CONSTRAINT "avisos_fk0" FOREIGN KEY ("id_turma") REFERENCES "public.turma"("id");
ALTER TABLE "public.avisos" ADD CONSTRAINT "avisos_fk1" FOREIGN KEY ("id_autor") REFERENCES "public.professor"("id");

ALTER TABLE "public.turma" ADD CONSTRAINT "turma_fk0" FOREIGN KEY ("id_professor_resp") REFERENCES "public.professor"("id");
ALTER TABLE "public.turma" ADD CONSTRAINT "turma_fk1" FOREIGN KEY ("id_materia") REFERENCES "public.materia"("id");

ALTER TABLE "public.material_didatico" ADD CONSTRAINT "material_didatico_fk0" FOREIGN KEY ("id_aula") REFERENCES "public.aula"("id");

ALTER TABLE "public.avaliacao" ADD CONSTRAINT "avaliacao_fk0" FOREIGN KEY ("id_turma") REFERENCES "public.turma"("id");

ALTER TABLE "public.aula" ADD CONSTRAINT "aula_fk0" FOREIGN KEY ("id_materia") REFERENCES "public.materia"("id");

ALTER TABLE "public.materia" ADD CONSTRAINT "materia_fk0" FOREIGN KEY ("id_curso") REFERENCES "public.curso"("id");

ALTER TABLE "public.nota" ADD CONSTRAINT "nota_fk0" FOREIGN KEY ("id_avaliacao") REFERENCES "public.avaliacao"("id");
ALTER TABLE "public.nota" ADD CONSTRAINT "nota_fk1" FOREIGN KEY ("id_aluno") REFERENCES "public.aluno"("id");













