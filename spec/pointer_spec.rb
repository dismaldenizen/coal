require File.dirname(__FILE__) + "/spec_helper"

describe Coal do

describe "int8 x = 42 ; return(*@x)" do
  it { should eval_with_libjit_to_int32(42) }
  it { should eval_with_ruby_to_int32(42) }
end

# *@x:int8 => "dereference pointer to x as int8"
describe "int8 x = 42 ; return(*@x:int8)" do
  it { should eval_with_libjit_to_int32(42) }
  it { should eval_with_ruby_to_int32(42) }
end

describe "int8 x = 42 ; @int8 ptr = @x ; return(*ptr)" do
  it { should eval_with_libjit_to_int32(42) }
  it { should eval_with_ruby_to_int32(42) }
end

describe "int8 x = 42 ; @int8 ptr = @x ; @@int8 pptr = @ptr ; return(*(*pptr:@int8):int8)" do
  it { should eval_with_libjit_to_int32(42) }
  it { should eval_with_ruby_to_int32(42) }
end

describe "int8 x = 42 ; @int8 ptr = @x ; @@int8 pptr = @ptr ; return(**pptr)" do
  it { should eval_with_libjit_to_int32(42) }
  it { should eval_with_ruby_to_int32(42) }
end

end

