module Coal::Translators

class Ruby
  def build_callable(param_types, return_type, tree)
    @code = ""
    @indent = ""
    
    tree.translate(self)
    
    lambda do |*args|
      eval @code
    end
  end
  
  def code
    @code
  end
  
  def type(*args)
    args.first.to_sym
  end
  
  def bitshift_left(a, b)
    "(#{a} << #{b})"
  end
  
  def bitshift_right(a, b)
    "(#{a} >> #{b})"
  end
  
  def prefix_increment(a)
    "(a += 1)"
  end
  
  def prefix_decrement(a)
    "(a -= 1)"
  end
  
  def add(a, b)
    "(#{a} + #{b})"
  end
  
  def subtract(a, b)
    "(#{a} - #{b})"
  end
  
  def multiply(a, b)
    "(#{a} * #{b})"
  end
  
  def divide(a, b)
    "(#{a} / #{b})"
  end
  
  def modulus(a, b)
    "(#{a} % #{b})"
  end
  
  def negate(a)
    "(-#{a})"
  end
  
  def bitwise_not(a)
    "(~#{a})"
  end
  
  def address_of(a)
    "(#{a}.address)"
  end
  
  def dereference(a, type)
    #TODO: support more types
    if type == :int8
      "VirtMem.load(#{a}, VirtMem::Int8)"
    else
      raise NotImplementedError.new("TODO: dereference for Ruby translator")
    end
  end
  
  def bitwise_and(a, b)
    "(#{a} & #{b})"
  end
  
  def bitwise_xor(a, b)
    "(#{a} ^ #{b})"
  end
  
  def bitwise_or(a, b)
    "(#{a} | #{b})"
  end
  
  def assign(var, val)
    line = "(#{var} = #{var}.is_a?(VirtMem::Number) ? #{var}.class.new(#{val}) : #{val})"
    append line
    line
  end
  
  def variable(var)
    var
  end
  
  def integer_constant(n)
    n.to_s
  end
  
  def declare(type, var)
    #TODO: support more types
    if type == :int8
      append "#{var} = VirtMem::Int8.new(0)"
    else
      append "#{var} = nil"
    end
    var
  end
  
  def less a, b
    "(#{a} < #{b})"
  end
  
  def less_or_equal a, b
    "(#{a} <= #{b})"
  end
  
  def greater a, b
    "(#{a} > #{b})"
  end
  
  def greater_or_equal a, b
    "(#{a} >= #{b})"
  end
  
  def equal a, b
    "(#{a} == #{b})"
  end
  
  def not_equal a, b
    "(#{a} != #{b})"
  end
  
  def true
    "true"
  end
  
  def false
    "false"
  end
  
  def null
    "nil"
  end
  
  def arg(i)
    "args[#{i}]"
  end
  
  def return(val)
    append "return(#{val})"
  end
  
  def while(cond)
    append "while(#{cond.translate(self)})"
    @indent << "  "
    yield
    @indent = @indent[0...-2]
    append "end"
  end
  
  def until(cond)
    append "until(#{cond.translate(self)})"
    @indent << "  "
    yield
    @indent = @indent[0...-2]
    append "end"
  end
  
  def break
    append "break"
  end
  
  def if(cond, els=nil)
    append "if(#{cond.translate(self)})"
    indent { yield }
    if els
      append "else"
      indent { els.translate(self) }
    end
    append "end"
  end
  
  def unless(cond, els=nil)
    append "unless(#{cond.translate(self)})"
    indent { yield }
    if els
      append "else"
      indent { els.translate(self) }
    end
    append "end"
  end
  
  def indent
    @indent << "  "
      yield
    @indent = @indent[0...-2]
  end
  
  def append(str)
    @code << @indent
    @code << str
    @code << "\n"
  end
end

end

