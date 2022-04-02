
--- gestion de iglesias

TRUNCATE iglesias.cargo_miembro RESTART IDENTITY;
TRUNCATE iglesias.controlactmisionera RESTART IDENTITY;
TRUNCATE iglesias.educacion_miembro RESTART IDENTITY;
TRUNCATE iglesias.eleccion RESTART IDENTITY;
TRUNCATE iglesias.institucion RESTART IDENTITY;
TRUNCATE iglesias.laboral_miembro RESTART IDENTITY;
TRUNCATE iglesias.otras_propiedades RESTART IDENTITY;
TRUNCATE iglesias.otrospastores RESTART IDENTITY;
TRUNCATE iglesias.parentesco_miembro RESTART IDENTITY;

TRUNCATE iglesias.historial_altasybajas RESTART IDENTITY;
TRUNCATE iglesias.control_traslados RESTART IDENTITY;
TRUNCATE iglesias.capacitacion_miembro RESTART IDENTITY;
TRUNCATE iglesias.historial_traslados RESTART IDENTITY;
TRUNCATE iglesias.temp_traslados;
TRUNCATE iglesias.miembro RESTART IDENTITY;


TRUNCATE public.procesos RESTART IDENTITY;
TRUNCATE seguridad.log_sistema RESTART IDENTITY;

--- gestion de asambleas

TRUNCATE asambleas.agenda RESTART IDENTITY;
TRUNCATE asambleas.delegados RESTART IDENTITY;

TRUNCATE asambleas.detalle_asistencia RESTART IDENTITY;
TRUNCATE asambleas.asistencia RESTART IDENTITY;
TRUNCATE asambleas.comentarios RESTART IDENTITY;
TRUNCATE asambleas.detalle_propuestas RESTART IDENTITY;

TRUNCATE asambleas.foros RESTART IDENTITY;
TRUNCATE asambleas.traduccion_propuestas_elecciones RESTART IDENTITY;
TRUNCATE asambleas.traduccion_propuestas_temas RESTART IDENTITY;

TRUNCATE asambleas.propuestas_elecciones RESTART IDENTITY;
TRUNCATE asambleas.propuestas_origen RESTART IDENTITY;
TRUNCATE asambleas.propuestas_temas RESTART IDENTITY;
TRUNCATE asambleas.traduccion_resoluciones RESTART IDENTITY;
TRUNCATE asambleas.resoluciones RESTART IDENTITY;
TRUNCATE asambleas.resultados RESTART IDENTITY;
TRUNCATE asambleas.votos RESTART IDENTITY;
TRUNCATE asambleas.votaciones RESTART IDENTITY;

TRUNCATE asambleas.asambleas RESTART IDENTITY;


