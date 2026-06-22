from fastapi import APIRouter, Depends, HTTPException, status, Request
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from typing import List, Optional
from datetime import date, datetime
from app.db.database import get_db
from app.db.models import (
    AcademicLoad, Attendance, Activity, GradeRecord,
    Observador, Teacher, Student, Enrollment, User,
    Schedule, Subject, Course, AcademicPeriod, Classroom, Grade
)
from app.schemas.schemas import (
    AttendanceCreate, AttendanceOut,
    ActivityCreate, ActivityOut,
    GradeRecordCreate, GradeRecordOut,
    ObservadorCreate, ObservadorOut,
)
from app.core.security import require_rol
import uuid

router = APIRouter(prefix="/docentes", tags=["Docentes"])
only_docente = Depends(require_rol("docente", "admin"))

async def get_teacher_by_user(db: AsyncSession, user_id: int):
    result = await db.execute(select(Teacher).where(Teacher.user_id == user_id))
    teacher = result.scalar_one_or_none()
    if not teacher:
        raise HTTPException(status_code=404, detail="Docente no encontrado")
    return teacher

# ─────────────────────────────────────────
# CARGA ACADÉMICA DEL DOCENTE
# ─────────────────────────────────────────
@router.get("/mi-carga")
async def mi_carga_academica(
    db: AsyncSession = Depends(get_db),
    current_user: dict = Depends(require_rol("docente", "admin"))
):
    teacher = await get_teacher_by_user(db, current_user["user_id"])
    result = await db.execute(
        select(AcademicLoad).where(AcademicLoad.teacher_id == teacher.teacher_id)
    )
    loads = result.scalars().all()

    day_map = {"monday":1,"tuesday":2,"wednesday":3,"thursday":4,"friday":5}
    def time_to_bloque(t):
        h = t.hour + t.minute / 60
        if 7 <= h < 7.92: return 1
        if 7.92 <= h < 8.83: return 2
        if 8.83 <= h < 9.75: return 3
        if 10.25 <= h < 11.17: return 4
        if 11.17 <= h < 12.08: return 5
        return 6

    output = []
    for l in loads:
        subj = await db.execute(select(Subject).where(Subject.subject_id == l.subject_id))
        subject = subj.scalar_one_or_none()
        course = await db.execute(select(Course).where(Course.course_id == l.course_id))
        course = course.scalar_one_or_none()
        grade = None
        if course:
            grade_result = await db.execute(select(Grade).where(Grade.grade_id == course.grade_id))
            grade = grade_result.scalar_one_or_none()
        sched = await db.execute(
            select(Schedule).where(Schedule.academic_load_id == l.academic_load_id)
        )
        schedules = sched.scalars().all()

        student_count = 0
        students_list = []
        if course:
            enroll_result = await db.execute(
                select(Enrollment).where(Enrollment.course_id == course.course_id, Enrollment.status == "active")
            )
            enrollments = enroll_result.scalars().all()
            student_count = len(enrollments)
            for e in enrollments:
                s = await db.execute(select(Student).where(Student.student_id == e.student_id))
                student = s.scalar_one_or_none()
                if student:
                    students_list.append({
                        "id": student.student_id,
                        "nombre": f"{student.first_name} {student.last_name}",
                    })

        grado_str = f"{grade.name} {course.name}" if grade and course else course.name if course else "N/A"
        num_schedules = len(schedules)

        for s in schedules:
            classroom = await db.execute(select(Classroom).where(Classroom.classroom_id == s.classroom_id))
            classroom = classroom.scalar_one_or_none()
            dia = day_map.get(s.day_of_week.strip().lower(), 1)
            bloque = time_to_bloque(s.start_time)
            output.append({
                "id": l.academic_load_id,
                "materia_id": l.academic_load_id,
                "materia_nombre": subject.name if subject else "N/A",
                "grado": grado_str,
                "curso": course.name if course else "N/A",
                "bloque": bloque,
                "dia_semana": dia,
                "salon": classroom.name if classroom else "",
                "nh_semanales": str(num_schedules),
                "estudiantes": students_list,
                "total_estudiantes": student_count,
                "schedules": [
                    {
                        "day": s.day_of_week,
                        "start": str(s.start_time),
                        "end": str(s.end_time),
                        "schedule_id": s.schedule_id,
                    }
                ],
            })

        if not schedules:
            output.append({
                "id": l.academic_load_id,
                "materia_id": l.academic_load_id,
                "materia_nombre": subject.name if subject else "N/A",
                "grado": grado_str,
                "curso": course.name if course else "N/A",
                "bloque": 1,
                "dia_semana": 1,
                "salon": "",
                "nh_semanales": "0",
                "estudiantes": students_list,
                "total_estudiantes": student_count,
                "schedules": [],
            })
    return output

