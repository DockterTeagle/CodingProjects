#ifndef CPPPROJECTS_LEETCODE_SOLVED_2_SOLVED_ADDTWONUMBERS_H_
#define CPPPROJECTS_LEETCODE_SOLVED_2_SOLVED_ADDTWONUMBERS_H_

struct ListNode {
  int val;
  ListNode *next;
  ListNode() : val(0), next(nullptr) {}
  ListNode(int x) : val(x), next(nullptr) {}
  ListNode(int x, ListNode *next) : val(x), next(next) {}
};
#endif  // CPPPROJECTS_LEETCODE_SOLVED_2_SOLVED_ADDTWONUMBERS_H_
