/*1. ¿Qué eventos están programados y dónde se realizarán? */
SELECT
    e.nombre AS evento,
    e.fecha,
    e.hora,
    e.hora_fin,
    e.categoria,
    u.nombre AS organizador,
    es.nombre AS espacio,
    es.direccion
FROM EVENTO e
JOIN ORGANIZADOR o
    ON e.id_usuario = o.id_usuario
JOIN USUARIO u
    ON o.id_usuario = u.id_usuario
JOIN ESPACIO es
    ON e.id_espacio = es.id_espacio
WHERE e.estado = 'Programado'
ORDER BY e.fecha, e.hora;

/*2. ¿Cuántos eventos ha creado cada organizador?*/
SELECT
    u.nombre AS organizador,
    COUNT(e.id_evento) AS total_eventos
FROM ORGANIZADOR o
JOIN USUARIO u
    ON o.id_usuario = u.id_usuario
LEFT JOIN EVENTO e
    ON o.id_usuario = e.id_usuario
GROUP BY u.id_usuario, u.nombre
ORDER BY total_eventos DESC;

/*3. ¿Cuántos cupos disponibles tiene cada paquete?*/
SELECT
    e.nombre AS evento,
    p.nombre AS paquete,
    p.cupo AS cupo_total,
    COUNT(
        CASE
            WHEN c.estado_pago = 'Pagado'
                 AND en.estado <> 'Anulada'
            THEN en.id_entrada
        END
    ) AS entradas_vendidas,
    p.cupo - COUNT(
        CASE
            WHEN c.estado_pago = 'Pagado'
                 AND en.estado <> 'Anulada'
            THEN en.id_entrada
        END
    ) AS cupos_disponibles
FROM PAQUETE p
JOIN EVENTO e
    ON p.id_evento = e.id_evento
LEFT JOIN ENTRADA en
    ON p.id_paquete = en.id_paquete
LEFT JOIN COMPRA c
    ON en.id_compra = c.id_compra
GROUP BY e.id_evento, e.nombre,
         p.id_paquete, p.nombre, p.cupo;
/*4. ¿Cuánto dinero ha generado cada evento?*/         
SELECT
    e.nombre AS evento,
    COUNT(
        CASE
            WHEN c.estado_pago = 'Pagado'
                 AND en.estado <> 'Anulada'
            THEN en.id_entrada
        END
    ) AS entradas_pagadas,
    COALESCE(SUM(
        CASE
            WHEN c.estado_pago = 'Pagado'
                 AND en.estado <> 'Anulada'
            THEN en.precio_pagado
            ELSE 0
        END
    ), 0) AS ingresos_totales
FROM EVENTO e
LEFT JOIN PAQUETE p
    ON e.id_evento = p.id_evento
LEFT JOIN ENTRADA en
    ON p.id_paquete = en.id_paquete
LEFT JOIN COMPRA c
    ON en.id_compra = c.id_compra
GROUP BY e.id_evento, e.nombre
ORDER BY ingresos_totales DESC;

/*5. ¿Cuántos asistentes ingresaron a cada evento?*/    
SELECT
    e.nombre AS evento,
    COUNT(
        CASE WHEN en.estado = 'Usada'
        THEN en.id_entrada END
    ) AS asistentes_ingresados,
    COUNT(
        CASE WHEN en.estado = 'Disponible'
        THEN en.id_entrada END
    ) AS entradas_sin_usar
FROM EVENTO e
LEFT JOIN PAQUETE p
    ON e.id_evento = p.id_evento
LEFT JOIN ENTRADA en
    ON p.id_paquete = en.id_paquete
GROUP BY e.id_evento, e.nombre
ORDER BY asistentes_ingresados DESC;

/*6. ¿Cuáles son los eventos mejor calificados?*/  
SELECT
    e.nombre AS evento,
    COUNT(r.id_review) AS total_resenas,
    ROUND(AVG(r.calificacion), 2)
        AS calificacion_promedio
FROM EVENTO e
LEFT JOIN REVIEW r
    ON e.id_evento = r.id_evento
GROUP BY e.id_evento, e.nombre
ORDER BY calificacion_promedio DESC;

/*7. ¿Qué asistentes tienen entradas válidas para un evento determinado?*/  
SELECT
    u.nombre AS asistente,
    u.correo,
    e.nombre AS evento,
    p.nombre AS paquete,
    en.codigo_qr,
    en.estado AS estado_entrada
FROM ENTRADA en
JOIN ASISTENTE a
    ON en.id_asistente = a.id_usuario
JOIN USUARIO u
    ON a.id_usuario = u.id_usuario
JOIN PAQUETE p
    ON en.id_paquete = p.id_paquete
JOIN EVENTO e
    ON p.id_evento = e.id_evento
JOIN COMPRA c
    ON en.id_compra = c.id_compra
WHERE e.id_evento = 4
  AND c.estado_pago = 'Pagado'
  AND en.estado <> 'Anulada'
ORDER BY u.nombre;

/*8. ¿Cuál es el historial de compras de un asistente?*/  

SELECT
    u.nombre AS asistente,
    c.id_compra,
    c.fecha AS fecha_compra,
    e.nombre AS evento,
    p.nombre AS paquete,
    en.precio_pagado,
    c.metodo_pago,
    c.estado_pago
FROM COMPRA c
JOIN ASISTENTE a
    ON c.id_usuario = a.id_usuario
JOIN USUARIO u
    ON a.id_usuario = u.id_usuario
JOIN ENTRADA en
    ON c.id_compra = en.id_compra
JOIN PAQUETE p
    ON en.id_paquete = p.id_paquete
JOIN EVENTO e
    ON p.id_evento = e.id_evento
WHERE u.id_usuario = 6
ORDER BY c.fecha DESC;

/*9. ¿Qué servicios incluye cada paquete?*/  
SELECT
    e.nombre AS evento,
    p.nombre AS paquete,
    p.precio,
    GROUP_CONCAT(
        s.nombre
        ORDER BY s.nombre
        SEPARATOR ', '
    ) AS servicios_incluidos
FROM PAQUETE p
JOIN EVENTO e
    ON p.id_evento = e.id_evento
LEFT JOIN PAQUETE_SERVICIO ps
    ON p.id_paquete = ps.id_paquete
LEFT JOIN SERVICIO s
    ON ps.id_servicio = s.id_servicio
GROUP BY e.id_evento, e.nombre,
         p.id_paquete, p.nombre, p.precio;
         
/*10. ¿Cuáles son los asistentes que más dinero han gastado?*/  
SELECT
    u.nombre AS asistente,
    COUNT(c.id_compra) AS total_compras,
    COALESCE(SUM(c.total), 0) AS total_gastado
FROM ASISTENTE a
JOIN USUARIO u
    ON a.id_usuario = u.id_usuario
LEFT JOIN COMPRA c
    ON a.id_usuario = c.id_usuario
    AND c.estado_pago = 'Pagado'
GROUP BY u.id_usuario, u.nombre
ORDER BY total_gastado DESC;
