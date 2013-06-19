#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <vector>

using namespace std;

class Contain
{
public:
	Contain();
	~Contain();
	vector<string> methods;
	string name;
	void setName(string nam);
};

Contain::Contain()
{
	name="";
}
Contain::~Contain()
{

}
void Contain::setName(string nam)
{
	name=nam;
}