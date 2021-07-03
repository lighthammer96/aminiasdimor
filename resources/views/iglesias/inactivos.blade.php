<center>
    <h3>{{ traducir("traductor.miembros_activos") }} <?php echo $iglesias[0]->iglesia; ?></h3>
    <table width="1100" border="1" cellpadding="3" cellspacing="3">
    <tr>
    <td width="312" bgcolor="#FF9933"><strong>{{ traducir("traductor.apellidos") }}</strong></td>

    <td width="403" bgcolor="#FF9933"><strong>{{ traducir("traductor.nombres") }}</strong></td>
    <td width="159" bgcolor="#FF9933"><strong>{{ traducir("traductor.celular") }}</strong></td>
    <td width="200" bgcolor="#FF9933"><strong>{{ traducir("traductor.tipo_documento") }}</strong></td>
    <td width="200" bgcolor="#FF9933"><strong>{{ traducir("traductor.numero_documento") }}</strong></td>
    </tr>

    <?php 
        foreach($iglesias as $key => $value) {
            echo "<tr>
                    <td>".$value->apellidos."</td>
                    <td>".$value->nombres."</td>
                    <td>".$value->celular."</td>
                    <td>".$value->tipo_documento."</td>
                    <td>".$value->nrodoc."</td>
                </tr>
                ";
        }
        

    ?>
    </table>
</center>