# ─────────────────────────────────────────
# ASISTENCIA
# ─────────────────────────────────────────
@router.get("/asistencia/{carga_id}")
async def ver_asistencia_clase(
    carga_id: int,
    db: AsyncSession = Depends(get_db),
    _=only_docente
):
    enroll_result = await db.execute(
        select(Enrollment)
        .join(AcademicLoad, AcademicLoad.course_id == Enrollment.course_id)
        .where(AcademicLoad.academic_load_id == carga_id, Enrollment.status == "active")
    )
    enrollments = enroll_result.scalars().all()

    output = []
    for e in enrollments:
        student = await db.execute(select(Student).where(Student.student_id == e.student_id))
        student = student.scalar_one_or_none()
        user = await db.execute(select(User).where(User.user_id == student.user_id))
        user = user.scalar_one_or_none()

        output.append({
            "estudiante_id": e.student_id,
            "estudiante_nombre": f"{student.first_name} {student.last_name}" if student else "N/A",
            "estudiante_usuario": user.username if user else "",
            "estado": "",
            "observacion": "",
        })
    return output

@router.post("/asistencia", status_code=status.HTTP_201_CREATED)
async def registrar_asistencia(
    registros: list,
    db: AsyncSession = Depends(get_db),
    _=only_docente
):
    nuevos = []
    for r in registros:
        carga_id = r.get("carga_id") or r.get("academic_load_id")
        estudiante_id = r.get("estudiante_id") or r.get("student_id")
        estado = r.get("estado") or r.get("attendance_status")
        observacion = r.get("observacion") or r.get("comments")

        enroll_result = await db.execute(
            select(Enrollment)
            .join(AcademicLoad, AcademicLoad.course_id == Enrollment.course_id)
            .where(AcademicLoad.academic_load_id == carga_id, Enrollment.student_id == estudiante_id)
        )
        enrollment = enroll_result.scalar_one_or_none()

        schedule_result = await db.execute(
            select(Schedule).where(Schedule.academic_load_id == carga_id).limit(1)
        )
        schedule = schedule_result.scalar_one_or_none()

        if not enrollment or not schedule:
            continue

        nuevo = Attendance(
            enrollment_id=enrollment.enrollment_id,
            schedule_id=schedule.schedule_id,
            attendance_date=date.today(),
            attendance_status=estado,
            comments=observacion,
        )
        db.add(nuevo)
        nuevos.append(nuevo)

    await db.flush()
    return {"mensaje": f"{len(nuevos)} registros guardados"}

# ─────────────────────────────────────────
# ACTIVIDADES
# ─────────────────────────────────────────
@router.get("/actividades/{materia_id}")
async def listar_actividades(
    materia_id: int,
    db: AsyncSession = Depends(get_db),
    _=only_docente
):
    query = select(Activity).where(Activity.academic_load_id == materia_id)
    result = await db.execute(query)
    activities = result.scalars().all()

    output = []
    for a in activities:
        gr = await db.execute(select(GradeRecord).where(GradeRecord.activity_id == a.activity_id).limit(1))
        tiene_notas = gr.scalar_one_or_none() is not None

        output.append({
            "id": a.activity_id,
            "nombre": a.name,
            "descripcion": a.description or "",
            "fecha_entrega": str(a.activity_date) if a.activity_date else "",
            "porcentaje": float(a.percentage),
            "tiene_notas": tiene_notas,
        })
    return output

@router.post("/actividades", status_code=status.HTTP_201_CREATED)
async def crear_actividad(
    data: dict,
    db: AsyncSession = Depends(get_db),
    _=only_docente
):
    materia_id = data.get("materia_id") or data.get("academic_load_id")
    activity = Activity(
        academic_load_id=materia_id,
        name=data.get("nombre") or data.get("name"),
        description=data.get("descripcion") or data.get("description"),
        percentage=data.get("porcentaje") or data.get("percentage"),
        activity_date=(
            date.fromisoformat(data.get("fecha_entrega") or data.get("activity_date"))
            if data.get("fecha_entrega") or data.get("activity_date") else None
        ),
    )
    db.add(activity)
    await db.flush()
    await db.refresh(activity)
    return {
        "id": activity.activity_id,
        "nombre": activity.name,
        "descripcion": activity.description or "",
        "fecha_entrega": str(activity.activity_date) if activity.activity_date else "",
        "porcentaje": float(activity.percentage),
        "tiene_notas": False,
    }

@router.delete("/actividades/{activity_id}", status_code=status.HTTP_204_NO_CONTENT)
async def eliminar_actividad(
    activity_id: int,
    db: AsyncSession = Depends(get_db),
    _=only_docente
):
    result = await db.execute(select(Activity).where(Activity.activity_id == activity_id))
    activity = result.scalar_one_or_none()
    if not activity:
        raise HTTPException(status_code=404, detail="Actividad no encontrada")
    await db.delete(activity)

