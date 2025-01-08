#include <iostream>
#include "inc/version.h"

int main() {
    std::cout << buildinfo::version << std::endl;
    return 0;
}
