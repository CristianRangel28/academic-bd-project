-- =============================================================
-- 1. INSTITUCIONES
-- =============================================================
INSERT INTO institutions (name, tax_id, address, phone, email, slogan, primary_color, secondary_color, status)
VALUES ('Institución Educativa CoreFive', '900123456-1', 'Calle 10 # 4-50', '6075551234', 'contacto@corefive.edu.co', 'Excelencia en Sistemas', '#88E788', '#333333', 'active');

-- =============================================================
-- 2. ROLES
-- =============================================================
INSERT INTO roles (name) VALUES 
('administrativo'), ('docente'), ('estudiante'), ('acudiente'); 

-- =============================================================
-- 3. CAMPUSES 
-- =============================================================
INSERT INTO campuses (institution_id, name, address, phone, email, is_main, status)
VALUES (1, 'Sede Principal Pamplona', 'Avenida Principal # 12-20', '6075556789', 'sede.pamplona@corefive.edu.co', TRUE, 'active');

-- =============================================================
-- 4. GRADES / GRADOS
-- =============================================================
INSERT INTO grades (name, education_level) VALUES 
('Primero', 'Primaria'),
('Segundo', 'Primaria'),
('Tercero', 'Primaria'),
('Cuarto', 'Primaria'),
('Quinto', 'Primaria'),
('Sexto', 'Secundaria'),
('Séptimo', 'Secundaria'),
('Octavo', 'Secundaria'),
('Noveno', 'Secundaria'),
('Décimo', 'Media'),
('Once', 'Media'); 

-- =============================================================
-- 5. ACADEMIC PERIODS
-- =============================================================
INSERT INTO academic_periods (name, academic_year, start_date, end_date, status) VALUES
('Primer Periodo 2026', 2026, '2026-01-15', '2026-03-25', 'active'),
('Segundo Periodo 2026', 2026, '2026-04-01', '2026-06-10', 'active'),
('Tercer Periodo 2026', 2026, '2026-07-05', '2026-09-15', 'active'),
('Cuarto Periodo 2026', 2026, '2026-09-20', '2026-11-30', 'active'); 

-- =============================================================
-- 6. SUBJECTS / MATERIAS
-- =============================================================
INSERT INTO subjects (name) VALUES 
('Matemáticas'), ('Español'), ('Ciencias Naturales'), ('Historia'), 
('Inglés'), ('Educación Física'), ('Artes'), ('Tecnología'), 
('Ética'), ('Física'); 

-- =============================================================
-- 8. CLASSROOMS / AULAS
-- =============================================================
INSERT INTO classrooms (campus_id, name, capacity, location, status) VALUES
(1, 'Aula 101', 35, 'Piso 1 - Bloque A', 'active'),
(1, 'Aula 102', 35, 'Piso 1 - Bloque A', 'active'),
(1, 'Aula 103', 35, 'Piso 2 - Bloque A', 'active'),
(1, 'Aula 104', 35, 'Piso 2 - Bloque A', 'active'),
(1, 'Laboratorio Informática', 40, 'Piso 1 - Bloque B', 'active'),
(1, 'Laboratorio Física', 30, 'Piso 1 - Bloque B', 'active'),
(1, 'Aula Dibujo', 25, 'Piso 2 - Bloque B', 'active'),
(1, 'Aula Máxima', 150, 'Piso 1 - Central', 'active'),
(1, 'Cancha Polideportiva', 60, 'Zona Verde', 'active'),
(1, 'Aula 105', 50, 'Bloque C', 'active'); 

-- =============================================================
-- 9. USERS 
-- =============================================================
INSERT INTO users (role_id, campus_id, username, password_hash, document_type, document_number, first_name, last_name, status)
VALUES (1, 1, 'duvan.contreras', 'admin123', 'CC', '1094123456', 'Duvan', 'Contreras', 'active');

