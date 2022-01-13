
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

delete from asambleas.agenda;
delete from asambleas.delegados;

delete from asambleas.detalle_asistencia;
delete from asambleas.asistencia;
delete from asambleas.comentarios;
delete from asambleas.detalle_propuestas;

delete from asambleas.foros;
delete from asambleas.traduccion_propuestas_elecciones;
delete from asambleas.traduccion_propuestas_temas;

delete from asambleas.propuestas_elecciones;
delete from asambleas.propuestas_origen;
delete from asambleas.propuestas_temas;
delete from asambleas.traduccion_resoluciones;
delete from asambleas.resoluciones;
delete from asambleas.resultados;
delete from asambleas.votos;
delete from asambleas.votaciones;

delete from asambleas.asambleas;


