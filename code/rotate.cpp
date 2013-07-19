#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <fstream>

using namespace std;

int main()
{
	ifstream ifile("A-large-practice.in");
	ofstream ofile("rotateoutput2.txt");
	int cases;
	ifile>>cases;
	for(int i=0; i<cases; i++)
	{
		int side;
		int k;
		ifile>>side;
		ifile>>k;
		bool red=false;
		bool blue=false;
		char* board = new char[side*side]();
		for(int j=0; j<side*side; j++)
		{
			ifile>>board[j];
		}
		//PUSH EVERYTHING AS FAR RIGHT AS YOU CAN..., then check for K in a row
		for(int j=side*side-2;j>=0;j--)
		{
			int check= j;
			while(check%side!=side-1)
			{

				if((board[check]=='B'||board[check]=='R')&&board[check+1]=='.')
				{
					board[check+1]=board[check];
					board[check]='.';
				}
				check++;
			}
		}
		//NOW CHECK for K in a rows
		for(int j=0; j<side;j++)
		{
			for(int l=0;l<side; l++)
			{
				char x = board[j*side+l];
				bool across=true;
				bool down=true;
				bool diagonalone=true;
				bool diagonaltwo=true;
				for(int z=1;z<k;z++)
				{

					int small=j*side+l+z;
					if(small<side*side||l+z<=side)
					{

						if(small%side==0)
						{
							
							across=false;
						}
						else
						{
							if(x!=board[j*side+l+z])
							{
								across=false;
							}
						}
					}
					else
					{
						across=false;
						
					}
					if(j*side+l+side*z>=side*side)
					{
						down=false;
					}
					else
					{
						if(x!=board[j*side+l+side*z])
						{
							down=false;
						}
					}
						
						if(j*side+l+(side-1)*z>=side*side||j*side+l+(side-1)*z%side==side-1)//
						{
							diagonalone=false;
						}
					else
					{	
						if(x!=board[j*side+l+(side-1)*z])
						{
							diagonalone=false;
						}
					}
					
					if(j*side+l+(side+1)*z>=side*side||j*side+l+(side+1)*z%side==side-1)//
					{
						diagonaltwo=false;
						
					}
					else
					{
						if(x!=board[j*side+l+(side+1)*z])
						{
							diagonaltwo=false;
						}
					}
				}
				if(across||down||diagonalone)
				{
					if(x=='B')
					{
						blue=true;
					}
					if(x=='R')
					{
						red=true;
					}
				}

			}
		}
		ofile<<"Case #"<<i+1<<": ";
		if(red&&blue)
		{
			ofile<<"Both"<<endl;
		}
		else
		{
			if(red)
			{
				ofile<<"Red"<<endl;
			}
			else if(blue)
			{
				ofile<<"Blue"<<endl;
			}
			else if(red||blue==false)
			{
				ofile<<"Neither"<<endl;
			}
		}
	}
}4e3