---COMPLEJA 1 (DOCENTE - Mi carga académica con múltiples relaciones)

SELECT al.academic_load_id, al.grade_id, al.subject_id, al.teacher_id
FROM academic_load al
WHERE al.teacher_id = $1;

---Esta consulta obtiene todas las asignaciones de un docente.





--- COMPLEJA 2 (ESTUDIANTE - Boletín académico completo)
SELECT enrollment_id, grade_id, period_id, enrollment_date
FROM enrollments
WHERE student_id = $1 AND status IN ('active', 'completed')
ORDER BY enrollment_id DESC
LIMIT 1;



---Esta consulta busca la matrícula activa del estudiante.



---LOGIN DE USUARIO (AUTH)
SELECT user_id, username, password_hash, role_id, first_name, last_name, status
FROM users
WHERE username = $1;

--- Busca el usuario para autenticarlo en el login.

--- LISTAR USUARIOS (ADMIN)
SELECT user_id, username, role_id, document_type, document_number,
       first_name, middle_name, last_name, second_last_name,
       email, phone, last_login, status
FROM users
ORDER BY user_id;

---Muestra todos los usuarios del sistema.

---. CREAR USUARIO
INSERT INTO users (role_id, campus_id, username, password_hash,
                   document_type, document_number, first_name, middle_name,
                   last_name, second_last_name, email, phone, status)
VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, 'active')
RETURNING user_id;

--- Registra un usuario nuevo.

--- LISTAR MATERIAS
SELECT subject_id, name, description, weekly_hours, status
FROM subjects
ORDER BY subject_id;

---Muestra todas las materias del sistema.

---CREAR MATRÍCULA
INSERT INTO enrollments (student_id, grade_id, period_id, enrollment_date, status)
VALUES ($1, $2, $3, CURRENT_DATE, $4)
RETURNING enrollment_id;

---- Matricula un estudiante en un grado.

---- LISTAR HORARIOS DE UNA CARGA
SELECT schedule_id, academic_load_id, classroom_id,
       day_of_week, start_time, end_time
FROM schedules
WHERE academic_load_id = $1;

--- Devuelve el horario de una materia/grupo.

--- REGISTRAR ASISTENCIA
INSERT INTO attendance (enrollment_id, schedule_id, attendance_date,
                        attendance_status, comments)
VALUES ($1, $2, CURRENT_DATE, $3, $4);

----Guarda si un estudiante asistió o faltó.

---- OBSERVADOR (DOCENTE → ESTUDIANTE)
INSERT INTO observador (id, docente_id, estudiante_id, tipo, descripcion, periodo, fecha)
VALUES ($1, $2, $3, $4, $5, $6, NOW())
RETURNING id;

---Registra una anotación:
