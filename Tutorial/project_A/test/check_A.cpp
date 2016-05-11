#include <gtest/gtest.h>

#include <project_A/doSomething_A.hpp>

TEST(check_A, doSomething_A) { EXPECT_FALSE(doSomething_A().empty()); }
