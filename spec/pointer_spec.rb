require File.dirname(__FILE__) + "/spec_helper"

describe Coal do

coal_examples [

  "int8 x = 42 ; return(*@x)",
  [[:decl, "int8", "x", 42],
  [:ret, [:deref, [:addr, "x"]]]],
  42,
  
  "int8 x = 42 ; return(*@x:int8)",
  [[:decl, "int8", "x", 42],
  [:ret, [:deref, [:addr, "x"], "int8"]]],
  42,
  
  "int8 x = 42 ; @int8 ptr = @x ; return(*ptr)",
  [[:decl, "int8", "x", 42],
  [:decl, ["pointer", "int8"], "ptr", [:addr, "x"]],
  [:ret, [:deref, "ptr"]]],
  42,
  
  "int8 x = 42 ; @int8 ptr = @x ; @@int8 pptr = @ptr ; return(*(*pptr:@int8):int8)",
  [[:decl, "int8", "x", 42],
  [:decl, ["pointer", "int8"], "ptr", [:addr, "x"]],
  [:decl, ["pointer", "pointer", "int8"], "pptr", [:addr, "ptr"]],
  [:ret, [:deref, [:deref, "pptr", ["pointer", "int8"]], "int8"]]],
  42,
  
  "int8 x = 42 ; @int8 ptr = @x ; @@int8 pptr = @ptr ; return(**pptr)",
  [[:decl, "int8", "x", 42],
  [:decl, ["pointer", "int8"], "ptr", [:addr, "x"]],
  [:decl, ["pointer", "pointer", "int8"], "pptr", [:addr, "ptr"]],
  [:ret, [:deref, [:deref, "pptr"]]]],
  42,

]

end

