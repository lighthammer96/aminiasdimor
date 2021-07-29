-- 29/07/2021

DROP FUNCTION iglesias.fn_mostrar_jerarquia
( IN in_select VARCHAR, IN in_where VARCHAR, IN in_idioma_id INT, IN in_idioma_id_defecto INT);
CREATE FUNCTION iglesias.fn_mostrar_jerarquia
( IN in_select VARCHAR, IN in_where VARCHAR, IN in_idioma_id INT, IN in_idioma_id_defecto INT)
RETURNS VARCHAR AS
$BODY$
DECLARE
    jerarquia VARCHAR;
		sql VARCHAR;
BEGIN
	sql = 'SELECT (' || in_select || ') AS select  FROM (SELECT /*d.descripcion AS division, */
        CASE WHEN di.di_descripcion IS NULL THEN
        (SELECT di_descripcion FROM iglesias.division_idiomas WHERE iddivision=d.iddivision AND idioma_id='|| in_idioma_id_defecto ||')
        ELSE di.di_descripcion END AS division, 
        p.pais_descripcion AS pais, u.descripcion AS union,
        mi.descripcion AS mision, dm.descripcion AS distritomisionero, i.descripcion AS iglesia,
        d.iddivision, p.pais_id, u.idunion, mi.idmision, dm.iddistritomisionero, i.idiglesia
        FROM  iglesias.division AS d  
        LEFT JOIN iglesias.division_idiomas AS di on(di.iddivision=d.iddivision AND di.idioma_id='|| in_idioma_id ||')
        INNER JOIN iglesias.paises AS p ON(d.iddivision=p.iddivision)
        INNER JOIN iglesias.union_paises AS up ON(up.pais_id=p.pais_id)
        INNER JOIN iglesias.union AS u ON(up.idunion=u.idunion)
        INNER JOIN iglesias.mision AS mi ON(u.idunion=mi.idunion)
        INNER JOIN iglesias.distritomisionero AS dm ON(mi.idmision=dm.idmision)
        INNER JOIN iglesias.iglesia AS i ON(dm.iddistritomisionero=i.iddistritomisionero)
        WHERE ' || in_where || ' LIMIT 1 ) AS s';
				
    EXECUTE sql INTO jerarquia;
		return jerarquia;
END
$BODY$ LANGUAGE 'plpgsql'