INSERT INTO users (role_id, campus_id, username, password_hash, document_type, document_number, first_name, last_name, status) VALUES
(2, 1, 'pedro.gomez', 'docente123', 'CC', '20001', 'Pedro', 'Gomez', 'active'),
(2, 1, 'maria.rodriguez', 'docente123', 'CC', '20002', 'Maria', 'Rodriguez', 'active'),
(2, 1, 'juan.martinez', 'docente123', 'CC', '20003', 'Juan', 'Martinez', 'active'),
(2, 1, 'ana.lopez', 'docente123', 'CC', '20004', 'Ana', 'Lopez', 'active'),
(2, 1, 'luis.garcia', 'docente123', 'CC', '20005', 'Luis', 'Garcia', 'active'),
(2, 1, 'carmen.perez', 'docente123', 'CC', '20006', 'Carmen', 'Perez', 'active'),
(2, 1, 'jorge.sanchez', 'docente123', 'CC', '20007', 'Jorge', 'Sanchez', 'active'),
(2, 1, 'elena.ramirez', 'docente123', 'CC', '20008', 'Elena', 'Ramirez', 'active'),
(2, 1, 'diego.torres', 'docente123', 'CC', '20009', 'Diego', 'Torres', 'active'),
(2, 1, 'paula.flores', 'docente123', 'CC', '20010', 'Paula', 'Flores', 'active');

INSERT INTO users (role_id, campus_id, username, password_hash, document_type, document_number, first_name, last_name, status) VALUES
(3, 1, 'carlos.castro', 'estudiante123', 'TI', '30001', 'Carlos', 'Castro', 'active'),
(3, 1, 'lucia.diaz', 'estudiante123', 'TI', '30002', 'Lucia', 'Diaz', 'active'),
(3, 1, 'andres.morales', 'estudiante123', 'TI', '30003', 'Andres', 'Morales', 'active'),
(3, 1, 'sofia.ortiz', 'estudiante123', 'TI', '30004', 'Sofia', 'Ortiz', 'active'),
(3, 1, 'javier.silva', 'estudiante123', 'TI', '30005', 'Javier', 'Silva', 'active'),
(3, 1, 'valentina.ramos', 'estudiante123', 'TI', '30006', 'Valentina', 'Ramos', 'active'),
(3, 1, 'marcos.ruiz', 'estudiante123', 'TI', '30007', 'Marcos', 'Ruiz', 'active'),
(3, 1, 'camila.alvarez', 'estudiante123', 'TI', '30008', 'Camila', 'Alvarez', 'active'),
(3, 1, 'mateo.guzman', 'estudiante123', 'TI', '30009', 'Mateo', 'Guzman', 'active'),
(3, 1, 'isabella.romero', 'estudiante123', 'TI', '30010', 'Isabella', 'Romero', 'active'),
(3, 1, 'alejandro.munoz', 'estudiante123', 'TI', '30011', 'Alejandro', 'Munoz', 'active'),
(3, 1, 'daniela.gomez', 'estudiante123', 'TI', '30012', 'Daniela', 'Gomez', 'active'),
(3, 1, 'nicolas.herrera', 'estudiante123', 'TI', '30013', 'Nicolas', 'Herrera', 'active'),
(3, 1, 'mariana.medina', 'estudiante123', 'TI', '30014', 'Mariana', 'Medina', 'active'),
(3, 1, 'sebastian.vargas', 'estudiante123', 'TI', '30015', 'Sebastian', 'Vargas', 'active'),
(3, 1, 'gabriela.castillo', 'estudiante123', 'TI', '30016', 'Gabriela', 'Castillo', 'active'),
(3, 1, 'felipe.castro', 'estudiante123', 'TI', '30017', 'Felipe', 'Castro', 'active'),
(3, 1, 'natalia.pena', 'estudiante123', 'TI', '30018', 'Natalia', 'Pena', 'active'),
(3, 1, 'santiago.flores', 'estudiante123', 'TI', '30019', 'Santiago', 'Flores', 'active'),
(3, 1, 'paulina.suarez', 'estudiante123', 'TI', '30020', 'Paulina', 'Suarez', 'active'),
(3, 1, 'manuel.salazar', 'estudiante123', 'TI', '30021', 'Manuel', 'Salazar', 'active'),
(3, 1, 'laura.rincon', 'estudiante123', 'TI', '30022', 'Laura', 'Rincon', 'active'),
(3, 1, 'ricardo.benitez', 'estudiante123', 'TI', '30023', 'Ricardo', 'Benitez', 'active'),
(3, 1, 'andrea.arias', 'estudiante123', 'TI', '30024', 'Andrea', 'Arias', 'active'),
(3, 1, 'kevin.cruz', 'estudiante123', 'TI', '30025', 'Kevin', 'Cruz', 'active'),
(3, 1, 'manuela.donado', 'estudiante123', 'TI', '30026', 'Manuela', 'Donado', 'active'),
(3, 1, 'brian.lara', 'estudiante123', 'TI', '30027', 'Brian', 'Lara', 'active'),
(3, 1, 'sara.mendoza', 'estudiante123', 'TI', '30028', 'Sara', 'Mendoza', 'active'),
(3, 1, 'esteban.rojas', 'estudiante123', 'TI', '30029', 'Esteban', 'Rojas', 'active'),
(3, 1, 'clara.soler', 'estudiante123', 'TI', '30030', 'Clara', 'Soler', 'active');

