#include "configure.h"
#include <iostream>

int main() {
#ifdef HAS_HELLO_WORLD
  std::cout << HELLO_WORLD << std::endl;
#endif
}
