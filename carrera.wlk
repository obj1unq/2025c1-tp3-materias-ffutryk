class Carrera {
  const property materias = #{}

  method agregarMaterias(_materias) {
    self.validarPertenenciasACarrera(_materias)

    materias.addAll(_materias)
  }

  method validarPertenenciasACarrera(_materias) {
    _materias.forEach { materia => 
      self.validarPertenenciaACarrera(materia)
    }
  }

  method validarPertenenciaACarrera(materia) {
    if (materia.carrera() != self) {
      self.error("La materia no pertenece a la carrera")
    }
  }
}