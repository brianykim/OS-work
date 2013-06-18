#include <cstdlib>
#include <iostream>
#include <cstdio>
#include <cstring>
#include <cmath>
#include <dirent.h>
#include <fstream>

using namespace std;

int main(int argc, char *argv[])
{
	char dirname[50];
	DIR *dir = NULL;
	struct dirent *dirt = NULL;
	dir=opendir("./plats/");
	if(dir)
	{
		while(dirt=readdir(dir))
		{
			if(strstr(dirt->d_name,".rb"))
			{
				
				ifstream ifile("./plats/testaccounts.rb");
				if(ifile.good())
				{
					char x[100];
					ifile.getline(x,100);
					cout<<x<<endl;
				}
				//open it and...... ATTACK IT
				cout<<dirt->d_name<<endl;
			}

		}
		closedir(dir);
	}
	else
	{
		cout<<"Can't open"<<endl;
	}
	return 0;

}
	/*cout<<"Please enter 3 numbers"<<endl;
	int a,b,c;
	cin>>a;
	cin>>b;
	cin>>c;

	int i=0;
	while(i<3)	
	{
		if(pow(a,2)+pow(b,2)==pow(c,2))
		{
			cout<<"VALID"<<endl;
			return 0;
		}
		else
		{
			int x = a;
			a=b;
			b=c;
			c=x;
		}
		i++;
	}
}*/
/*	

	cout<<"Does this compile?"<<endl;
	for(int i=0; i<100;i++)
	{
		if(i%3==0)
		{
			cout<<"Fizz";
			if(i%5==0)
			{
				cout<<"Buzz";
			}
			cout<<endl;
		}
		else
		{
			if(i%5==0)
			{
				cout<<"Buzz"<<endl;
			}
		}
	}

}*/