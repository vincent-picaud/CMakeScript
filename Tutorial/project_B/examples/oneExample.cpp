#include <project_A/doSomething_A.hpp>
#include <project_B/doSomething_B.hpp>

#include <iostream>

int main()
{
    std::cout << "\n" << doSomething_A();
    std::cout << "\n" << doSomething_B();
    return EXIT_SUCCESS;
}
