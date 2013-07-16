#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>

using namespace std;

int main()
{
	//from stdin
	int side;

	cin>>side;
	int* x = new int[side*side];
	input them
	for(int i=0; i<side*side;i++)
	{
		cin>>x[i];
	}
	each point should be of a struct, that has both a basin value, if it is a basin value, expand around itbasin value, will keep going out, by the largest you need to check the immediate neighbor and see if the neighbor it is matches the lowest neighbors
	you're going to have to say hey, these are the sinks, and then keep expanding those around the sinks, and see if the neighbors, and label all those index's with a basin value



	

}
