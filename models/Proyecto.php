<?php

class Proyecto {
    private $id_proyecto;
    private $id_usuario;
    private $nombre;
    private $descripcion;
    private $fecha_inicio;
    private $estado;

    public function __construct($id_proyecto,$id_usuario, $nombre,$descripcion, $fecha_inicio,$estado) {
        $this->id_proyecto =$id_proyecto;
        $this->id_usuario =$id_usuario;
        $this->nombre =$nombre;
        $this->descripcion =$descripcion;
        $this->fecha_inicio =$fecha_inicio;
        $this->estado =$estado;
    }

    public function getIdProyecto() {
        return $this->id_proyecto;
    }

    public function getIdUsuario() {
        return $this->id_usuario;
    }

    public function getNombre() {
        return $this->nombre;
    }

    public function getDescripcion() {
        return $this->descripcion;
    }

    public function getFechaInicio() {
        return $this->fecha_inicio;
    }

    public function getEstado() {
        return $this->estado;
    }
}