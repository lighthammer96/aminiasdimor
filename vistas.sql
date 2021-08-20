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


--- vista_asociados_traslados
SELECT m.idmiembro, m.idtipodoc, m.nrodoc, d.descripcion AS division, p.pais_descripcion AS pais, u.descripcion AS union,
mi.descripcion AS mision, dm.descripcion AS distritomisionero, i.descripcion AS iglesia, td.descripcion AS tipo_documento,
m.iddivision, m.pais_id, m.idunion, m.idmision, m.iddistritomisionero, m.idiglesia
FROM iglesias.miembro AS m
INNER JOIN iglesias.division AS d ON(m.iddivision=d.iddivision)
INNER JOIN iglesias.paises AS p ON(m.pais_id=p.pais_id)
INNER JOIN iglesias.union AS u ON(m.idunion=u.idunion)
INNER JOIN iglesias.mision AS mi ON(m.idmision=mi.idmision)
INNER JOIN iglesias.distritomisionero AS dm ON(m.iddistritomisionero=dm.iddistritomisionero)
INNER JOIN iglesias.iglesia AS i ON(m.idiglesia=i.idiglesia)
INNER JOIN public.tipodoc AS td ON(td.idtipodoc=i.idiglesia)


--- vista_jerarquia

SELECT d.descripcion AS division, p.pais_descripcion AS pais, u.descripcion AS union,
mi.descripcion AS mision, dm.descripcion AS distritomisionero, i.descripcion AS iglesia,
d.iddivision, p.pais_id, u.idunion, mi.idmision, dm.iddistritomisionero, i.idiglesia
FROM  iglesias.division AS d  
INNER JOIN iglesias.paises AS p ON(d.iddivision=p.iddivision)
INNER JOIN iglesias.union_paises AS up ON(up.pais_id=p.pais_id)
INNER JOIN iglesias.union AS u ON(up.idunion=u.idunion)
INNER JOIN iglesias.mision AS mi ON(u.idunion=mi.idunion)
INNER JOIN iglesias.distritomisionero AS dm ON(mi.idmision=dm.idmision)
INNER JOIN iglesias.iglesia AS i ON(dm.iddistritomisionero=i.iddistritomisionero)



-- vista_division_politica

SELECT d.descripcion AS departamento, p.descripcion AS provincia, dd.descripcion AS distrito,
d.iddepartamento, p.idprovincia, dd.iddistrito
FROM public.departamento AS d
LEFT JOIN public.provincia AS p ON(d.iddepartamento=p.iddepartamento)
LEFT JOIN public.distrito AS dd ON(dd.idprovincia=p.idprovincia)