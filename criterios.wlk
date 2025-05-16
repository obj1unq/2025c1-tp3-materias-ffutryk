class CriterioDeInscripcion {
  method estaHabilitado(estudiante, materia)
}

object porPrerrequisitos inherits CriterioDeInscripcion {
  override method estaHabilitado(estudiante, materia) = estudiante.aproboTodosLosPrerrequisitosDe(materia)
}

object porCreditos inherits CriterioDeInscripcion {
  override method estaHabilitado(estudiante, materia) = materia.tieneCreditosSuficientes(estudiante)
}

object porAñoAcademico inherits CriterioDeInscripcion {
  override method estaHabilitado(estudiante, materia) = estudiante.aproboTodasLasMateriasDelAñoAnterior(materia.año())
}

object libre inherits CriterioDeInscripcion {
  override method estaHabilitado(estudiante, materia) = true
}