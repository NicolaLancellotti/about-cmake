#include <iostream>
#ifdef HAS_POW
#include <math.h>
#endif

int main() {
#ifdef HAS_POW
  std::cout << "10 ^ 2 = " << pow(10, 2) << std::endl;
#endif
}
