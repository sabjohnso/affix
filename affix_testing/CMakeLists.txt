macro( add_simple_test  name )
  add_executable( ${name}_test ${name}_test.cpp )
  target_link_libraries( ${name}_test PRIVATE affix::affix )
  add_test( ${name} ${name}_test ) 
endmacro( add_simple_test  name )


add_simple_test( affix )