-- =============================================================
-- 10. TEACHERS / DOCENTES
-- =============================================================
INSERT INTO teachers (user_id, document_type, document_number, first_name, last_name, status)
SELECT user_id, document_type, document_number, first_name, last_name, 'active'
FROM users
WHERE role_id = 2
ORDER BY user_id ASC; 

-- =============================================================
-- 11. STUDENTS / ESTUDIANTES
-- =============================================================
INSERT INTO students (user_id, document_type, document_number, first_name, last_name, status)
SELECT user_id, document_type, document_number, first_name, last_name, 'active'
FROM users
WHERE role_id = 3
ORDER BY user_id ASC; 

-- =============================================================
-- 14. ACADEMIC LOAD / CARGA ACADÉMICA
-- =============================================================
INSERT INTO academic_load (teacher_id, grade_id, subject_id, period_id) VALUES
(1, 1, 1, 1), (2, 2, 2, 1), (3, 3, 3, 1), (4, 4, 4, 1), (5, 5, 5, 1),
(6, 6, 6, 1), (7, 7, 7, 1), (8, 8, 8, 1), (9, 9, 9, 1), (10, 10, 10, 1); 

-- =============================================================
-- 15. SCHEDULES / HORARIOS
-- =============================================================
INSERT INTO schedules (academic_load_id, classroom_id, day_of_week, start_time, end_time, status) VALUES
(1, 1, 'Monday', '06:00', '07:00', 'active'),
(2, 2, 'Tuesday', '07:00', '08:00', 'active'),
(3, 3, 'Wednesday', '08:00', '09:00', 'active'),
(4, 4, 'Thursday', '10:00', '11:00', 'active'),
(5, 5, 'Friday', '11:00', '12:00', 'active'),
(6, 6, 'Monday', '12:00', '13:00', 'active'),
(7, 7, 'Tuesday', '06:00', '07:00', 'active'),
(8, 8, 'Wednesday', '07:00', '08:00', 'active'),
(9, 9, 'Thursday', '08:00', '09:00', 'active'),
(10, 10, 'Friday', '10:00', '11:00', 'active'); 

