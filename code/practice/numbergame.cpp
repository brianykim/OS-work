#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <fstream>

using namespace std;

int main()
{
	ifstream ifile("input.txt");
	ofstream ofile("numgameoutput.txt");
	int cases;
	ifile>>cases;
	for(int i=0; i<cases; i++)
	{
		int aone, atwo, bone,btwo;
		ifile>>aone>>atwo;
		ifile>>bone>>btwo;
		int count=0;
		for(int j=aone;j<=atwo;j++)
		{
			for(int k=bone;k<=btwo;k++)
			{
				//j is A and k is B
				int x=j;
				int y=k;
				if((x==1||y==1)&&!(x==1&&y==1))
				{
					count++;
				}
				else
				{
					if(x>y)
					{
						if(x%y<=y&&x%y!=0)
						{
							x=x%y;
							if(x>y)
							{
								if(x%y==0)
								{
									count++;
								}
							}
							else
							{
								if(y%x==0)
								{
									count++;
								}
							}
						}
					}
					else
					{
						if(y%x<=x&&y%x!=0)
						{
							y=y%x;
							if(x>y)
							{
								if(x%y==0)
								{
									count++;
								}
							}
							else
							{
								if(y%x==0)
								{
									count++;
								}
							}
						}
					}
				}

			}
		}
		ofile<<"Case #"<<i+1<<": "<<count<<endl;
	}

}