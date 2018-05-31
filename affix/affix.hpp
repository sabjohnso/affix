#ifndef AFFIX_HPP_INCLUDED_1341204327855951463
#define AFFIX_HPP_INCLUDED_1341204327855951463 1

//
// ... Standard header files
//
#include <iostream>
#include <iterator>
#include <memory>





namespace affix
{
  /** Sequentially, write data to a std::basic_ostream object.
   * The affix_iterator class is intended to be an improvement
   * to standard ostream iterator class, where a prefix, suffix
   * and infix strings are specified.
   */
  template<
    typename T,
    typename CharT = char,
    typename Traits = std::char_traits<CharT>
    >
  class affix_iterator{
  public:

    using value_type = T;
    using const_reference = const value_type&;

    using stream_type = std::basic_ostream<CharT,Traits>;
    using string_type = std::basic_string<CharT,Traits>;

    affix_iterator( stream_type& stream,
		    const string_type& prefix,
		    const string_type& infix,
		    const string_type& suffix )
      : ptr( new kernel( stream, prefix, infix, suffix ))
    {}

    affix_iterator&
    operator ++(){ return *this; }

    affix_iterator&
    operator ++( int ){ return *this; }

    affix_iterator&
    operator *(){ return *this; }


    affix_iterator&
    operator =( const T& x ){
      ptr->write( x );
      return *this;
    }
     
  private:
    
    struct kernel
    {
      kernel( stream_type& stream, string_type prefix, string_type infix, string_type suffix )
	: stream( stream )
	, infix( infix )
	, suffix( suffix )
	, active( false )
      {
	stream << prefix;
      }
      
      void
      write( const_reference x )
      {
	if( ! active ){
	  stream << x;
	  active = true;
	}
	else
	{
	  stream << infix << x;
	}
      };
      
      stream_type& stream;
      string_type infix;
      string_type suffix;
      bool active;

      ~kernel(){ stream << suffix; }


    }; // end of struct kernel

    std::shared_ptr<kernel> ptr;

  }; // end of class affix_iterator



  
} // end of namespace nstd

namespace std
{
  template< typename T, typename Char, typename Traits >
  struct iterator_traits<affix::affix_iterator<T,Char,Traits>>
  {
    using value_type = T;
    using difference_type = ssize_t;
    using iterator_category = output_iterator_tag;

  };
}

#endif // !defined AFFIX_HPP_INCLUDED_1341204327855951463
