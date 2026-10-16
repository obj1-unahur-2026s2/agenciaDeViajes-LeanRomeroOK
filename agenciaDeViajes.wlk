class Pack{
    const property duracion //dias
    const property precio 
    const property beneficios = []
    const property coordinador

    method agregarBeneficio(beneficio){
        beneficios.add(beneficio)
    }

    method quitarBeneficio(beneficio){
        beneficios.remove(beneficio)
    }

    method costoDeLosBeneficios(){
        return beneficios.sum({b => b.precio()})
    }

    method valorFinal()

    method esPremium()
}

class PackNacional inherits Pack{
    const property destino //provincia
    const property actividades= []

    method agregarActividad(actividad){
        actividades.add(actividad)
    }

    override method valorFinal(){
        return precio + self.costoDeLosBeneficios()
    }

    override method esPremium(){
        return self.duracion() > 10 and self.coordinador().esAltamenteCalificado()
    }
}

class PackInternacional inherits Pack{
    const property destino //pais
    const property cantidadDeEscalas
    const property esLugarDeInteres //booleano

    override method valorFinal(){
        return (precio + self.costoDeLosBeneficios()) * 1.20
    }

    override method esPremium(){
        return self.esLugarDeInteres() and self.duracion() > 20 and self.cantidadDeEscalas() == 0
    }
}

class Coordinador{
    var property cantidadDeViajesRealizados
    var property experiencia //años
    var property estaMotivado //booleano
    var property rol

    const property rolesValidos = ["Guia", "Asistente", "Acompañante"]

    method cambiarRol(nuevoRol){
        if (not rolesValidos.contains(nuevoRol)){
            self.error("Rol no valido")
        }
        rol = nuevoRol
    }

    method esAltamenteCalificado(){
        if (self.rol() == "Guia" and self.estaMotivado()){
            return self.cantidadDeViajesRealizados() > 20
        } 
        else if (self.rol() == "Asistente" and self.experiencia() >=3){
            return self.cantidadDeViajesRealizados() > 20
        }
        else if (self.rol() == "Acompañante"){
            return self.experiencia() > 5
        }
        else return false
    }
}

class BeneficioEspecial{
    const property tipo //Ej. Translado privado, Sala VIP, seguros, etc.
    const property precio
    var property estaVigente //booleano
}

class PackProvincial inherits PackNacional{
    const property ciudadesVisitadas = #{}

    method agregarCiudad(ciudad){
        ciudadesVisitadas.add(ciudad)
    }

    method quitarCiudad(ciudad){
        ciudadesVisitadas.remove(ciudad)
    }

    override method esPremium(){
        return self.actividades().size() >= 4 and self.ciudadesVisitadas().size() > 5 and self.beneficios().size() >= 3
    }

    override method valorFinal(){
        return super() * 1.05
    }
}