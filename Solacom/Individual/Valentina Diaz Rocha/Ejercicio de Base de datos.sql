-- Crear Base de Datos 
CREATE DATABASE votaciones2503816;

-- Uso de la base de datos 
USE votaciones2503816;

-- Creación de tablas
CREATE TABLE Genero(
    idGenero INT(15) AUTO_INCREMENT PRIMARY KEY,
    nomGenero VARCHAR(15),
    estadoG BOOLEAN
);

CREATE TABLE Jornada(
    idJornada INT(11) PRIMARY KEY,
    nomJornada VARCHAR(15),
    estadoJ BOOLEAN
);

CREATE TABLE TipoDocumento(
    idTipoDoc INT(11) AUTO_INCREMENT PRIMARY KEY,
    nomTipoDoc VARCHAR(15),
    estadoTD BOOLEAN
);

CREATE TABLE Miembro(
    idMiembro INT(11) AUTO_INCREMENT PRIMARY KEY,
    nomTipoMiembro VARCHAR(15),
    estadoTM BOOLEAN
);

CREATE TABLE Curso(
    idCurso INT(11) AUTO_INCREMENT PRIMARY KEY,
    nomCurso VARCHAR(15),
    estadoCu BOOLEAN
);

CREATE TABLE Consejo(
    idConsejo INT(11) AUTO_INCREMENT PRIMARY KEY,
    nomConsejo VARCHAR(15),
    estadoCO BOOLEAN
);

CREATE TABLE Cargo(
    idCargo INT(11) AUTO_INCREMENT PRIMARY KEY,
    nomCargo VARCHAR(15),
    idConsejoFK INT(11),
    estadoC BOOLEAN
);

CREATE TABLE Eleccion(
    idEleccion INT(11) AUTO_INCREMENT PRIMARY KEY,
    fechaEleccion DATE,
    anioEleccion YEAR(11),
    estadoEL BOOLEAN
);

CREATE TABLE Usuario(
    idUsuario INT(11) AUTO_INCREMENT PRIMARY KEY,
    noDocUsuario INT(20),
    IdTipoDocFK INT(11),
    nombreUsuario VARCHAR(30),
    apellidoUsuario VARCHAR(30),
    IdGeneroFK INT(11),
    fechaNacUsuario DATE,
    emailUsuario VARCHAR(30),
    passwordUsuario VARCHAR(15),
    fotoUsuario BLOB,
    idJornadaFK INT(11),
    idTipoMiembroFK INT(6),
    idCursoFK INT(11),
    estadoU BOOLEAN
);

CREATE TABLE Votacion(
    idVotacion INT(11) AUTO_INCREMENT PRIMARY KEY,
    horaVotacion TIME,
    idUsuarioVotanteFK INT(11),
    estadoV BOOLEAN
);

CREATE TABLE Postulacion_Candidato(
    idPostCandidato INT(11) AUTO_INCREMENT PRIMARY KEY,
    idUsuarioFK INT(11),
    idEleccionFK INT(11),
    idCargoFK INT(11),
    propuestas VARCHAR(245),
    TotalVotos INT(11),
    estadoCan BOOLEAN
);

-- Inserción de datos
-- Inserciones para la tabla Genero
INSERT INTO Genero (idGenero, nomGenero, estadoG) VALUES 
(1, 'Femenino', TRUE), 
(2, 'Masculino', TRUE);

-- Inserciones para la tabla Jornada
INSERT INTO Jornada (idJornada, nomJornada, estadoJ) VALUES 
(1, 'Mañana', TRUE), 
(2, 'Tarde', TRUE), 
(3, 'Noche', TRUE);

-- Inserciones para la tabla TipoDocumento
INSERT INTO TipoDocumento (idTipoDoc, nomTipoDoc, estadoTD) VALUES 
(1, 'Tarjeta de Identidad', TRUE), 
(2, 'Cédula de Ciudadanía', TRUE), 
(3, 'Cédula de Extranjería', TRUE), 
(4, 'Pasaporte', TRUE), 
(5, 'NUIP', FALSE);

-- Inserciones para la tabla Miembro
INSERT INTO Miembro (idMiembro, nomTipoMiembro, estadoTM) VALUES 
(1, 'Estudiante', TRUE), 
(2, 'Profesor', TRUE), 
(3, 'Acudiente', TRUE);

-- Inserciones para la tabla Curso
INSERT INTO Curso (idCurso, nomCurso, estadoCu) VALUES 
(1, '901', TRUE), 
(2, '902', TRUE), 
(3, '1001', TRUE), 
(4, '1002', TRUE), 
(5, '1003', FALSE), 
(6, '1101', TRUE), 
(7, '1102', TRUE), 
(8, '1103', FALSE);

-- Inserciones para la tabla Consejo
INSERT INTO Consejo (idConsejo, nomConsejo, estadoCO) VALUES 
(1, 'Concejo Académico', TRUE), 
(2, 'Concejo Directivo', TRUE), 
(3, 'Concejo Convivencia', TRUE);

-- Inserciones para la tabla Cargo
INSERT INTO Cargo (idCargo, nomCargo, idConsejoFK, estadoC) VALUES 
(1, 'Personero', 1, TRUE), 
(2, 'Contralor', 1, TRUE), 
(3, 'Cabildante', 1, TRUE);

-- Inserciones para la tabla Eleccion
INSERT INTO Eleccion (idEleccion, fechaEleccion, anioEleccion, estadoEL) VALUES 
(1, '2020-04-20', 2020, TRUE), 
(2, '2019-04-15', 2019, TRUE), 
(3, '2019-04-12', 2019, FALSE), 
(4, '2018-04-14', 2018, TRUE), 
(5, '2017-04-12', 2017, TRUE);