# ─────────────────────────────────────────
# NOTAS
# ─────────────────────────────────────────
@router.get("/notas/{activity_id}")
async def ver_notas_actividad(
    activity_id: int,
    db: AsyncSession = Depends(get_db),
    _=only_docente
):
    result = await db.execute(select(GradeRecord).where(GradeRecord.activity_id == activity_id))
    records = result.scalars().all()

    output = []
    for r in records:
        enroll = await db.execute(select(Enrollment).where(Enrollment.enrollment_id == r.enrollment_id))
        enrollment = enroll.scalar_one_or_none()
        student = None
        if enrollment:
            s_result = await db.execute(select(Student).where(Student.student_id == enrollment.student_id))
            student = s_result.scalar_one_or_none()

        output.append({
            "id": r.grade_record_id,
            "estudiante_id": enrollment.student_id if enrollment else None,
            "valor": float(r.score),
            "estudiante_nombre": f"{student.first_name} {student.last_name}" if student else "N/A",
            "definitiva": float(r.score),
        })
    return output

@router.post("/notas", status_code=status.HTTP_201_CREATED)
async def registrar_notas(
    notas: list,
    db: AsyncSession = Depends(get_db),
    _=only_docente
):
    nuevos = []
    for n in notas:
        estudiante_id = n.get("estudiante_id") or n.get("student_id")
        actividad_id = n.get("actividad_id") or n.get("activity_id")
        valor = n.get("valor") or n.get("score")

        enroll_result = await db.execute(
            select(Enrollment).where(Enrollment.student_id == estudiante_id)
        )
        enrollment = enroll_result.scalar_one_or_none()
        if not enrollment:
            continue

        record = GradeRecord(
            activity_id=actividad_id,
            enrollment_id=enrollment.enrollment_id,
            score=valor,
            record_date=date.today(),
        )
        db.add(record)
        nuevos.append(record)

    await db.flush()
    return {"mensaje": f"{len(nuevos)} notas guardadas"}

@router.put("/notas/{nota_id}")
async def editar_nota(
    nota_id: int,
    data: dict,
    db: AsyncSession = Depends(get_db),
    _=only_docente
):
    result = await db.execute(select(GradeRecord).where(GradeRecord.grade_record_id == nota_id))
    record = result.scalar_one_or_none()
    if not record:
        raise HTTPException(status_code=404, detail="Nota no encontrada")
    record.score = data.get("valor") or data.get("score") or record.score
    record.comments = data.get("observacion") or data.get("comments")
    await db.flush()
    await db.refresh(record)
    return {
        "id": record.grade_record_id,
        "valor": float(record.score),
    }

# ─────────────────────────────────────────
# OBSERVADOR
# ─────────────────────────────────────────
@router.post("/observador", status_code=status.HTTP_201_CREATED)
async def registrar_anotacion(
    data: dict,
    db: AsyncSession = Depends(get_db),
    current_user: dict = Depends(require_rol("docente", "admin"))
):
    teacher = await get_teacher_by_user(db, current_user["user_id"])
    observador = Observador(
        id=str(uuid.uuid4()),
        docente_id=teacher.teacher_id,
        estudiante_id=data.get("estudiante_id"),
        tipo=data.get("tipo"),
        descripcion=data.get("descripcion"),
        periodo=data.get("periodo", ""),
        fecha=datetime.utcnow(),
    )
    db.add(observador)
    await db.flush()
    await db.refresh(observador)
    return {
        "id": observador.id,
        "estudiante_id": observador.estudiante_id,
        "tipo": observador.tipo,
        "descripcion": observador.descripcion,
        "fecha": str(observador.fecha),
        "reportado_por": f"{teacher.first_name} {teacher.last_name}",
    }

@router.get("/observador/{estudiante_id}")
async def ver_observador_estudiante(
    estudiante_id: int,
    periodo: Optional[str] = None,
    db: AsyncSession = Depends(get_db),
    _=only_docente
):
    query = select(Observador).where(Observador.estudiante_id == estudiante_id)
    if periodo:
        query = query.where(Observador.periodo == periodo)
    result = await db.execute(query)
    records = result.scalars().all()

    output = []
    for obs in records:
        teacher = None
        if obs.docente_id:
            t_result = await db.execute(select(Teacher).where(Teacher.teacher_id == obs.docente_id))
            teacher = t_result.scalar_one_or_none()

        output.append({
            "id": obs.id,
            "estudiante_id": obs.estudiante_id,
            "tipo": obs.tipo,
            "descripcion": obs.descripcion,
            "fecha": str(obs.fecha),
            "periodo": obs.periodo,
            "reportado_por": f"{teacher.first_name} {teacher.last_name}" if teacher else "Docente",
        })
    return output
