# La clase 'Matrix_base' se usa como clase padre de las clases que contendrán tanto la matrix dispersa
# como la densa, conteniendo los métodos que ambas clase usarán en común.
class Matrix_base

	# Se declaran los términos 'ancho' y 'alto' que llamarán a las variables de instancia homónimas.
	attr_accessor :ancho, :alto

	# La función de initialize es muy simple:
	# * Inicializar las variables de instancia para el tamaño de la matriz.
	# * Crear una matriz vacía que será usada por las clases hijas.
	def initialize(ancho, alto)
		@ancho, @alto = ancho, alto
		@matriz = [[]]
	end

	# Este método permite el uso de corchetes para la variable matriz en el caso de la llamada.
	# Por ejemplo permite usar sentencias como: "p = @matriz[1][1]".
	def [](i)
                @matriz[i]
        end

	# Este método es identico al anterior pero para el caso de que el elemento de la matriz
	# se iguale a otro elemento.
	# Esto permitiría realizar sentencias tales como: "@matriz[1][1] = p".
        def []=(i,other)
                @matriz[i]=other
        end

	# Método que permite sumar un elemento de la clase con otro. Está definido de forma funcional.
	def +(other)
                resultado=Matrix.new(@ancho, @alto)
                raise 'Las matrices deben tener las mismas dimensiones' unless other.ancho==@ancho && other.alto==@alto
                @ancho.times do |i|
                        @alto.times do |j| 
                                resultado[i][j] = @matriz[i][j]+other.matriz[i][j]
                        end
                end
                resultado
        end

	# Método que permite multiplicar dos elementos de la clase. Está definido de forma funcional.
        def *(other)
                resultado=Matrix.new(@ancho, @alto)
                raise 'Las matrices deben tener las mismas dimensiones' unless other.alto==@ancho

                @ancho.times do |i|
                       @alto.times do |j|
                                suma = (self.matriz[i][j] * other.matriz[j][0])
                                @alto.times  do |k|
                                        resultado[i][k] = suma + (self.matriz[i][j] * other.matriz[j][k])
                                end
                        end
                end
                resultado
        end

	# Este método permite restar dos objetos de esta clase entre sí. Está definido de forma funcional.
	def -(other)
		resultado=Matrix.new(@ancho, @alto)
                raise 'Las matrices deben tener las mismas dimensiones' unless other.ancho==@ancho && other.alto==@alto
                @ancho.times do |i|
                        @alto.times do |j|
                                resultado[i][j] = @matriz[i][j]-other.matriz[i][j]
                        end
                end
                resultado
	end
end

