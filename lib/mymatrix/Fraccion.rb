# Autores:: 
# - Laura Abigail Gómez González
# - Alberto Fariña Barrera
#
#
# La clase Fraccion ofrece la posibilidad de crear objetos representados como fracción, así
# como realizar muchas de las operaciones más básicas que se pueden realizar con fracciones,
# tales como operaciones aritméticas, comparacionales, etc. 
class Fraccion
  
  # Se crean los atributos 'num' y 'denom' para poder acceder posteriormente a las variables
  # de instancia creadas en el initialize.
  attr_accessor :num, :denom
  include Comparable

  # El método initialize realiza dos funciones principales:
  # * Comprobar que la entrada del programa es correcta.
  # * Crear e inicializar las variables de instancia a los valores indicados.
  def initialize(n, d)
    @num, @denom = n, d
    
    raise TypeError unless n.is_a?(Numeric)
    raise TypeError unless d.is_a?(Numeric)
    raise TypeError unless (d != 0)
    
    min = mcd(@num,@denom)
    @num = @num / min
    @denom = @denom / min
  end
  
  # Este método junto al módulo comparable permite la comparación de objetos de la clase fraccion.
  def <=> (other)
    nd = mcm(@denom,other.denom)
    nn1 = (nd/@denom)*@num
    nn2 = (nd/other.denom)*other.num

    nn1 <=> nn2
  end 

  # Permite hallar el máximo común divisor de dos numeros cualquiera.
  def mcd(a,b)
    a, b = a.abs, b.abs
    while b != 0
      a, b = b, a % b
    end
    a
  end

  # Permite hallar el mínimo común múltiplo de dos números cualquiera.
  def mcm(a,b)
    l1 = a*b
    l2 = l1/mcd(a,b) 
  end

  # Convierte una Fracción a String sobretodo para facilitar su muestra por pantalla.
  def to_s
    "#{@num}/#{@denom}"
  end

  # Convierte una Fracción a Flotante.
  def to_f
    (@num.to_f)/(@denom.to_f)
  end

  # Calcula el valor absoluto de una Fracción.
  def abs
    Fraccion.new(@num.abs,@denom.abs)
  end

  # Calcula el recíproco de una Fracción.
  def reciproco
    Fraccion.new(@denom,@num)
  end

  # Calcula el opuesto de una Fracción.
  def opuesto
    Fraccion.new((-1)*@num,@denom)
  end

  # Calcula el resto de dos Fracciones. 
  def %(other)
    Fraccion.new(0,1)
  end
  
  # En el caso de que se realize una operacion de una Fracción con algún otro objeto, este método
  # convierte ese otro objeto en un objeto de tipo Fracción para poder realizar la operación
  # correctamente.
  def coerce(something)

    if(something.is_a? Numeric)
	aux = Fraccion.new(something,1)
	[self,aux]
    end
  end
  
  # Calcula la suma de dos Fracciones devolviendo un nuevo objeto Fracción con el resultado.
  def +(other)
    nd = mcm(@denom,other.denom)
    nn1 = (nd/@denom)*@num
    nn2 = (nd/other.denom)*other.num
    nn = nn1 + nn2
    Fraccion.new(nn,nd)
  end

  # Calcula la resta de dos Fracciones devolviendo un nuevo objeto Fracción con el resultado.
  def -(other)
    nd = mcm(@denom,other.denom)
    nn1 = (nd/@denom)*@num
    nn2 = (nd/other.denom)*other.num
    nn = nn1 - nn2
    Fraccion.new(nn,nd)
  end

  # Calcula la multiplicación de dos Fracciones devolviendo un nuevo objeto Fracción con el resultado.
  def *(other)
    nn = (@num*other.num)
    nd = (@denom*other.denom)
    Fraccion.new(nn,nd)
  end

  # Calcula la división de dos Fracciones devolviendo un nuevo objeto Fracción con el resultado.
  def /(other)
    nn = (@num*other.denom)
    nd = (@denom*other.num)
    Fraccion.new(nn,nd)
  end
end
