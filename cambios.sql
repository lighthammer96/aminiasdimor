-- 24/09/2021
ALTER TABLE "iglesias"."capacitacion_miembro"
  ADD CONSTRAINT "fk_miembro_capacitacion_miembro" FOREIGN KEY ("idmiembro") REFERENCES "iglesias"."miembro" ("idmiembro");


  ALTER TABLE "iglesias"."cargo_miembro"
  ADD CONSTRAINT "fk_miembro_cargo_miembro" FOREIGN KEY ("idmiembro") REFERENCES "iglesias"."miembro" ("idmiembro"),
  ADD CONSTRAINT "fk_cargo_cargo_miembro" FOREIGN KEY ("idcargo") REFERENCES "public"."cargo" ("idcargo"),
  ADD CONSTRAINT "fk_institucion_cargo_miembro" FOREIGN KEY ("idinstitucion") REFERENCES "iglesias"."institucion" ("idinstitucion");



  ALTER TABLE "iglesias"."control_traslados"
  ADD CONSTRAINT "fk_miembro_control_traslados" FOREIGN KEY ("idmiembro") REFERENCES "iglesias"."miembro" ("idmiembro"),
  ADD CONSTRAINT "fk_iglesiaactual_control_traslados" FOREIGN KEY ("idiglesiaactual") REFERENCES "iglesias"."iglesia" ("idiglesia"),
  ADD CONSTRAINT "fk_iglesiaanterior_control_traslados" FOREIGN KEY ("idiglesiaanterior") REFERENCES "iglesias"."iglesia" ("idiglesia");



  ALTER TABLE "iglesias"."controlactmisionera"
  ADD CONSTRAINT "fk_actividadmisionera_controlactmisionera" FOREIGN KEY ("idactividadmisionera") REFERENCES "iglesias"."actividadmisionera" ("idactividadmisionera"),
  ADD CONSTRAINT "fk_iglesia_controlactmisionera" FOREIGN KEY ("idiglesia") REFERENCES "iglesias"."iglesia" ("idiglesia");


  ALTER TABLE "iglesias"."distritomisionero"
  ADD CONSTRAINT "fk_mision_distritomisionero" FOREIGN KEY ("idmision") REFERENCES "iglesias"."mision" ("idmision");


  ALTER TABLE "iglesias"."division_idiomas"
  ADD CONSTRAINT "fk_division_division_idiomas" FOREIGN KEY ("iddivision") REFERENCES "iglesias"."division" ("iddivision"),
  ADD CONSTRAINT "fk_idiomas_division_idioma" FOREIGN KEY ("idioma_id") REFERENCES "public"."idiomas" ("idioma_id");


  ALTER TABLE "iglesias"."educacion_miembro"
  ADD CONSTRAINT "fk_miembro_educacion_miembro" FOREIGN KEY ("idmiembro") REFERENCES "iglesias"."miembro" ("idmiembro");



  ALTER TABLE "iglesias"."eleccion"
  ADD CONSTRAINT "fk_iglesia_eleccion" FOREIGN KEY ("idiglesia") REFERENCES "iglesias"."iglesia" ("idiglesia");



  ALTER TABLE "iglesias"."historial_altasybajas"
  ADD CONSTRAINT "fk_miembro_historial_altasybajas" FOREIGN KEY ("idmiembro") REFERENCES "iglesias"."miembro" ("idmiembro");



  ALTER TABLE "iglesias"."historial_traslados"
  ADD CONSTRAINT "fk_miembro_historial_traslados" FOREIGN KEY ("idmiembro") REFERENCES "iglesias"."miembro" ("idmiembro");


  ALTER TABLE "iglesias"."iglesia"
  ADD CONSTRAINT "fk_categoriaiglesia_iglesia" FOREIGN KEY ("idcategoriaiglesia") REFERENCES "iglesias"."categoriaiglesia" ("idcategoriaiglesia"),
  ADD CONSTRAINT "fk_distritomisionero_iglesia" FOREIGN KEY ("iddistritomisionero") REFERENCES "iglesias"."distritomisionero" ("iddistritomisionero"),
  ADD CONSTRAINT "fk_distrito_iglesia" FOREIGN KEY ("iddistrito") REFERENCES "public"."distrito" ("iddistrito");


ALTER TABLE "iglesias"."institucion"
  ADD CONSTRAINT "fk_iglesia_institucion" FOREIGN KEY ("idiglesia") REFERENCES "iglesias"."iglesia" ("idiglesia");



  ALTER TABLE "iglesias"."laboral_miembro"
  ADD CONSTRAINT "fk_miembro_laboral_miembro" FOREIGN KEY ("idmiembro") REFERENCES "iglesias"."miembro" ("idmiembro");



