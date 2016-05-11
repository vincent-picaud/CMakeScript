#include <gtest/gtest.h>

#include <project_B/doSomething_B.hpp>

TEST(check_B, doSomething_B) { EXPECT_FALSE(doSomething_B().empty()); }
