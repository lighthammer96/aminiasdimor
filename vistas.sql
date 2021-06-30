-- vista responsables
SELECT m.idmiembro AS id,  (m.apellidos || ', ' || m.nombres) AS nombres, 'iglesias.miembro' AS tabla, td.descripcion AS tipo_documento, m.nrodoc
FROM iglesias.miembro AS m
-- JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
--INNER JOIN public.cargo AS c ON(c.idcargo=cm.idcargo)
INNER JOIN public.tipodoc AS td ON(td.idtipodoc=m.idtipodoc)
WHERE m.idmiembro IN (SELECT idmiembro FROM iglesias.cargo_miembro WHERE idcargo IS NOT NULL)
UNION ALL

SELECT ot.idotrospastores AS id, (ot.nombrecompleto) AS nombres, 'iglesias.otrospastores' AS tabla, td.descripcion AS tipo_documento, ot.nrodoc
FROM iglesias.otrospastores AS ot
INNER JOIN public.cargo AS c ON(c.idcargo=ot.idcargo)
INNER JOIN public.tipodoc AS td ON(td.idtipodoc=ot.idtipodoc)
WHERE ot.idcargo IS NOT NULL

--- pruebas

select idmiembro, nombres, paterno, materno, estado, estadoeliminado from miembro 


where estado=0 and 
idmiembro=113
