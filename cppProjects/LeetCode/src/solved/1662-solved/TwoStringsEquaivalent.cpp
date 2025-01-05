#include <cstddef>
#include <string>
#include <vector>
bool arrayStringsAreEqual(std::vector<std::string> &word1,
                          std::vector<std::string> &word2) {
  std::string Word1 = "";
  std::string Word2 = "";
  for (std::size_t i = 0; i < word1.size(); ++i) {
    Word1 += word1.at(i);
  }
  for (std::size_t i = 0; i < word2.size(); ++i) {
    Word2 += word2.at(i);
  }
  if (Word1 == Word2) {
    return true;
  } else {
    return false;
  }
}
