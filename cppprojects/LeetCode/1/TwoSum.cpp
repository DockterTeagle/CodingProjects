#include<vector>
using std::vector,std::size_t;
class Solution{
  public:
    vector<int> twoSum(std::vector<int>num,int target){
      
      vector<int> nums1 = num;
      vector<int> solution;
      for(std::size_t i = 0; i< num.size();++i){
        for(std::size_t j = 0 ; j<num.size();++j){
          if(num.at(i)+nums1.at(j)==target){
            solution={num.at(i),nums1.at(j)};
            return solution;
          }
        }
      }
      return solution;
    }
    Solution(vector<int>numsToSet):data(numsToSet){}
    Solution():data{0,0}{
      
    }
  private:
    vector<int> data;

};
int main(){
  Solution Answer;

}
