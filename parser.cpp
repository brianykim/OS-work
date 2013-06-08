#include <cstdlib>
#include <cstdio>
#include <fstream>
#include <iostream>
#include <string>
#include <cstring>

using namespace std;

int main(int argc, char* argv[])
{
	if(argc!=2||!(strstr(argv[1],".rb\0")))
	{
		std::cout<<"Please include one Ruby file name please"<<std::endl;
	}
	else
	{
		int leng = strlen(argv[1]);
		std::string str(argv[1]);
		str=str.substr(0,leng-3);
		str.append(".markdown");
		std::ifstream ifile(argv[1]);
		const char *out = str.c_str();
		std::ofstream ofile(out);
		char line[1000];
		if(ifile.good())
		{
			
			while(ifile.getline(line,1000))	
			{
				
				
				if(strstr(line,"#{"))
				{
					std::string aline(line);
					aline=aline.substr(1,strlen(line));
					ofile<<aline<<std::endl;
				}
				else
				{
					ofile<<line<<std::endl;
				}
			}
		}
		else
		{
			std::cout<<"File does not exist"<<std::endl;
		}
		//IFILE.GETLINE(LINE,1000);
		/*IF(STRSTR(LINE.SUBSTR(0,2),"#/"))
		{
			LINE=LINE.SUBSTR(2,LINE.LENGTH)
			THEN OFILE<<LINE<<ENDL;
			on to the next on on to the next one
		}
		*/
	}	
}