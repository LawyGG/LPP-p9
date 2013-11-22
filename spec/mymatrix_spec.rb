require 'spec_helper'
require 'mymatrix'

describe "MyMatrix" do
	
	before :each do
		@m1 = Matrix.new(2,2)
		@m1.matriz = [[4,2],[1,3]]

		@m2 = Matrix_disp.new(2,2,1)
		@m2.x = [1]
		@m2.y = [1]
		@m2.valor = [2]

		@m3 = Matrix.new(2,2)
		@m3.matriz = [[1,4],[8,2]]

		@m4 = Matrix_disp.new(2,2,1)
                @m4.x = [1]
                @m4.y = [0]
                @m4.valor = [5]
	end

	describe "Inicializacion correcta" do
		it "inicializacion de m1" do
			r = Matrix.new(2,2)
			r.matriz = [[4,2],[1,3]]

			@m1.should == r
		end

		it "Inicializacion de m2" do
			r = Matrix_disp.new(2,2,1)
                	r.x = [1]
                	r.y = [1]
                	r.valor = [2]

			@m2.should == r
		end
	end

	describe "Comprobacion de muestra por pantalla" do
		it "Muestra por pantalla m1" do
			@m1.to_s.should eq("[[4,2],[1,3]]")
		end
		
		it "Muestra por pantalla m2" do
			@m2.to_s.should eq("[[0,0],[0,2]]")
		end
	end 

	describe "Comprobacion de la suma" do
		it "Comprobacion de suma de densas" do
			r = Matrix.new(2,2)
			r.matriz = [[5,6],[9,5]]

			(@m1 + @m3).should == r
		end

		it "Comprobacion de suma de dispersas" do
			r = Matrix.new(2,2)
			r.matriz = [[0,0],[5,2]]
	
			(@m2 + @m4).should == r
		end

		it "Comprobacion de suma de densa-dispersa" do
			r = Matrix.new(2,2)
			r.matriz = [[4,2],[1,5]]

			(@m1 + @m2).should == r
		end
		
		it "Comprobacion de suma de dispersa-densa" do
			r = Matrix.new(2,2)
			r.matriz = [[1,4],[13,2]]

			(@m4 + @m3).should == r
		end
	end

	describe "Comprobacion de la multiplicacion" do
		it "Comprobacion de la multiplicacion de densas" do
			r = Matrix.new(2,2)
			r.matriz = [[20,20],[25,10]]

			(@m1 * @m3).should == r
		end

		it "Comprobacion de la multiplicacion de dispersas" do
			r = Matrix.new(2,2)
			r.matriz = [[0,0],[10,0]]

			(@m2 * @m4).should == r
		end

		it "Comprobacion de la multiplicacion de densa-dispersa" do
			r = Matrix.new(2,2)
			r.matriz = [[0,4],[0,6]]
			
			(@m1 * @m2).should == r
		end

		it "Comprobacion de la multiplicacion de dispersa-densa" do
			r = Matrix.new(2,2)
			r.matriz = [[0,0],[5,20]]

			(@m4 * @m3).should == r
		end
	end

	describe "Comprobacion de la resta" do
		it "Comprobacion de la resta para densas" do
			r = Matrix.new(2,2)
                        r.matriz = [[3,-2],[-7,1]]

                        (@m1 - @m3).should == r
		end

		it "Comprobacion de la resta para dispersas" do
			r = Matrix.new(2,2)
                        r.matriz = [[0,0],[-5,2]]

                        (@m2 - @m4).should == r
		end

		it "Comprobacion de la resta para densa-dispersa" do
			r = Matrix.new(2,2)
                        r.matriz = [[4,2],[1,1]]

                        (@m1 - @m2).should == r
		end

		it "Comprobacion de la resta para dispersa-densa" do
			r = Matrix.new(2,2)
                        r.matriz = [[-1,-4],[-3,-2]]

                        (@m4 - @m3).should == r
		end
	end

	describe "Comprobacion de maximo y minimo" do
		it "Comprobacion de Maximo para densas" do
			@m1.max.should eq(4)
		end

		it "Comprobacion de maximo para dispersas" do
			@m2.max.should eq(2)
		end

		it "Comprobacion de minimo para densas" do
			@m3.min.should eq(1)
		end
		
		it "Comprobacion de minimo para dispersas" do
			@m4.min.should eq(5)
		end
	end

	describe "Comprobacion de coerce" do

		before :each do
			@f1 = Matrix.new(2,2)
			@f1.matriz = [[1,1],[1,1]]

			@f2 = Matrix.new(2,2)
			@f2.matriz = [[Fraccion.new(1,2),Fraccion.new(0,1)],[Fraccion.new(0,1),Fraccion.new(0,1)]]
		end

		it "Suma de matriz Fixnum y matriz Fraccion" do
			r = Matrix.new(2,2)
			r.matriz = [[Fraccion.new(3,2),Fraccion.new(1,1)],[Fraccion.new(1,1),Fraccion.new(1,1)]]	
			
			(@f1 + @f2).should == r
		end

		it "Resta de matriz fixnum y matriz Fraccion" do
			r = Matrix.new(2,2)
			r.matriz = [[Fraccion.new(1,2),Fraccion.new(1,1)],[Fraccion.new(1,1),Fraccion.new(1,1)]]

			(@f1 - @f2).should == r
		end

		it "Muliplicacion de matriz fixnum y matriz fraccion" do
			r = Matrix.new(2,2)
			r.matriz = [[Fraccion.new(1,2),Fraccion.new(1,2)],[Fraccion.new(0,1),Fraccion.new(0,1)]]
			
			(@f1 * @f2).should == r
		end
	end
end
