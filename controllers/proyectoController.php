<?php
    require_once ("models/Proyecto.php");

    class ProyectoController {
        private $db;

        public function __construct($conexionDB) {
            $this->db = $conexionDB;
        }
        public function listarProyectos() {
            try {
                $query = "SELECT * FROM proyectos";
                $stmt = $this->db->prepare($query);
                $stmt->execute();
                $proyectos = [];
                while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                    $proyectos[] = new Proyecto($row['id_proyecto'],$row['id_usuario'],$row['nombre'],$row['descripcion'],
                    $row['fecha_inicio'],$row['estado']);
                }
                return $proyectos;
            } catch (PDOException $e) {
                return "Error al listar proyectos: " . $e->getMessage();
            }
        }
        public function obtenerProyectoPorId($id_proyecto) {
            try {
                $query = "SELECT * FROM proyectos WHERE id_proyecto = :id_proyecto";
                $stmt = $this->db->prepare($query);
                $stmt->bindParam(':id_proyecto', $id_proyecto, PDO::PARAM_INT);
                $stmt->execute();
                $row = $stmt->fetch(PDO::FETCH_ASSOC);
                if ($row) {
                    return new Proyecto($row['id_proyecto'],$row['id_usuario'],$row['nombre'],$row['descripcion'],$row['fecha_inicio'],
                    $row['estado']);
                }
                return null;
            } catch (PDOException $e) {
                return "Error al obtener el proyecto: " . $e->getMessage();
            }
        }
        public function crearProyecto(Proyecto $proyecto) {
            try {
                $query = "INSERT INTO proyectos (id_usuario, nombre, descripcion, fecha_inicio, estado)
                VALUES (:id_usuario, :nombre, :descripcion, :fecha_inicio, :estado)";
                $stmt = $this->db->prepare($query);
                $id_usuario = $proyecto->getIdUsuario();
                $nombre = $proyecto->getNombre();
                $descripcion = $proyecto->getDescripcion();
                $fecha_inicio = $proyecto->getFechaInicio();
                $estado = $proyecto->getEstado();
                $stmt->bindParam(':id_usuario', $id_usuario, PDO::PARAM_INT);
                $stmt->bindParam(':nombre', $nombre, PDO::PARAM_STR);
                $stmt->bindParam(':descripcion', $descripcion, PDO::PARAM_STR);
                $stmt->bindParam(':fecha_inicio', $fecha_inicio);
                $stmt->bindParam(':estado', $estado, PDO::PARAM_STR);
                return $stmt->execute();
            } catch (PDOException $e) {
                return "Error al crear el proyecto: " . $e->getMessage();
            }
        }
        public function actualizarProyecto(Proyecto $proyecto) {
            try {
                $query = "UPDATE proyectos SET id_usuario = :id_usuario, nombre = :nombre, descripcion = :descripcion, fecha_inicio =
                :fecha_inicio, estado = :estado WHERE id_proyecto = :id_proyecto";
                $stmt = $this->db->prepare($query);
                $id_proyecto = $proyecto->getIdProyecto();
                $id_usuario = $proyecto->getIdUsuario();
                $nombre = $proyecto->getNombre();
                $descripcion = $proyecto->getDescripcion();
                $fecha_inicio = $proyecto->getFechaInicio();
                $estado = $proyecto->getEstado();
                $stmt->bindParam(':id_proyecto', $id_proyecto, PDO::PARAM_INT);
                $stmt->bindParam(':id_usuario', $id_usuario, PDO::PARAM_INT);
                $stmt->bindParam(':nombre', $nombre, PDO::PARAM_STR);
                $stmt->bindParam(':descripcion', $descripcion, PDO::PARAM_STR);
                $stmt->bindParam(':fecha_inicio', $fecha_inicio);
                $stmt->bindParam(':estado', $estado, PDO::PARAM_STR);
                return $stmt->execute();
            } catch (PDOExceptionos $e) {
                return "Error al actualizar el proyecto: " . $e->getMessage();
            }
        }
        public function eliminarProyecto($id_proyecto) {
            try {
                $query = "DELETE FROM proyectos WHERE id_proyecto = :id_proyecto";
                $stmt = $this->db->prepare($query);
                $stmt->bindParam(':id_proyecto', $id_proyecto, PDO::PARAM_INT);
                return $stmt->execute();
            } catch (PDOException $e) {
                return "Error al eliminar el proyecto: " . $e->getMessage();
            }
        }
    }
?>