# La clase Matrix hereda de la clase 'Matrix_base' y será la que se utilize para definir las matrices densas.
class Matrix < Matrix_base

	# Crea el término matriz para referirse a dicha variable de instancia.
	attr_accessor :matriz
	
	# El initialize realiza dos funciones:
	# * Con el comando 'super' llama al initialize de la clase madre.
	# * Otorgarle a la matriz el alto y el ancho deseado.
	def initialize(ancho, alto)
		super
		@matriz=Array.new(ancho)
		@matriz.map! {Array.new(alto)}		
	end

	# Este método recorre la matriz y devolverá la posición de la matriz si lo que se realiza en el bloque
	# llamado por yield es verdadero, si lo que se realiza en el bloque no se cumple, devuelve nil.
	def encontrar
		@ancho.times do |i|
			@alto.times do |j|
				val = @matriz[i][j]
				return [i,j] if yield(val)
			end
		end
		return nil
	end
	
	# La salida de este método es la matriz pasada a string, de manera que pueda usarse en 'puts',
	# comprobaciones, etc.
	def to_s
		tmp="["
		@ancho.times do |i|
			tmp+="["
			@alto.times do |j|
				tmp+="#{@matriz[i][j]}"
				if j < (@ancho-1)
				tmp+=","
				end	
			end
			tmp+="]"
			if (i< (@ancho-1))
			tmp+=","
			end	
		end
		tmp+="]"
		tmp
	end

	# Este método permite comparar dos objetos de la clase Matrix y devolverá 'true' si son iguales y
	# 'false' si son distintos.
	def ==(other)
		@ancho.times do |i|
			@alto.times do |j|
				@matriz[i][j]==other.matriz[i][j]
			end
		end
	end

	# La suma tiene dos partes diferenciadas:
	# * Si el elemento de la derecha es una matriz dispersa, esta se pasa a densa y se llama a super
	#   para que opere con ellas.
	# * En otro caso directamente llama a super ya que las dos matrices serían densas.
	def +(other)
		if (other.is_a? Matrix_disp) 
		  m1 = other.to_matrix
		  super(m1)
		else
		  super
		end
	end

	# La multiplicación tiene dos partes diferenciadas:
        # * Si el elemento de la derecha es una matriz dispersa, esta se pasa a densa y se llama a super
        #   para que opere con ellas.
        # * En otro caso directamente llama a super ya que las dos matrices serían densas.
	def *(other)
		if( other.is_a? Matrix_disp)
		  m1 =other.to_matrix
		  super(m1)
		else
		  super
		end
	end

	# La resta tiene dos partes diferenciadas:
        # * Si el elemento de la derecha es una matriz dispersa, esta se pasa a densa y se llama a super
        #   para que opere con ellas.
        # * En otro caso directamente llama a super ya que las dos matrices serían densas.
	def -(other)
		if (other.is_a? Matrix_disp)
                  m1 = other.to_matrix
                  super(m1)
                else
                  super
                end
	end

	# Este método halla el máximo elemento de la matriz desde la que se llame.
	def max
		max=0
	  	@ancho.times do |i| 
		  @alto.times do |j| 
			if(@matriz[i][j] > max)
			  max=@matriz[i][j]
			end
		  end
		end
		max
	end

	# Este método halla el mínimo elemento de la matriz desde la que se llame.
	def min
                min=999999
                @ancho.times do |i|
                  @alto.times do |j|
                        if(@matriz[i][j] < min)
                          min=@matriz[i][j]
                        end
                  end
                end
		min
        end
end

