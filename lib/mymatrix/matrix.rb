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
			for j in 0...@ancho
				tmp+="#{@matriz[i][j]}"
				if j < (@ancho-1)
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
			for j in 0...@ancho
				@matriz[i][j]==other.matriz[i][j]
			end
		end
	end

	def +(other)
		resultado=Matrix.new(@ancho)
		raise 'Las matrices deben tener las mismas dimensiones' unless other.ancho==@ancho
		for i in 0...@ancho
			for j in 0...@ancho
				resultado[i][j] = @matriz[i][j]+other.matriz[i][j]
			end
		end
		resultado
	end

	def *(other)
        	resultado=Matrix.new(@ancho)
		raise 'Las matrices deben tener las mismas dimensiones' unless other.ancho==@ancho

		for i in 0...@ancho do 
                	for j in 0...@ancho do
                                suma = (self.matriz[i][j] * other.matriz[j][0])
                        	for k in 1...@ancho do
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

		@coord = Array.new[nnum]
		@coord.map! {Array.new(2)}

		@x = Array.new[nnum]
		@y = Array.new[nnum]
		@valor = Array.new[nnum]

	end

	def [](i)
                @coord[i]
        end

        def []=(i,other)
                @coord[i]=other
        end

	def to_s
		tmp="["
		for i in 0...@ncho
		for i2 in 0...@coord.size
			tmp+="["
			for j in 0...@alto
			for j2 in 0
			if @coord[i2][j2] = i and @coord[i2][j2+1] = j
				tmp+="#{@valor[i]
	

end