-- =============================================================
-- 16. ENROLLMENTS / MATRÍCULAS
-- =============================================================
INSERT INTO enrollments (student_id, grade_id, period_id, status) VALUES
(1, 1, 1, 'active'), (2, 1, 1, 'active'), (3, 1, 1, 'active'),
(4, 2, 1, 'active'), (5, 2, 1, 'active'), (6, 3, 1, 'active'),
(7, 3, 1, 'active'), (8, 4, 1, 'active'), (9, 4, 1, 'active'),
(10, 5, 1, 'active'),
(11, 6, 1, 'active'), (12, 6, 1, 'active'), (13, 6, 1, 'active'),
(14, 7, 1, 'active'), (15, 7, 1, 'active'), (16, 7, 1, 'active'),
(17, 8, 1, 'active'), (18, 8, 1, 'active'), (19, 8, 1, 'active'),
(20, 9, 1, 'active'), (21, 9, 1, 'active'), (22, 9, 1, 'active'),
(23, 10, 1, 'active'), (24, 10, 1, 'active'), (25, 10, 1, 'active'),
(26, 11, 1, 'active'), (27, 11, 1, 'active'), (28, 11, 1, 'active'), 
(29, 11, 1, 'active'), (30, 11, 1, 'active'); 

-- =============================================================
-- 17. ACTIVITIES / EVALUACIONES
-- =============================================================
INSERT INTO activities (academic_load_id, name, description, percentage, activity_date) VALUES
(1, 'Taller 1', 'Operaciones básicas matemáticas', 20.00, '2026-02-10'),
(2, 'Ensayo Literario', 'Análisis de obra asignada', 25.00, '2026-02-15'),
(3, 'Quiz Células', 'Evaluación rápida de biología', 15.00, '2026-02-18'),
(4, 'Exposición Histórica', 'Cartografía de la independencia', 30.00, '2026-02-22'),
(5, 'Listening Test', 'Examen de escucha básico', 20.00, '2026-02-25'),
(6, 'Test de Cooper', 'Prueba de resistencia física', 10.00, '2026-02-28'),
(7, 'Pintura Óleo', 'Composición libre artística', 20.00, '2026-03-02'),
(8, 'Proyecto Python', 'Algoritmos condicionales simples', 40.00, '2026-03-05'),
(9, 'Mesa Redonda', 'Debate sobre dilemas éticos', 15.00, '2026-03-08'),
(10, 'Problemas Dinámica', 'Cálculo de fuerzas aplicadas', 25.00, '2026-03-12'); 

-- =============================================================
-- 18. ATTENDANCE / ASISTENCIAS
-- =============================================================
INSERT INTO attendance (enrollment_id, schedule_id, attendance_date, attendance_status, comments) VALUES
(1, 1, '2026-02-10', 'present', 'Llegó puntual'),
(2, 1, '2026-02-10', 'late', 'Retraso de 10 minutos'),
(3, 1, '2026-02-10', 'absent', 'Inasistencia no justificada'),
(4, 2, '2026-02-15', 'present', NULL),
(5, 2, '2026-02-15', 'excused', 'Cita médica certificada'),
(6, 3, '2026-02-18', 'present', NULL),
(7, 3, '2026-02-18', 'present', NULL),
(8, 4, '2026-02-22', 'present', NULL),
(9, 4, '2026-02-22', 'late', 'Problemas con transporte'),
(10, 5, '2026-02-25', 'present', NULL),
(11, 6, '2026-02-10', 'present', NULL),
(12, 6, '2026-02-10', 'present', NULL),
(13, 6, '2026-02-10', 'late', 'Retraso por clima'),
(14, 7, '2026-02-15', 'present', NULL),
(15, 7, '2026-02-15', 'absent', 'Sin justificar'),
(16, 7, '2026-02-15', 'present', NULL),
(17, 8, '2026-02-18', 'present', NULL),
(18, 8, '2026-02-18', 'excused', 'Cita médica'),
(19, 8, '2026-02-18', 'present', NULL),
(20, 9, '2026-02-22', 'present', NULL);

