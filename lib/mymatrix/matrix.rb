#require './Fraccion.rb'

class Matrix_base

	attr_accessor :ancho, :alto

	def initialize
		@ancho, @alto = ancho, alto
	end

end


class Matrix < Matrix_base

	attr_accessor :matriz
	
	def initialize(ancho, alto)
		super
		@matriz=Array.new(ancho)
		@matriz.map! {Array.new(alto)}		
	end
	
	def [](i)
		@matriz[i]
	end

	def []=(i,other)
		@matriz[i]=other
	end

	def to_s
		tmp="["
		for i in 0...@ancho
			tmp+="["
			for j in 0...@alto
				tmp+="#{@matriz[i][j]}"
				if j < (@alto-1)
				tmp+=","
				end	
			end
			tmp+="]"	
		end
		tmp+="]"
		tmp
	end

	def ==(other)
		for i in 0...@ancho
			for j in 0...@alto
				@matriz[i][j]==other.matriz[i][j]
			end
		end
	end

	def +(other)
		resultado=Matrix.new(@ancho, @alto)
		raise 'Las matrices deben tener las mismas dimensiones' unless other.ancho==@ancho && other.alto==@alto
		for i in 0...@ancho
			for j in 0...@alto
				resultado[i][j] = @matriz[i][j]+other.matriz[i][j]
			end
		end
		resultado
	end

	def *(other)
        	resultado=Matrix.new(@ancho, @alto)
		raise 'Las matrices deben tener las mismas dimensiones' unless other.alto==@ancho

		for i in 0...@ancho do 
                	for j in 0...@alto do
                                suma = (self.matriz[i][j] * other.matriz[j][0])
                        	for k in 1...@alto do
                                	resultado[i][k] = suma + (self.matriz[i][j] * other.matriz[j][k])
                        	end
                	end
        	end
		resultado
	end
end



class Matrix_disp < Matrix_base

	attr_accessor :valor, :x, :y

	def initialize (ancho, alto, nnum)
		super(ancho, alto)

		@x = Array.new[nnum]
		@y = Array.new[nnum]
		@valor = Array.new[nnum]
	end
	
	def encontrar(i, j)
	  for k in 0...@x.length do
		if ( @x[k]=i && @y[k]=j)
		   return k; 
		end
 	  end
	  return -1
	end


	def to_s
                tmp="["
                for i in 0...@ancho
                        tmp+="["
                        for j in 0...@alto
				aux = encontrar(i,j)
				if(aux != -1)
                                	tmp+="#{@valor[aux]}"
				else
				  tmp+=0
				end

                                if j < (@alto-1)
                                tmp+=","
                                end
                        end
                        tmp+="]" 
                end
                tmp+="]"
                tmp
        end

	def to_matrix
		mat = Matrix.new(@ancho,@alto)

		for i in 0...@ancho do
		  for j in 0...@alto do
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

	 def ==(other)
                for i in 0...@x.length
                   @x[k] == other.x[k]
		   @y[k] == other.y[k]
		   @valor[k] == other.valor[k]
                end
        end

        def +(other)
                resultado=Matrix.new(@ancho, @alto)
                raise 'Las matrices deben tener las mismas dimensiones' unless other.ancho==@ancho && other.alto==@alto
                for i in 0...@ancho
                        for j in 0...@alto
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

        def *(other)

		m2 = other.to_matrix
		m1 = self.to_matrix

                resultado=Matrix.new(@ancho, @alto)
                raise 'Las matrices deben tener las mismas dimensiones' unless other.alto==@ancho

                for i in 0...@ancho do
                        for j in 0...@alto do
                                suma = (m1.matriz[i][j] * m2.matriz[j][0])
                                for k in 1...@alto do
                                        resultado[i][k] = suma + (m1.matriz[i][j] * m2.matriz[j][k])
                                end
                        end
                end
                resultado
        end


end


