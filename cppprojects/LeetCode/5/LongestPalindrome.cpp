#include <string>
#include <vector>
using std::string;
class Solution {
public:
  string longestPalindrome(string s) {
    string currentString;
    // start by checking if the whole word is a palindrome then half it anc
    // check boundar
    for (std::size_t i = 0; i < s.size(); ++i) {
      // dumb idea each time we add a character determine if it is a palindrome
      // once it no longer is store it in an array(hashmap with its length if i
      // had that)
    }
  }

private:
  string data;
  bool isPalndrome(string &s, string &scopy) {
    for (std::size_t i = 0; i < scopy.length(); ++i) {
      std::swap(scopy[i], scopy[s.length() - i - 1]);
    } //     if (scopy == s)
    return true;
  }
  string reverseString(string s) {
    string reversedString;
    for (int i = s.size(); i > -1; --i) {
      reversedString.at(s.size() - i) = s.at(i);
    }
  }
};
class Palindrome {
public:
  string content;
  std::size_t length;

  Palindrome(string content, std::size_t length)
      : content(content), length(length) {}
};
int main() { Palindrome helo("hello", 0); }
