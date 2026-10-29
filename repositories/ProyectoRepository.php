<?php

class ProyectoRepository
{
    public static function obtenerTodos(): array
    {
        global $db;

        $query = 'SELECT id_proyecto, id_usuario, nombre, descripcion, fecha_inicio, estado
                  FROM proyecto
                  ORDER BY fecha_inicio DESC, id_proyecto DESC';
        $result = $db->query($query);

        if ($result === false) {
            throw new RuntimeException('No se pudieron obtener los proyectos: ' . $db->error);
        }

        $proyectos = [];

        while ($row = $result->fetch_assoc()) {
            $proyectos[] = new Proyecto(
                $row['id_proyecto'],
                $row['id_usuario'],
                $row['nombre'],
                $row['descripcion'],
                $row['fecha_inicio'],
                $row['estado']
            );
        }

        return $proyectos;
    }

    public static function obtenerPorUsuario(int $idUsuario): array
    {
        global $db;

        $idUsuario = (int) $idUsuario;
        $query = "SELECT id_proyecto, id_usuario, nombre, descripcion, fecha_inicio, estado
                  FROM proyecto
                  WHERE id_usuario = $idUsuario
                  ORDER BY fecha_inicio DESC, id_proyecto DESC";
        $result = $db->query($query);

        if ($result === false) {
            throw new RuntimeException('No se pudieron obtener los proyectos del usuario: ' . $db->error);
        }

        $proyectos = [];

        while ($row = $result->fetch_assoc()) {
            $proyectos[] = new Proyecto(
                $row['id_proyecto'],
                $row['id_usuario'],
                $row['nombre'],
                $row['descripcion'],
                $row['fecha_inicio'],
                $row['estado']
            );
        }

        return $proyectos;
    }

    public static function anadirProyecto(
        int $idUsuario,
        string $nombre,
        ?string $descripcion,
        string $fechaInicio,
        string $estado = 'pendiente'
    ): bool
    {
        global $db;

        $idUsuario = (int) $idUsuario;
        $nombre = $db->real_escape_string($nombre);
        $descripcion = $descripcion === null
            ? 'NULL'
            : "'" . $db->real_escape_string($descripcion) . "'";
        $fechaInicio = $db->real_escape_string($fechaInicio);
        $estado = $db->real_escape_string($estado);
        $query = "INSERT INTO proyecto (id_usuario, nombre, descripcion, fecha_inicio, estado)
                  VALUES ($idUsuario, '$nombre', $descripcion, '$fechaInicio', '$estado')";

        if (!$db->query($query)) {
            throw new RuntimeException('No se pudo añadir el proyecto: ' . $db->error);
        }

        return true;
    }

    public static function eliminarProyecto(int $idProyecto): bool
    {
        global $db;

        $idProyecto = (int) $idProyecto;
        $query = "DELETE FROM proyecto WHERE id_proyecto = $idProyecto";

        if (!$db->query($query)) {
            throw new RuntimeException('No se pudo eliminar el proyecto: ' . $db->error);
        }

        return $db->affected_rows > 0;
    }
}
