<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;

class AsociadosModel extends Model
{
    use HasFactory;


    private $tabla;

    public function __construct() {
        parent::__construct();
        
        $this->tabla = new Tabla();


    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-asociados");
        $this->tabla->agregarColumna("m.idmiembro", "idmiembro", "Id");
        $this->tabla->agregarColumna("m.nombres", "nombres", "Nombres");
        $this->tabla->agregarColumna("td.descripcion", "descripcion", "Documento");
        $this->tabla->agregarColumna("m.nrodoc", "nrodoc", "Número");
        $this->tabla->agregarColumna("m.email", "email", "Email");
        $this->tabla->agregarColumna("m.telefono", "telefono", "Email");
        $this->tabla->agregarColumna("m.celular", "celular", "Celular");
        $this->tabla->setSelect("m.idmiembro, (m.apellidos || ', ' || m.nombres) AS nombres, td.descripcion, m.nrodoc, m.email, m.telefono, m.celular");
        $this->tabla->setFrom("iglesias.miembro AS m
        \nLEFT JOIN public.tipodoc AS td ON(m.idtipodoc=td.idtipodoc)");

        return $this->tabla;
    }

    public function tabla_responsables() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-responsables");
        $this->tabla->agregarColumna("id", "id", "Id");
        $this->tabla->agregarColumna("nombres", "nombres", "Nombres");
        // $this->tabla->agregarColumna("cargo", "cargo", "Cargo");
        // $this->tabla->agregarColumna("periodo", "periodo", "Periodo");
        // $this->tabla->agregarColumna("vigente", "vigente", "Vigente");
        // $this->tabla->agregarColumna("tabla", "tabla", "Tabla");
        $this->tabla->setSelect("id, nombres /*, cargo, periodo, vigente, tabla*/");
        $this->tabla->setFrom("iglesias.vista_responsables");

        if(isset($_REQUEST["idmiembro"])) {
            $this->tabla->setWhere("(id || tabla <> '" . $_REQUEST["idmiembro"]. "iglesias.miembro')");
        }

        return $this->tabla;
    }
}
