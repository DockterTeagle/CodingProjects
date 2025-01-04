#include <string>
#include <unordered_map>
#include <vector>
using std::string, std::vector;
struct Customer {
  int id;
  string location;
  int checkinTime;
};
struct StationLine {
  string startStation;
  string endStation;
  vector<int> times;
};
class UndergroundSystem {
  std::unordered_map<int, Customer> customers;
  vector<StationLine> lines;

 public:
  void checkIn(int id, string stationName, int t) {
    Customer newCustomer;
    newCustomer.location = stationName;
    newCustomer.id = id;
    newCustomer.checkinTime = t;
    customers[id] = newCustomer;
  }

  void checkOut(int id, string stationName, int t) {
    auto it = customers.find(id);
    if (it != customers.end()) {
      StationLine completedLine;
      completedLine.startStation = it->second.location;
      completedLine.endStation = stationName;
      completedLine.times.push_back(t - it->second.checkinTime);
      lines.push_back(completedLine);
      customers.erase(it);
    }
  }

  double getAverageTime(string startStation, string endStation) {
    double totalTime = 0.0;
    std::size_t count = 0;
    for (int i = 0; i < lines.size(); ++i) {
      if (lines.at(i).startStation == startStation &&
          lines.at(i).endStation == endStation) {
        for (int j = 0; j < lines.at(i).times.size(); ++j) {
          totalTime += lines.at(i).times.at(j);
          count++;
        }
      }
    }
    if (count > 0) {
      return totalTime / count;
    } else {
      return 0.0;
    }
  }
};