-- =============================================================
-- 19. GRADE RECORDS / NOTAS OBTENIDAS
-- =============================================================
INSERT INTO grade_records (enrollment_id, activity_id, score, comments, record_date) VALUES
(1, 1, 4.50, 'Excelente desempeño', '2026-02-12'),
(2, 1, 3.80, 'Buen trabajo', '2026-02-12'),
(3, 1, 2.50, 'Debe reforzar conceptos', '2026-02-12'),
(4, 2, 4.80, 'Gran redacción analítica', '2026-02-16'),
(5, 2, 3.00, 'Apenas cumple requerimientos', '2026-02-16'),
(6, 3, 5.00, 'Nota perfecta en el quiz', '2026-02-19'),
(7, 3, 1.20, 'No estudió el temario', '2026-02-19'),
(8, 4, 4.00, 'Buena exposición de ideas', '2026-02-23'),
(9, 4, 3.50, 'Faltó apoyo gráfico', '2026-02-23'),
(10, 5, 4.20, 'Gran nivel auditivo', '2026-02-26'),
(11, 6, 4.20, 'Buen rendimiento físico', '2026-03-01'),
(12, 6, 3.50, 'Cumple con el tiempo justo', '2026-03-01'),
(13, 6, 4.80, 'Excelente estado atlético', '2026-03-01'),
(14, 7, 4.00, 'Buena combinación cromática', '2026-03-04'),
(15, 7, 2.80, 'Entregó el trabajo incompleto', '2026-03-04'),
(17, 8, 4.50, 'Código limpio y estructurado', '2026-03-07'),
(18, 8, 3.90, 'Faltaron comentarios en las funciones', '2026-03-07'),
(20, 9, 4.70, 'Argumentación brillante', '2026-03-10'),
(23, 10, 3.20, 'Confundió las unidades de medida', '2026-03-14'),
(24, 10, 5.00, 'Resolución impecable de diagramas', '2026-03-14');

-- =============================================================
-- 20. OBSERVADOR DEL ALUMNO
-- =============================================================
INSERT INTO observador (id, estudiante_id, docente_id, tipo, descripcion, fecha, periodo, compromiso, estado_firma) VALUES
(gen_random_uuid(), 1, 1, 'Académico', 'Muestra excelente actitud e interés en el área de matemáticas.', CURRENT_DATE, '1', 'Mantener promedio alto', 'Firmado'),
(gen_random_uuid(), 2, 2, 'Convivencial', 'Interrumpe recurrentemente las explicaciones en clase hablando con compañeros.', CURRENT_DATE, '1', 'Mejorar la escucha activa', 'Pendiente'),
(gen_random_uuid(), 3, 3, 'Académico', 'No entregó las guías de laboratorio a tiempo.', CURRENT_DATE, '1', 'Ponerse al día en nivelación', 'Pendiente'),
(gen_random_uuid(), 4, 4, 'Felicitación', 'Destacada participación en el foro municipal de historia.', CURRENT_DATE, '1', 'Seguir liderando proyectos', 'Firmado'),
(gen_random_uuid(), 5, 5, 'Asistencia', 'Registra tres llegadas tarde injustificadas consecutivas.', CURRENT_DATE, '1', 'Salir más temprano de casa', 'Firmado'),
(gen_random_uuid(), 6, 6, 'Deportivo', 'Excelente desempeño físico en las olimpiadas internas de atletismo.', CURRENT_DATE, '1', 'Continuar entrenando', 'Firmado'),
(gen_random_uuid(), 7, 7, 'Académico', 'Presenta dificultades notables en técnicas artísticas complejas.', CURRENT_DATE, '1', 'Asistir a tutoría los jueves', 'Pendiente'),
(gen_random_uuid(), 8, 8, 'Felicitación', 'Desarrolló una lógica de programación sobresaliente en los entregables.', CURRENT_DATE, '1', 'Compartir su método con el grupo', 'Firmado'),
(gen_random_uuid(), 9, 9, 'Convivencial', 'Hizo uso indebido de dispositivos electrónicos durante evaluaciones escritas.', CURRENT_DATE, '1', 'Entregar el celular al iniciar clase', 'Pendiente'),
(gen_random_uuid(), 10, 10, 'Académico', 'Superó satisfactoriamente los vacíos conceptuales que traía del año anterior.', CURRENT_DATE, '1', 'Seguir con el ritmo de estudio', 'Firmado');
