#include <cstdlib>
#include <cstdio>
#include <fstream>
#include <iostream>
#include <string>
#include <cstring>

int main(int argc, char* argv[])
{
	if(argc!=2||!(strstr(argv[1],".rb")))
	{
		std::cout<<"Please include one Ruby file name please"<<std::endl;
	}
	else
	{
		int leng = strlen(argv[1]);
		std::string str(argv[1]);
		str=str.substr(0,leng-3);//BEWARE, BECAUSE HERE THE FILE SEEMS TO MESS UP IF YOU HAVE .RBSOMETTHINGELSEATTACHED... as a file extension
		str.append(".md");
		ifstream ifile(argv[1]);
		const char *out = str.c_str();
		std::ofstream ofile(out);
		char* line[1000];
		
		while(ifile.getline(line,1000))	
		{
			
			
			if(strstr(line,"#/"))
			{
				std::string aline(line);
				aline=aline.substr(2,strlen(line));
				ofile<<aline<<endl;
			}
			else
			{
				ofile<<line<<endl;
			}
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