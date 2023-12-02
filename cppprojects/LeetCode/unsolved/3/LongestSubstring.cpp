/*
prompt:Given a string s, find the length of the longest
substring
without repeating characters.
Example 1:

Input: s = "abcabcbb"
Output: 3
Explanation: The answer is "abc", with the length of 3.
Example 2:

Input: s = "bbbbb"
Output: 1
Explanation: The answer is "b", with the length of 1.
Example 3:

Input: s = "pwwkew"
Output: 3
Explanation: The answer is "wke", with the length of 3.
Notice that the answer must be a substring, "pwke" is a subsequence and not
a substring.
*/
#include <iostream>
#include <string>
#include <vector>
using std::string, std::vector;
class Solution {
public:
private:
  string s;
};
int lengthOfLongetSubstring(string s) {
  vector<string> substrings;
  std::size_t startOfSubstringIndex = 0;
  string substring = "";
  bool flag = false;
  while (startOfSubstringIndex < s.size()) {
    for (std::size_t i; i < s.length(); ++i) {
      if (s.at(i) == s.at(startOfSubstringIndex)) {
        flag = true;
        break;
      }
      substring.push_back(s.at(i));
    }
    if (flag) {
      ++startOfSubstringIndex;
      substrings.push_back(substring);
      substring.clear();
      flag = false;
    }
  }
  string longest = substrings.at(0);
  for (std::size_t i = 1; i < substrings.size(); ++i) {
    if (substrings.at(i).length() > longest.length()) {
      longest = substrings.at(i);
    }
  }
  return longest.length();
}
int main() {
  string first = "hello";
  std::cout << first;
  std::cout << first;
}
