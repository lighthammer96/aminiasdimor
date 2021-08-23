select i.idiglesia, i.descripcion as iglesia, i.direccion, i.telefono, dm.descripcion as distrito_misionero from iglesias.iglesia as i
LEFT join iglesias.distritomisionero as dm on (i.iddistritomisionero=dm.iddistritomisionero)
order by i.idiglesia asc


SELECT c.idcargo, c.descripcion as cargo, n.descripcion as nivel, tc.descripcion as tipo_cargo FROM public.cargo AS C

inner join public.nivel  as n on(c.idnivel=n.idnivel)
inner join public.tipocargo as tc on(tc.idtipocargo=n.idtipocargo)
order by tc.descripcion asc, c.idcargo ASC


select d.iddivision, di.di_descripcion as division from iglesias.division as d
INNER JOIN iglesias.division_idiomas as di on(di.iddivision=d.iddivision and di.idioma_id=1)
order by d.iddivision asc


select u.idunion, u.descripcion as union, p.pais_descripcion as pais from iglesias.union as u
inner join iglesias.union_paises as up on(up.idunion=u.idunion)
INNER JOIN iglesias.paises as p on(p.pais_id=up.pais_id)
order by u.idunion asc


select m.idmision, m.descripcion as mision, u.descripcion as union from iglesias.mision as m
inner join iglesias.union as u on(m.idunion=u.idunion)

order by m.idmision asc