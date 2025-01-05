#ifndef LEETCODE_INCLUDE_3_LONGESTSUBSTRING_HPP_
#define LEETCODE_INCLUDE_3_LONGESTSUBSTRING_HPP_
#include <iostream>
#include <set>
#include <string>
#include <vector>
/*
 *prompt:Given a string s, find the length of the longest
substring without repeating characters.
*/
class Solution {
 public:
  /*
   *prompt:Given a string s, find the length of the longest
  substring without repeating characters.
  */
  explicit Solution(const std::string &s) : s(s) {}
  int lengthOfLongestSubstring();

 private:
  std::string s;
};
#endif  // LEETCODE_INCLUDE_3_LONGESTSUBSTRING_HPP_
