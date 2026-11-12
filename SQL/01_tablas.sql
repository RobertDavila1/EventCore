CREATE TABLE USUARIO (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    fecha_registro DATE NOT NULL
);


CREATE TABLE ORGANIZADOR (
    id_usuario INT PRIMARY KEY,

    FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario)
);


CREATE TABLE ASISTENTE (
    id_usuario INT PRIMARY KEY,

    FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario)
);


CREATE TABLE ESPACIO (
    id_espacio INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    capacidad INT NOT NULL
);


CREATE TABLE EVENTO (
    id_evento INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    hora_fin TIME NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    id_usuario INT NOT NULL,
    id_espacio INT NOT NULL,

    FOREIGN KEY (id_usuario)
        REFERENCES ORGANIZADOR(id_usuario),

    FOREIGN KEY (id_espacio)
        REFERENCES ESPACIO(id_espacio)
);


CREATE TABLE REVIEW (
    id_review INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    calificacion TINYINT NOT NULL,
    comentario TEXT,
    id_evento INT NOT NULL,
    id_usuario INT NOT NULL,

    FOREIGN KEY (id_evento)
        REFERENCES EVENTO(id_evento),

    FOREIGN KEY (id_usuario)
        REFERENCES ASISTENTE(id_usuario),

    UNIQUE (id_evento, id_usuario)
);


CREATE TABLE COMPRA (
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    metodo_pago VARCHAR(30) NOT NULL,
    total DECIMAL(12,2) NOT NULL,
    estado_pago VARCHAR(20) NOT NULL,
    id_usuario INT NOT NULL,

    FOREIGN KEY (id_usuario)
        REFERENCES ASISTENTE(id_usuario)
);


CREATE TABLE PAQUETE (
    id_paquete INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    precio DECIMAL(12,2) NOT NULL,
    cupo INT NOT NULL,
    id_evento INT NOT NULL,

    FOREIGN KEY (id_evento)
        REFERENCES EVENTO(id_evento)
);


CREATE TABLE ENTRADA (
    id_entrada INT PRIMARY KEY AUTO_INCREMENT,
    precio_pagado DECIMAL(12,2) NOT NULL,
    codigo_qr VARCHAR(255) NOT NULL UNIQUE,
    estado VARCHAR(20) NOT NULL,
    fecha_hora_ingreso DATETIME,
    id_compra INT NOT NULL,
    id_paquete INT NOT NULL,
    id_asistente INT NOT NULL,

    FOREIGN KEY (id_compra)
        REFERENCES COMPRA(id_compra),

    FOREIGN KEY (id_paquete)
        REFERENCES PAQUETE(id_paquete),

    FOREIGN KEY (id_asistente)
        REFERENCES ASISTENTE(id_usuario)
);


CREATE TABLE SERVICIO (
    id_servicio INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255)
);


CREATE TABLE PAQUETE_SERVICIO (
    id_paquete INT NOT NULL,
    id_servicio INT NOT NULL,

    PRIMARY KEY (id_paquete, id_servicio),

    FOREIGN KEY (id_paquete)
        REFERENCES PAQUETE(id_paquete),

    FOREIGN KEY (id_servicio)
        REFERENCES SERVICIO(id_servicio)
);