ALTER TABLE "iglesias"."miembro" RENAME COLUMN "pais_iddomicilio" TO "pais_id_domicilio";

ALTER TABLE "iglesias"."miembro"
  ADD CONSTRAINT "fk_distrito_miembro" FOREIGN KEY ("iddistritodomicilio") REFERENCES "public"."distrito" ("iddistrito"),
  ADD CONSTRAINT "fk_tipodoc_miembro" FOREIGN KEY ("idtipodoc") REFERENCES "public"."tipodoc" ("idtipodoc"),
  ADD CONSTRAINT "fk_estadocivil_miembro" FOREIGN KEY ("idestadocivil") REFERENCES "public"."estadocivil" ("idestadocivil"),
  ADD CONSTRAINT "fk_ocupacion_miembro" FOREIGN KEY ("idocupacion") REFERENCES "public"."ocupacion" ("idocupacion"),
  ADD CONSTRAINT "fk_gradoinstruccion_miembro" FOREIGN KEY ("idgradoinstruccion") REFERENCES "public"."gradoinstruccion" ("idgradoinstruccion"),
  ADD CONSTRAINT "fk_religion_miembro" FOREIGN KEY ("idreligion") REFERENCES "iglesias"."religion" ("idreligion"),
  ADD CONSTRAINT "fk_condicioneclesiastica_miembro" FOREIGN KEY ("idcondicioneclesiastica") REFERENCES "iglesias"."condicioneclesiastica" ("idcondicioneclesiastica"),
  ADD CONSTRAINT "fk_iglesia_miembro" FOREIGN KEY ("idiglesia") REFERENCES "iglesias"."iglesia" ("idiglesia"),
  ADD CONSTRAINT "fk_pais_miembro" FOREIGN KEY ("pais_id_nacimiento") REFERENCES "public"."pais" ("idpais");

  ALTER TABLE "iglesias"."union"
  ADD PRIMARY KEY ("idunion");


  ALTER TABLE "iglesias"."mision"
  ADD CONSTRAINT "fk_union_mision" FOREIGN KEY ("idunion") REFERENCES "iglesias"."union" ("idunion");


  ALTER TABLE "iglesias"."otras_propiedades"
  ADD CONSTRAINT "fk_iglesia_otraspropiedades" FOREIGN KEY ("idiglesia") REFERENCES "iglesias"."iglesia" ("idiglesia");



  ALTER TABLE "iglesias"."otrospastores"
  ADD CONSTRAINT "fk_cargo_otrospastores" FOREIGN KEY ("idcargo") REFERENCES "public"."cargo" ("idcargo"),
  ADD CONSTRAINT "fk_tipodoc_otrospastores" FOREIGN KEY ("idtipodoc") REFERENCES "public"."tipodoc" ("idtipodoc");


  ALTER TABLE "iglesias"."paises"
  ADD CONSTRAINT "fk_idiomas_paises" FOREIGN KEY ("idioma_id") REFERENCES "public"."idiomas" ("idioma_id"),
  ADD CONSTRAINT "fk_division_paises" FOREIGN KEY ("iddivision") REFERENCES "iglesias"."division" ("iddivision");


  ALTER TABLE "iglesias"."paises_idiomas"
  ADD CONSTRAINT "fk_paises_paises_idiomas" FOREIGN KEY ("pais_id") REFERENCES "iglesias"."paises" ("pais_id"),
  ADD CONSTRAINT "fk_idiomas_paises_idiomas" FOREIGN KEY ("idioma_id") REFERENCES "public"."idiomas" ("idioma_id");


  ALTER TABLE "iglesias"."paises_jerarquia"
  ADD CONSTRAINT "fk_paises_paises_jerarquia" FOREIGN KEY ("pais_id") REFERENCES "iglesias"."paises" ("pais_id");


  ALTER TABLE "iglesias"."parentesco_miembro"
  ADD CONSTRAINT "fk_miembro_parentesco_miembro" FOREIGN KEY ("idmiembro") REFERENCES "iglesias"."miembro" ("idmiembro"),
  ADD CONSTRAINT "fk_parentesco_parentesco_miembro" FOREIGN KEY ("idparentesco") REFERENCES "public"."parentesco" ("idparentesco"),
  ADD CONSTRAINT "fk_pais_parentesco_miembro" FOREIGN KEY ("idpais") REFERENCES "public"."pais" ("idpais");


  ALTER TABLE "iglesias"."temp_traslados"
  ADD CONSTRAINT "fk_miembro_temp_traslados" FOREIGN KEY ("idmiembro") REFERENCES "iglesias"."miembro" ("idmiembro");




  ALTER TABLE "iglesias"."union_paises"
  ADD CONSTRAINT "fk_union_union_paises" FOREIGN KEY ("idunion") REFERENCES "iglesias"."union" ("idunion"),
  ADD CONSTRAINT "fk_paises_union_paises" FOREIGN KEY ("pais_id") REFERENCES "iglesias"."paises" ("pais_id");


