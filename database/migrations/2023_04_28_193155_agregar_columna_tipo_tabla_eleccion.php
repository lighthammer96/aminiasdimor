<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class AgregarColumnaTipoTablaEleccion extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement("ALTER TABLE iglesias.eleccion ADD tipo char(1) NULL;
        COMMENT ON COLUMN iglesias.eleccion.tipo IS 'U -> union
        A -> asociacion
        I -> iglesia';");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::statement("ALTER TABLE iglesias.eleccion DROP COLUMN IF EXISTS tipo;");
    }
}
