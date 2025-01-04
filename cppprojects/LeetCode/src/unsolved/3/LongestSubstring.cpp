// #include "LongestSubstring.hpp"
// using std::string, std::vector, std::set;
// class Solution {
//  public:
//   /*
//    *prompt:Given a string s, find the length of the longest
//   substring without repeating characters.
//   */
//   int lengthOfLongestSubstring(string const &s) {
//     vector<string> substrings;
//     string substring = "";
//     bool flag  // flag to tell if repeated or not
//         = false;
//     for (std::size_t i = 0; i < s.size();
//          ++i) {  // iterate over the entire string
//       char currentChar = s.at(i);
//       string ssubstring  // substring to check if unique if unique delete and
//                          // set substring equal to this
//           = substring;
//       ssubstring.append(1, currentChar);
//     }
//   }
//
//  private:
//   void logicCheck(bool const &flag, string *substring, const string
//   &ssubstring,
//                   vector<string> *substrings) {
//     if (!uniqueCharacters(ssubstring)) {
//       substrings->push_back(*substring);
//       *substring = "";
//     } else {
//       *substring = ssubstring;
//     }
//   }
//   bool uniqueCharacters(string const &str) {
//     set<char> char_set;
//     for (char c : str) {
//       char_set.insert(c);
//     }
//
//     return char_set.size() == str.size();
//   }
// };
// int main() { string first = "hello"; }
