#include "configure.h"
#include "sum.h"
#include <iostream>

#ifdef HAS_POW
#include <math.h>
#endif

int main() {
  // Configure File
#ifdef HAS_HELLO_WORLD
  std::cout << HELLO_WORLD  << std::endl;
#endif

  // Try compile
#ifdef HAS_POW
  std::cout << "10 ^ 2 = " << pow(10, 2) << std::endl;
#endif

  // Lib: sum
  std::cout << "1 + 2 = " << sum::sum(1, 2) << std::endl;
}
