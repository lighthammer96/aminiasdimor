-- 23/06/2021
CREATE TABLE iglesias.division_idiomas
(
    iddivision integer,
    idioma_id integer,
    di_descripcion character varying(100)
);

CREATE TABLE public.paises_idiomas
(
    pais_id integer,
    idioma_id integer,
    pai_descripcion character varying(100)
);


CREATE TABLE iglesias.categoriaiglesia  (
  idcategoriaiglesia serial,
  descripcion varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (idcategoriaiglesia) 
) ;

-- ----------------------------
-- Records of iglesias.categoriaiglesia
-- ----------------------------
INSERT INTO iglesias.categoriaiglesia VALUES (1, 'Iglesia');
INSERT INTO iglesias.categoriaiglesia VALUES (2, 'Grupo');
INSERT INTO iglesias.categoriaiglesia VALUES (3, 'Filial');
INSERT INTO iglesias.categoriaiglesia VALUES (4, 'Aislado/Interesado');



CREATE TABLE tipoconstruccion  (
  idtipoconstruccion serial,
  descripcion varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (idtipoconstruccion) 
) ;

-- ----------------------------
-- Records of tipoconstruccion
-- ----------------------------
INSERT INTO tipoconstruccion VALUES (1, 'Adobe');
INSERT INTO tipoconstruccion VALUES (2, 'Ladrillos');
INSERT INTO tipoconstruccion VALUES (3, 'Madera');


CREATE TABLE tipodocumentacion  (
  idtipodocumentacion serial,
  descripcion varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (idtipodocumentacion) 
) ;

-- ----------------------------
-- Records of tipodocumentacion
-- ----------------------------
INSERT INTO tipodocumentacion VALUES (1, 'Documento Privado');
INSERT INTO tipodocumentacion VALUES (2, 'En Tramite');
INSERT INTO tipodocumentacion VALUES (3, 'Juez');
INSERT INTO tipodocumentacion VALUES (4, 'Minuta de Compra Venta');
INSERT INTO tipodocumentacion VALUES (5, 'No Tiene');
INSERT INTO tipodocumentacion VALUES (6, 'Notaria');
INSERT INTO tipodocumentacion VALUES (7, 'Simple');
INSERT INTO tipodocumentacion VALUES (8, 'Alquilado');
INSERT INTO tipodocumentacion VALUES (9, 'SUNARP');



CREATE TABLE tipoinmueble  (
  idtipoinmueble serial,
  descripcion varchar(50) NULL DEFAULT NULL,
  PRIMARY KEY (idtipoinmueble)
);

-- ----------------------------
-- Records of tipoinmueble
-- ----------------------------
INSERT INTO tipoinmueble VALUES (1, 'Terreno');
INSERT INTO tipoinmueble VALUES (2, 'Templo');
INSERT INTO tipoinmueble VALUES (3, 'Alquiler');
INSERT INTO tipoinmueble VALUES (4, 'En Uso');
INSERT INTO tipoinmueble VALUES (5, 'Templo y Casa Misión');
INSERT INTO tipoinmueble VALUES (6, 'Casa Misión');



CREATE TABLE condicioninmueble  (
  idcondicioninmueble serial,
  descripcion varchar(50) NULL DEFAULT NULL,
  PRIMARY KEY (idcondicioninmueble) 
);

-- ----------------------------
-- Records of condicioninmueble
-- ----------------------------
INSERT INTO condicioninmueble VALUES (1, 'Construido');
INSERT INTO condicioninmueble VALUES (2, 'Semiconstruido');
INSERT INTO condicioninmueble VALUES (3, 'En Construcción');
INSERT INTO condicioninmueble VALUES (4, 'En Litigio');



ALTER TABLE "iglesias"."iglesia" 
  ALTER COLUMN "idcategoriaiglesia" DROP NOT NULL,
  ALTER COLUMN "idtipoconstruccion" DROP NOT NULL,
  ALTER COLUMN "idtipodocumentacion" DROP NOT NULL,
  ALTER COLUMN "idtipoinmueble" DROP NOT NULL,
  ALTER COLUMN "idcondicioninmueble" DROP NOT NULL;
