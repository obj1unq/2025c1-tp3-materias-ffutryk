import materia.*

class Estudiante {
  const carreras
  const property materiasAprobadas = #{}
  
  method aprobar(materia, nota) {
    self.validarAprobacion(materia)
    
    const materiaAprobada = new Aprobacion(
      estudiante = self,
      materia = materia,
      nota = nota
    )
    
    materiasAprobadas.add(materiaAprobada)
  }
  
  method cantidadDeMateriasAprobadas() = materiasAprobadas.size()
  
  method promedio() = materiasAprobadas.average{ materia => materia.nota() }
  
  method aprobo(materia) = materiasAprobadas.any{ aprobacion => aprobacion.materia() == materia }
  
  
  method materiasDeLasCarreras() = carreras.flatMap{ carrera => carrera.materias() }
  
  
  method sePuedeInscribir(materia) = (self.esMateriaDeUnaCarreraQueCursa(materia) && (!self.aprobo(materia))) 
    && self.aproboTodosLosPrerrequisitosDe(materia) && self.noEstaInscriptoEn(materia)
  
  method esMateriaDeUnaCarreraQueCursa(materia) = self.materiasDeLasCarreras().contains(materia)
  
  method aproboTodosLosPrerrequisitosDe(materia) = materia.prerrequisitos().all{ prerrequisito => self.aprobo(prerrequisito) }
  
  method noEstaInscriptoEn(materia) = !materia.estaInscripto(self)
  
  method materiasEnLasQueEstaInscripto() = self.materiasDeLasCarreras().filter{ materia => materia.estaInscripto(self) }
  
  method materiasEnLasQueEstaEnEspera() = self.materiasDeLasCarreras().filter{ materia => materia.enListaDeEspera(self) }
  
  method materiasALasQueSePuedeInscribir(carrera) = carrera.materias().filter{ materia => self.sePuedeInscribir(materia) }
  
  method validarAprobacion(materia) {
    if (self.aprobo(materia)) self.error("El estudiante ya ha aprobado la materia.")
  }
  
  method validarInscripcionACarrera(carrera) {
    if (!carreras.contains(carrera)) self.error("El estudiante no está registrado en la carrera")
  }
}