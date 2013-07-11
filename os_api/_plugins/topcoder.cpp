#include <iostream>
#include <cstdlib>
#include <cstdio>
#include <cmath>
#include <vector>
#include <fstream>
using namespace std;
int main()
{
	ifstream ifile("input.txt");
	get input length 
	get position of first 1 and last 1 and flip between inclusive
	cout<<"Please enter a string of 1's and 0's"<<endl;
	string bits;
	cin>>bits;
	int a=-1;
	int b=-1;
	int count=0;
	while(count!=bits.length)
	{
		count=0;
		for(int i=0; i<bits.length; i++)
		{

			if(bits.substr(i,i+1)=="0")
			{
				count++;
			}
			else
			{
				if(a==-1)
				{
					a=i;
				}
				if(a!=-1)
				{
					b=i;
				}
			}
		}
		//flip from a to b if b!=-1
	}	
}