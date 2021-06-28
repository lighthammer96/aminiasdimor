-- vista responsables
SELECT m.idmiembro AS id, cm.idcargo,  (m.apellidos || ', ' || m.nombres) AS nombres, c.descripcion AS cargo, (cm.periodoini || '-' || cm.periodofin) AS periodo, cm.vigente, 'iglesias.miembro' AS tabla
FROM iglesias.miembro AS m
INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
INNER JOIN public.cargo AS c ON(c.idcargo=cm.idcargo)

UNION ALL

SELECT ot.idotrospastores AS id, c.idcargo, (ot.nombrecompleto) AS nombres, c.descripcion AS cargo, ot.periodo, ot.vigente, 'iglesias.otrospastores' AS tabla
FROM iglesias.otrospastores AS ot
INNER JOIN public.cargo AS c ON(c.idcargo=ot.idcargo)


--- pruebas

select idmiembro, nombres, paterno, materno, estado, estadoeliminado from miembro 


where estado=0 and 
idmiembro=113
