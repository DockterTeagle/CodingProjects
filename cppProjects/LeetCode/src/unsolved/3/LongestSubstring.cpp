#include "3/LongestSubstring.hpp"

#include <unordered_map>

using std::string, std::unordered_map;
int Solution::lengthOfLongestSubstring() {
  int greatestLen = 0;
  int start = 0;  // Left pointer of the sliding window

  // This map stores the last index of each character encountered
  std::unordered_map<char, int> seen;

  for (int end = 0; end < s.size();
       ++end) {  // Right pointer of the sliding window
    char currentChar = s[end];

    // If currentChar was seen before and its index is >= start, move start to
    // skip the duplicate
    if (seen.find(currentChar) != seen.end() && seen[currentChar] >= start) {
      start = seen[currentChar] + 1;
    }

    // Update the last seen index of the current character
    seen[currentChar] = end;

    // Calculate the current length of the substring and update greatestLen
    greatestLen = std::max(greatestLen, end - start + 1);
  }

  return greatestLen;
}
int main() {
  Solution soln("hello");
  std::cout << soln.lengthOfLongestSubstring();
  return 0;
}
