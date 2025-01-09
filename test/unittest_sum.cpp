//
// Created by ByteDance on 25-1-9.
//
#include <catch2/catch_test_macros.hpp>

TEST_CASE("sum 1 + 1", "[sum]") {
    // cppcheck-suppress unreadVariable
    const auto sum1 = 1 + 1;
    REQUIRE(sum1 == 2);
}
