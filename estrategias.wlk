class EstrategiaListaEspera  {
  method seleccionarSiguiente(materia)
}

object elitista inherits EstrategiaListaEspera  {
  override method seleccionarSiguiente(materia) = materia.listaDeEspera().max{estudiante => estudiante.promedio()}
}

object ordenada inherits EstrategiaListaEspera  {
  override method seleccionarSiguiente(materia) = materia.listaDeEspera().head()
}

object porAvance inherits EstrategiaListaEspera  {
  override method seleccionarSiguiente(materia) = materia.listaDeEspera().max{estudiante => estudiante.cantidadDeAprobadasDeLaCarrera(materia.carrera())}
}