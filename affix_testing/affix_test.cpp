//
// ... Standard header files
//
#include <vector>
#include <iostream>
#include <sstream>

//
// ... Affix header files
//
#include <affix/affix.hpp>

//
// ... Testing header files
//
#include <affix_testing/test_macros.hpp>


/** A simple test of basic functionality*/
struct SimpleTest
{
  SimpleTest() : accum( 0 ) {
    test1();
    test2();
  }

  void
  test1()
  {
    using affix::affix_iterator;
    using std::stringstream;
    using std::vector;
    using std::copy;

    vector<int> xs = {1, 2, 3, 4};
    stringstream ss;
    copy( begin( xs ), end( xs ), affix_iterator<int>( ss, "{", ",", "}" ));
    AI_TEST( accum, ss.str() == "{1,2,3,4}");

  }

  void
  test2()
  {
    constexpr static size_t n = 10;
    using affix::affix_iterator;
    using std::stringstream;
    using std::copy;

    float xs[ n ] = {0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f, 9.0f};
    stringstream ss;
    copy( &xs[0], &xs[0]+n, affix_iterator<float>( ss, "(", " ", ")" ));
    AI_TEST( accum, ss.str() == "(0 1 2 3 4 5 6 7 8 9)" )
      
    
  }
  operator int() const { return accum; }
  int accum;
}; // end of struct SimpleTest




int
main( int, char** ){
  int accum = 0;
  accum += SimpleTest();
  return accum;
}
