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
  
  method aprobo(materia) = materiasAprobadas.any{ aprobacion => aprobacion.esLaMateria(materia) }
  
  method materiasDeLasCarreras() = carreras.flatMap{ carrera => carrera.materias() }.asSet()
  
  method esMateriaDeUnaCarreraQueCursa(materia) = carreras.contains(materia.carrera())
  
  method aproboTodosLosPrerrequisitosDe(materia) = materia.prerrequisitos().all{ prerrequisito => self.aprobo(prerrequisito) }
  
  method materiasEnLasQueEstaInscripto() = self.materiasDeLasCarreras().filter{ materia => materia.estaInscripto(self) }.asSet()
  
  method materiasEnLasQueEstaEnEspera() = self.materiasDeLasCarreras().filter{ materia => materia.enListaDeEspera(self) }.asSet()
  
  method materiasALasQueSePuedeInscribir(carrera) = carrera.materias().filter{ materia => materia.sePuedeInscribir(self) }.asSet()

  method cantidadDeAprobadasDeLaCarrera(carrera) = self.materiasAprobadasDeLaCarrera(carrera).size()

  method materiasAprobadasDeLaCarrera(carrera) = carrera.materias().filter{ materia => self.aprobo(materia) }.asSet()
  
  method creditosTotales() = materiasAprobadas.fold(0, { prev, aprobacion => prev + aprobacion.creditos() })

  method materiasDelAñoAnterior(año) = self.materiasDeLasCarreras().filter{ materia => materia.año() == año - 1 }

  method aproboTodasLasMateriasDelAñoAnterior(año) = self.materiasDelAñoAnterior(año).all{ materia => self.aprobo(materia) }

  method validarAprobacion(materia) {
    if (self.aprobo(materia)) self.error("El estudiante ya ha aprobado la materia.")
  }
}