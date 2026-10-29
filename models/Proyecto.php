<?php

class Proyecto {
    private $id;
    private $presupuesto_id;
    private $facturas_id;
    private $contenido;
    private $fecha_creacion;

    public function __construct($id, $presupuesto_id, $facturas_id, $contenido, $fecha_creacion) {
        $this->id = $id;
        $this->presupuesto_id = $presupuesto_id;
        $this->facturas_id = $facturas_id;
        $this->contenido = $contenido;
        $this->fecha_creacion = $fecha_creacion;
    }

    public function getId() {
        return $this->id;
    }

    public function getPresupuestoId() {
        return $this->presupuesto_id;
    }

    public function getFacturasId() {
        return $this->facturas_id;
    }

    public function getContent() {
        return $this->contenido;
    }

    public function getCreatedAt() {
        return $this->fecha_creacion;
    }
}