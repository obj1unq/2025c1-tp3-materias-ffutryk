class Materia {
  const property prerrequisitos
  const property inscriptos = #{}
  const cupos
  var property listaDeEspera = []
  const property carrera
  const property estrategia
  const property criterio
  const property año
  const property creditosOtorgados
  const property creditosNecesarios
  
  method inscribirEstudiante(estudiante) {
    self.validarInscripcion(estudiante)
    
    if (self.hayCupoDisponible()) inscriptos.add(estudiante)
    else listaDeEspera.add(estudiante)
  }
  
  method darDeBaja(estudiante) {
    inscriptos.remove(estudiante)
    
    const nuevoEstudiante = listaDeEspera.head()
    listaDeEspera = listaDeEspera.drop(1)
    
    self.inscribirEstudiante(nuevoEstudiante)
  }
  
  method hayCupoDisponible() = self.cantidadDeInscriptos() < cupos
  
  method cantidadDeInscriptos() = inscriptos.size()
  
  method estaInscripto(estudiante) = inscriptos.contains(estudiante)
  
  method enListaDeEspera(estudiante) = listaDeEspera.contains(estudiante)
  
  method tieneCreditosSuficientes(estudiante) = estudiante.creditosTotales() >= creditosNecesarios

  method sePuedeInscribir(estudiante) = estudiante.esMateriaDeUnaCarreraQueCursa(self) && (!estudiante.aprobo(self))
    && criterio.estaHabilitado(estudiante, self) && (!self.estaInscripto(estudiante))

  method validarInscripcion(estudiante) {
    if (!self.sePuedeInscribir(estudiante)) self.error(
        "El estudiante no se puede inscribir en la materia"
      )
  }
}

class Aprobacion {
  const property estudiante
  const property materia
  const property nota

  method esLaMateria(_materia) = materia === _materia

  method creditos() = materia.creditosOtorgados()
}