# La clase Matrix_disp es la clase hija de 'Matrix_base' que se encargará de representar las matrices
# dispersas
class Matrix_disp < Matrix_base
	
	# En este caso a parte de ancho y alto definiremos lo siguiente para llamar a las variables
	# de instancia definidas en el initialize.
	attr_accessor :valor, :x, :y

	# Este initialize llama a super con los parámetros ancho y alto y luego crea los tres arrays
	# necesarios para almacenar la matriz que serán de tamaño 'nnum', donde 'nnum' es el numero 
	# de elementos no nulos de la matriz.
	def initialize (ancho, alto, nnum)
		super(ancho, alto)

		@x = Array.new[nnum]
		@y = Array.new[nnum]
		@valor = Array.new[nnum]
	end

	# Este método permite comprobar si es una posición dada de la matriz hay un elemento o es
	# nulo. Si hay un elemento no nulo, devuelve ese elemento. Si encuentra un nulo devuelve -1. 
	def encontrar(i, j)
	  @x.length.times do |k|
		if ( @x[k]==i && @y[k]==j)
		   return k; 
		end
 	  end
	  return -1
	end

	# Permite pasar la matriz dispersa a string para poder mostrarla por pantalla o compararla
	def to_s
                tmp="["
                @ancho.times do |i|
                        tmp+="["
                        @alto.times do |j| 
				aux = encontrar(i,j)
				if(aux == -1)
                                	tmp+="0"
				else
				  tmp+="#{@valor[aux]}"
				end

                                if j < (@ancho -1)
                                tmp+=","
                                end
                        end
                        tmp+="]" 
			if i < (@alto-1)
			  tmp+=","
			end
                end
                tmp+="]"
        end

	# Est método permite convertir una matriz dispersa en una matriz continua.
	def to_matrix
		mat = Matrix.new(@ancho,@alto)

		@ancho.times do |i|
		  @alto.times do |j|
		      aux = encontrar(i,j)
		      if (aux != -1)
			mat[i][j] = @valor[aux]
		      else
			mat[i][j] = 0
		      end
		  end
		end
		mat
	end	

	# Este método permite comparar dos matrices dispersas.
	def ==(other)
                @x.length.times do |k|
                   @x[k] == other.x[k]
		   @y[k] == other.y[k]
		   @valor[k] == other.valor[k]
                end
        end

	# Este método comprueba en primer lugar si el objeto con el que se va a sumar es una matriz densa.
	# Si lo es, convierte dicha matriz dispersa a densa y vuelve a hacer la suma. En el caso de que la
	# otra sea dispersa se realiza el algoritmo que se encuentra en el 'else'.
        def +(other)

		if(other.is_a? Matrix)
			m1 = self.to_matrix
			m1+other
		else
                  resultado=Matrix.new(@ancho, @alto)
                  raise 'Las matrices deben tener las mismas dimensiones' unless other.ancho==@ancho && other.alto==@alto
                  @ancho.times do |i|              	  
			@alto.times do |j|
			  aux1 = encontrar(i,j)
			  aux2 = other.encontrar(i,j)

			  if(aux1 == -1)
				aux1 = 0
			  else
				aux1 = @valor[aux1]
			  end
			  
			  if(aux2 == -1)
			  	aux2 = 0
			  else
				aux2 = other.valor[aux2]
			  end

			  resultado[i][j] = aux1 + aux2
                        end
                  end
                  resultado
		end
        end

	# En este caso, para hacer la multiplicación se pasará la matriz a densa, sea cual sea su posición y
	# siempre que sea dispersa para luego operar de nuevo.
        def *(other)
		m1 = self.to_matrix
		
		if(other.is_a? Matrix_disp)
		  m2 = other.to_matrix
		  m1*m2
		else
		  m1*other
		end
	end

	# Para hacer la resta se sigue el mismo método que con la suma. Si la matriz de la derecha es densa,
	# se pasa a densa la de la izquierda para luego operar de nuevo y si es dispersa se sigue el algoritmo. 
	def -(other)
		if(other.is_a? Matrix)
                        m1 = self.to_matrix
                        m1-other
                else
                  resultado=Matrix.new(@ancho, @alto)
                  raise 'Las matrices deben tener las mismas dimensiones' unless other.ancho==@ancho && other.alto==@alto
                  @ancho.times do |i|
                          @alto.times do |j|
                          aux1 = encontrar(i,j)
                          aux2 = other.encontrar(i,j)

                            if(aux1 == -1)
                                aux1 = 0
                            else
                                aux1 = @valor[aux1]
                            end

                            if(aux2 == -1)
                                aux2 = 0
                            else
                                aux2 = other.valor[aux2]
                            end

                          resultado[i][j] = aux1 -  aux2
                        end
                  end
                  resultado
                end
	end

	# Este método halla el máximo elemento de la matriz dispersa.
	def max
	  max=0

	  @valor.length.times do |i|
		if(@valor[i] > max)
		  max=@valor[i]
		end	
	  end
	  max
	end

	# Este método halla el mínimo elemento de la matriz dispersa.
	def min
          min=999999

          @valor.length.times do |i|
                if(@valor[i] < min)

                  min=@valor[i]
                end
          end
	  min
        end
end


#Esta clase matrixDSL esta pensada para dar al usuario una forma diferente de interactuar con las clases
#La manera de interactuar sera la siguiente:
#Al constructor de esta clase se le pasara la operacion a realizar y un bloque.
#Dicho bloque podrá ccontendrá
	#Las siguientes opciones:
  	   #(Obligatoriamente): densa o dispersa
	   #console o file
	#Los operandos(matrices):
	   #Formato Matrices Densas [[1,1,1],[1,1,1]]
	   #Formato Matrices Dispersas [ancho, alto, nzeros, [x], [y], [valor]]

class MatrixDSL 

  attr_accessor :matrices, :print, :type, :operacion

  def initialize(op, &block)

    @matrices = [] #matrices a operar
    @print = "" #opcion para imprimir (console/file)
    @type = "" #tipo de matrices
    @operacion = op

    instance_eval(&block)
  end

  def option(arg)
	case arg
	   when 'densa','dispersa' then @type = arg
	   when 'console','file' then @print = arg
	end
  end

  def operand(vector)
	if @type == 'densa'
	  aux = Matrix.new(vector.length, vector[0].length)
	  aux.matriz = vector

	  @operand << aux

	elsif @type == 'dispersa'
	   aux = Matrix_disp(vector[0],vector[1],vector[2])
	   aux.x = vector[3]
	   aux.y = vector[4]
	   aux.valor = vector[5]

	   @operand << aux
	end
  end

  def run
	case @operacion
	end
  end

end


