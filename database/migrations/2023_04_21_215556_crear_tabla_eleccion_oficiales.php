<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class CrearTablaEleccionOficiales extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement("
            CREATE TABLE iglesias.eleccion_oficiales(
                eo_id serial,
                ideleccion int,
                idmiembro int,
                idtipocargo int,
                idnivel int,
                idcargo int,
                CONSTRAINT pk_eleccion_oficiales PRIMARY KEY(eo_id),
                CONSTRAINT fk_eleccion_eleccion_oficiales FOREIGN KEY(ideleccion) REFERENCES iglesias.eleccion(ideleccion),
                CONSTRAINT fk_tipocargo_eleccion_oficiales FOREIGN KEY(idtipocargo) REFERENCES public.tipocargo(idtipocargo),
                CONSTRAINT fk_nivel_eleccion_oficiales FOREIGN KEY(idnivel) REFERENCES public.nivel(idnivel),
                CONSTRAINT fk_cargo_eleccion_oficiales FOREIGN KEY(idcargo) REFERENCES public.cargo(idcargo),
                CONSTRAINT fk_miembro_eleccion_oficiales FOREIGN KEY(idmiembro) REFERENCES iglesias.miembro(idmiembro)


            );
        ");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::statement("DROP TABLE IF EXISTS iglesias.eleccion_oficiales;");
    }
}
