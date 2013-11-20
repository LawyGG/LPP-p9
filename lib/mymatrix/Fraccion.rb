
class Fraccion
  
  attr_accessor :num, :denom
  include Comparable

  def initialize(n, d)
    @num, @denom = n, d
    
    raise TypeError unless n.is_a?(Numeric)
    raise TypeError unless d.is_a?(Numeric)
    raise TypeError unless (d != 0)
    
    min = mcd(@num,@denom)
    @num = @num / min
    @denom = @denom / min
  end
  
  def <=> (other)
    nd = mcm(@denom,other.denom)
    nn1 = (nd/@denom)*@num
    nn2 = (nd/other.denom)*other.num

    nn1 <=> nn2
  end 

  def mcd(a,b)
    a, b = a.abs, b.abs
    while b != 0
      a, b = b, a % b
    end
    a
  end

  def mcm(a,b)
    l1 = a*b
    l2 = l1/mcd(a,b) 
  end

  def to_s
    "#{@num}/#{@denom}"
  end

  def to_f
    (@num.to_f)/(@denom.to_f)
  end

  def abs
    Fraccion.new(@num.abs,@denom.abs)
  end

  def reciproco
    Fraccion.new(@denom,@num)
  end

  def opuesto
    Fraccion.new((-1)*@num,@denom)
  end

  def %(other)
    Fraccion.new(0,1)
  end
  
  def coerce(something)

    if(something.is_a? Numeric)
	aux = Fraccion.new(something,1)
	[self,aux]
    end
  end
  
  def +(other)
    nd = mcm(@denom,other.denom)
    nn1 = (nd/@denom)*@num
    nn2 = (nd/other.denom)*other.num
    nn = nn1 + nn2
    Fraccion.new(nn,nd)
  end

  def -(other)
    nd = mcm(@denom,other.denom)
    nn1 = (nd/@denom)*@num
    nn2 = (nd/other.denom)*other.num
    nn = nn1 - nn2
    Fraccion.new(nn,nd)
  end

  def *(other)
    nn = (@num*other.num)
    nd = (@denom*other.denom)
    Fraccion.new(nn,nd)
  end

  def /(other)
    nn = (@num*other.denom)
    nd = (@denom*other.num)
    Fraccion.new(nn,nd)
  end
end
