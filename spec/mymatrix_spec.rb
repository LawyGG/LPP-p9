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
	end

	describe "Inicializacion correcta" do
		it "inicializacion de m1" do
			r = Matrix.new(2,2)
			r.matriz = [[4,2],[1,3]]

			#@m1.should == r
		end

		it "Inicializacion de m2" do
			r = Matrix_disp.new(2,2,1)
                	r.x = [1]
                	r.y = [1]
                	r.valor = [2]

			@m2.should == r
		end
	end

	describe "Comprobación de muestra por pantalla" do
		it "Muestra por pantalla m1" do
			@m1.to_s.should eq("[[4,2],[1,3]]")
		end
		
		it "Muestra por pantalla m2" do
			@m2.to_s.should eq("[[0,0],[0,2]]")
		end
	end 
end
