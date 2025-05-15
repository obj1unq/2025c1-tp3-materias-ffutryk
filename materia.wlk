class Materia {
  const property prerrequisitos
  const property inscriptos = #{}
  const cupos
  var property listaDeEspera = []
  
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
  
  method validarInscripcion(estudiante) {
    if (!estudiante.sePuedeInscribir(self)) self.error(
        "El estudiante no se puede inscribir en la materia"
      )
  }
}

class Aprobacion {
  const property estudiante
  const property materia
  const property nota

  method esLaMateria(_materia) = materia === _materia
}