-- Inserciones para la tabla Votacion
INSERT INTO Votacion (idVotacion, horaVotacion, idUsuarioVotanteFK, estadoV) VALUES 
(1, '12:08:15', 1, TRUE), 
(2, '12:12:35', 2, TRUE), 
(3, '12:14:18', 3, TRUE), 
(4, '12:15:58', 4, TRUE), 
(5, '12:18:02', 5, TRUE), 
(6, '12:24:22', 6, TRUE), 
(7, '12:28:02', 7, TRUE), 
(8, '12:30:14', 8, TRUE), 
(9, '12:40:20', 9, TRUE), 
(10, '12:45:20', 10, TRUE);

-- Inserciones para la tabla Postulacion_Candidato
INSERT INTO Postulacion_Candidato (idPostCandidato, idUsuarioFK, idEleccionFK, idCargoFK, propuestas, TotalVotos, estadoCan) VALUES 
(1, 1, 1, 1, 'Mejorar entrega refrigerios, Alargar descansos', 0, TRUE), 
(2, 1, 1, 1, 'Mejorar entrega refrigerios, Alargar descansos', 0, TRUE), 
(3, 1, 1, 1, 'Mejorar sala de informática, Construir piscina', 0, TRUE);

-- Consultas multitabla
-- Consulta 1: Mostrar cada usuario con su jornada, tipo de miembro y curso
SELECT 
    usuario.nombreUsuario, 
    jornada.nomJornada AS jornada, 
    miembro.nomTipoMiembro AS tipo_miembro, 
    curso.nomCurso AS curso
FROM 
    Usuario usuario
JOIN 
    Jornada jornada ON usuario.idJornadaFK = jornada.idJornada
JOIN 
    Miembro miembro ON usuario.idTipoMiembroFK = miembro.idMiembro
JOIN 
    Curso curso ON usuario.idCursoFK = curso.idCurso;

-- Alterar tabla Usuario para agregar el campo profesión
ALTER TABLE Usuario
ADD COLUMN profesion VARCHAR(100);

-- Consulta 2: Mostrar la cantidad de votos obtenidos por cada candidato
SELECT 
    usuario.nombreUsuario, 
    COUNT(votacion.idVotacion) AS total_votos
FROM 
    Votacion votacion
JOIN 
    Usuario usuario ON votacion.idUsuarioVotanteFK = usuario.idUsuario
GROUP BY 
    usuario.nombreUsuario;

-- Procedimientos almacenados
-- Procedimiento 1: Insertar nuevos estudiantes
DELIMITER //
CREATE PROCEDURE InsertarEstudiante(
    IN nombre VARCHAR(30), 
    IN apellido VARCHAR(30), 
    IN profesion VARCHAR(100)
)
BEGIN
    INSERT INTO Usuario (nombreUsuario, apellidoUsuario, profesion) 
    VALUES (nombre, apellido, profesion);
END;
//
DELIMITER ;

-- Procedimiento 2: Obtener cantidad de votos por candidato
DELIMITER //
CREATE PROCEDURE ObtenerVotosPorCandidato()
BEGIN
    SELECT 
        usuario.nombreUsuario, 
        COUNT(votacion.idVotacion) AS total_votos
    FROM 
        Votacion votacion
    JOIN 
        Usuario usuario ON votacion.idUsuarioVotanteFK = usuario.idUsuario
    GROUP BY 
        usuario.nombreUsuario;
END;
//
DELIMITER ;

-- Procedimiento 3: Actualizar profesión del estudiante
DELIMITER //
CREATE PROCEDURE ActualizarProfesion(
    IN estudiante_id INT, 
    IN nueva_profesion VARCHAR(100)
)
BEGIN
    UPDATE Usuario SET profesion = nueva_profesion WHERE idUsuario = estudiante_id;
END;
//
DELIMITER ;

-- Vistas
-- Vista 1: Estudiantes con sus cursos
CREATE VIEW vista_estudiantes_cursos AS
SELECT 
    usuario.nombreUsuario, 
    curso.nomCurso AS curso
FROM 
    Usuario usuario
JOIN 
    Curso curso ON usuario.idCursoFK = curso.idCurso;

-- Vista 2: Candidatos y votos
CREATE VIEW vista_candidatos_votos AS
SELECT 
    usuario.nombreUsuario, 
    COUNT(votacion.idVotacion) AS total_votos
FROM 
    Votacion votacion
JOIN 
    Usuario usuario ON votacion.idUsuarioVotanteFK = usuario.idUsuario
GROUP BY 
    usuario.nombreUsuario;

-- Vista 3: Miembros por jornada
CREATE VIEW vista_miembros_jornada AS
SELECT 
    usuario.nombreUsuario, 
    jornada.nomJornada AS jornada
FROM 
    Usuario usuario
JOIN 
    Jornada jornada ON usuario.idJornadaFK = jornada.idJornada;

-- Subconsultas
-- Subconsulta 1: Candidatos con más de 50 votos
SELECT 
    nombreUsuario 
FROM 
    Usuario 
WHERE 
    idUsuario IN (
        SELECT 
            idUsuarioVotanteFK 
        FROM 
            Votacion 
        GROUP BY 
            idUsuarioVotanteFK 
        HAVING 
            COUNT(*) > 50
    );

-- Subconsulta 2: Cursos con más de 10 estudiantes
SELECT 
    nomCurso 
FROM 
    Curso 
WHERE 
    idCurso IN (
        SELECT 
            idCursoFK 
        FROM 
            Usuario 
        GROUP BY 
            idCursoFK 
        HAVING 
            COUNT(*) > 10
    );
