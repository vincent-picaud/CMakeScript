#include <project_A/doSomething_A.hpp>
#include <project_B/doSomething_B.hpp>

std::string doSomething_B() { return "I am project B and I use " + doSomething_A(); };