ALTER TABLE "public"."distrito"
  ADD CONSTRAINT "fk_provincia_distrito" FOREIGN KEY ("idprovincia") REFERENCES "public"."provincia" ("idprovincia");


  ALTER TABLE "public"."provincia"
  ADD CONSTRAINT "fk_departamento_provincia" FOREIGN KEY ("iddepartamento") REFERENCES "public"."departamento" ("iddepartamento");


  ALTER TABLE "public"."nivel"
  ADD CONSTRAINT "fk_tipocargo_nivel" FOREIGN KEY ("idtipocargo") REFERENCES "public"."tipocargo" ("idtipocargo");


  ALTER TABLE "public"."cargo"
  ADD CONSTRAINT "fk_nivel_cargo" FOREIGN KEY ("idnivel") REFERENCES "public"."nivel" ("idnivel");


  -- 29/09/2021
  ALTER TABLE "iglesias"."miembro"
  ADD COLUMN "nropasaporte" varchar(50),
  ADD COLUMN "fecha_vencimiento_pasaporte" date,
  ADD COLUMN "fecha_pasaje" date,
  ADD COLUMN "hora_arribo" time,
  ADD COLUMN "aerolinea" varchar(255),
  ADD COLUMN "aeropuerto" varchar(255),
  ADD COLUMN "posee_seguro" char(1),
  ADD COLUMN "fecha_inicia_seguro" date,
  ADD COLUMN "fecha_termina_seguro" date,
  ADD COLUMN "posee_visa" char(1),
  ADD COLUMN "fecha_vencimiento_visa" date;

COMMENT ON COLUMN "iglesias"."miembro"."posee_seguro" IS 'S -> SI
N -> NO';

COMMENT ON COLUMN "iglesias"."miembro"."posee_visa" IS 'S -> SI
N -> NO';

 --- 23/11/2021
 ALTER TABLE "iglesias"."miembro"
  ADD COLUMN "pasaporte_expedido_por" varchar(255);

ALTER TABLE "iglesias"."miembro"
  ADD COLUMN "fecha_emision_pasaporte" date;

--- 19/03/2023
ALTER TABLE "iglesias"."otrospastores"
  ADD COLUMN "idpais" int2,
  ADD CONSTRAINT "fk_pais_otrospastores" FOREIGN KEY ("idpais") REFERENCES "public"."pais" ("idpais");



--- 19/04/2023
ALTER TABLE seguridad.usuarios ADD CONSTRAINT fk_perfiles_usuarios FOREIGN KEY (perfil_id) REFERENCES seguridad.perfiles(perfil_id);

ALTER TABLE seguridad.log_sistema ADD CONSTRAINT fk_perfiles_log_sistema FOREIGN KEY (idperfil) REFERENCES seguridad.perfiles(perfil_id);

ALTER TABLE seguridad.usuarios ADD CONSTRAINT fk_tipoacceso_usuarios FOREIGN KEY (idtipoacceso) REFERENCES seguridad.tipoacceso(idtipoacceso);

ALTER TABLE seguridad.permisos ADD CONSTRAINT fk_perfiles_permisos FOREIGN KEY (perfil_id) REFERENCES seguridad.perfiles(perfil_id);
ALTER TABLE seguridad.permisos ADD CONSTRAINT fk_modulos_permisos FOREIGN KEY (modulo_id) REFERENCES seguridad.modulos(modulo_id);


ALTER TABLE seguridad.modulos_idiomas ADD CONSTRAINT fk_modulos_modulos_idiomas FOREIGN KEY (modulo_id) REFERENCES seguridad.modulos(modulo_id);
ALTER TABLE seguridad.modulos_idiomas ADD CONSTRAINT fk_idiomas_modulos_idiomas FOREIGN KEY (idioma_id) REFERENCES public.idiomas(idioma_id);


ALTER TABLE seguridad.perfiles_idiomas ADD CONSTRAINT fk_perfiles_perfiles_idiomas FOREIGN KEY (perfil_id) REFERENCES seguridad.perfiles(perfil_id);
ALTER TABLE seguridad.perfiles_idiomas ADD CONSTRAINT fk_idiomas_perfiles_idiomas FOREIGN KEY (idioma_id) REFERENCES public.idiomas(idioma_id);
