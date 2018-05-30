macro( add_simple_test  name )
  add_executable( ${name}_test ${name}_test.cpp )
  add_test( ${name} ${name}_test ) 
endmacro( add_simple_test  name )


add_simple_test( affix )
