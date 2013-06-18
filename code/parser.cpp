#include <cstdlib>
#include <cstdio>
#include <fstream>
#include <iostream>
#include <string>
#include <cstring>
#include <sstream>
#include <cmath>
#include <dirent.h>

using namespace std;


int main(int argc, char* argv[])
{
	//
	char diren[100];
	DIR *dir = NULL;
	struct dirent *dirt=NULL;
	dir=opendir("~/api/lib/platform/resources");
	if(dir)
	{
		
	}
		bool method;
		int check=0;
		string hello="";
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
					
					//initialized a string version of line to be used
					if((strstr(line,"get \"")&&strstr(line,"do"))||(strstr(line,"put \"")&&strstr(line,"do")))
					{
						if(hello!="")
						{
							ofile<<"{% method "<<hello<<" %}"<<endl;
						}
						else
						{
							ofile<<"{% method %}"<<endl;
						}
						ofile<<line<<endl;
						method=true;
					}
					else if(((strstr(line,"  if "))||strstr(line,"each do"))&&!(strstr(line,"#")))
						{
							//HOW TO MAKE SURE THAT THE STUPID IF IS AT THE VERY BEGINNING OF THE LINE
							check++;
							ofile<<line<<endl;
						}
						else if(strstr(line,"end")&&method)
							{	
								//USED TO CLOSE LOOPS, IF,ELSE, WHILES, FORS... huh, I'll think of a more cleve rsooultion later
								if(check==0)
								{
									ofile<<line<<endl;
									ofile<<"{% endmethod %}"<<endl;
									method=false;
								}
								//in the case that there is an if statememt or else or a loop... anything that could end in end...
								else
								{
									ofile<<line<<endl;
									check--;
								}
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
												//string stringent(line);
												
												ofile<<"{% resource %}"<<endl;
												int a,b;
												int count=0;
												for(int i=0;i<strlen(line);i++)
												{
													if(isspace(line[i]))
													{
														count++;
														if(count==5)
														{
															a=i;
														}
														if(count==6)
														{
															b=i;
														}
													}
												}

												string stringent(line);
												hello=stringent.substr(a+2,b-a-2);
												
												//hello=stringent.substr(a+2,b);
												//FIND INSTANCE OF FIRST SPACE AND 2ND SPACE, AND GET THE WORD IN BETWEEN THOSE TWO?
												//int a,b;
												//strchr
												
												//HERE GET ONLY THE RESOURCE WORD OUT OF THIS
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
