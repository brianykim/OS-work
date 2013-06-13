#include <cstdlib>
#include <cstdio>
#include <fstream>
#include <iostream>
#include <string>
#include <cstring>
#include <sstream>

using namespace std;

int main(int argc, char* argv[])
{
	bool method;
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
				
				if((strstr(line,"get \"")&&strstr(line,"do"))||(strstr(line,"put \"")&&strstr(line,"do")))
				{
					ofile<<"{% method %}"<<endl;
					ofile<<line<<endl;
					method=true;
				}
				else if(strstr(line,"end")&&method)
					{	
						ofile<<line<<endl;
						ofile<<"{% endmethod %}"<<endl;
						method=false;
					}
					else if(strstr(line,"#{"))
						{
							std::string aline(line);
							aline=aline.substr(1,strlen(line));
						/*	stringstream ss;
							ss<<aline.substr(1,strlen(line)-1);
							string tagName;
							ss>>tagName;
							if(tagName=="class_name")
							{
								ofile<<"<div
							}
						*/
							//HERE TRY A STRING STREAM TO CHECK IF THE FIRST WORD IS THE NAME OF A TAG YOU RECOGNIZE, just lots of if statements for each one??? O_O
							
							ofile<<aline<<std::endl;
						}
						else if(strstr(line,"#")&&!strstr(line,"{%"))
							{
								ofile<<"{% comment %}"<<endl;
								ofile<<line<<endl;
								ofile<<"{% endcomment %}"<<endl;
							}
							else if(strstr(line,"class"))
								{
									ofile<<"{% class_name %}"<<endl;
									ofile<<line<<endl;
									ofile<<"{% endclass_name %}"<<endl;
								}
								else if(strstr(line,"resource"))
									{
										ofile<<"{% resource %}"<<endl;
										ofile<<line<<endl;
										ofile<<"{% endresource %}"<<endl;
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
//maybe if {class name then, write to file a certain way, make the custom tags in the parser.... just easier that way for me lol
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
