#include <cstdlib>
#include <cstdio>
#include <fstream>
#include <iostream>
#include <string>
#include <cstring>
#include <sstream>
#include <cmath>
#include <dirent.h>
#include "classcontainer.cpp"
#include <vector>

using namespace std;


int main(int argc, char* argv[])
{
	//THE OUTPUT FILE IS THE NAME OF THE CLASS....
	//const char *out = ();
	if(argc!=2)
	{
		std::cout<<"Please include a directory name."<<std::endl;
	}
	else
	{
		ofstream ofile("newoutput.txt");
		////////////////////////////////YAML Data Structures/Generation///////////////////////////
		//at the end write to file in beginning, then rewrite all file bodies to something else?
		//these lines below go outside before the directory is traversed,
		vector<Contain> classes;
		
		//these lines go inside of the while loop for each file;
		//Contain x;
		//x.name=classname;
		//x.methods.add(method_name)
		//classes.add(x)
		//classes.methods.add(method name)

		////////////////////////////////DIRECTORY TRAVERSING//////////////////////////////////////
		char dirname[100];
		memcpy(dirname,argv[1],100);//~/api/lib/platform/resources

		struct dirent *dirt=NULL;
		DIR *dir=opendir(dirname);
		if(dir)
		{
			while(dirt=readdir(dir))
			{
				if(strstr(dirt->d_name,".rb")&&!strstr(dirt->d_name,".rb~"))
				{
					char filename[100];
					strcpy(filename,dirname);
					strcat(filename,"/");
					strcat(filename,dirt->d_name);
					ifstream ifile(filename);
					bool method;
					int check=0;
					string hello="";
					
					/////////////////////////////////////INDIVIDUAL FILE PARSING//////////////////////////
					/*if(argc!=2||!(strstr(argv[1],".rb\0")))
					{
						std::cout<<"Please include one Ruby file name please"<<std::endl;
					}
					else
					{
					int leng = strlen(argv[1]);
					std::string str(argv[1]);
					str=str.substr(0,leng-3);
					str.append(".markdown");
					std::ifstream ifile(argv[1]);*/
					
					char line[1000];
					if(ifile.good())
					{
						Contain x;
						bool block=false;
						
						while(ifile.getline(line,1000))	
						{
							if(block)
							{
								if(strstr(line,"name: "))
								{
									char *namaste = strstr(line,"name: ");
									string name(namaste);
									char* waste = strstr(line,";");
									name=name.substr(6,name.length()-6-strlen(waste));
									x.methods.push_back(name);
								}
								if(strstr(line,"=end")&&!strstr(line," =end"))
								{
									block=false;
								}
								else
								{
									ofile<<line<<endl;
								}
							}
							if(strstr(line,"=begin")&&!strstr(line," =begin"))
							{
									block=true;
							}
							else if(strstr(line,"#{% "))
							{
								std::string aline(line);
								//find the position of the # and delete it
								int pound = aline.find("#");
								aline.erase(pound,1);
								//aline=aline.substr(1,strlen(line));
								
								if(strstr(line,"{% method "))//MOVE THIS BLOCK TO =BEGIN AND =END FINDER OF A /* AND */ FINDER
								{
									//MUST PARSE METHOD TAG FOR THE NAME, the word after the name: 
									
									
									//need a method that will return start position of the , descr so that we can substring it from there... and not form length - 6
									//UNTIL THE SPACE OF THE NEXT WORD AFTER THE ONE YOU'RE LOOKING FOR, USING %} OR DESCRIPTION
								}
								else if(strstr(line,"{% resource "))
									{
										char *result = strstr(line,"resource ");
										string resource(result);
										resource=resource.substr(9,resource.length()-12);
										

										//IN THIS CASE, WE NEED TO SUBSTRING AT THE POITN OF THE " %}"
										x.name=resource;
								
									}
								ofile<<aline<<std::endl;
							}
							//initialized a string version of line to be used
							/*else if(((strstr(line,"  if "))||strstr(line,"  while ")||strstr(line,"  for ")||strstr(line,"  until ")||strstr(line," begin ")||strstr(line," case ")||strstr(line,"each do"))&&!(strstr(line,"#")))
								{
									//HOW TO MAKE SURE THAT THE STUPID IF IS AT THE VERY BEGINNING OF THE LINE
									check++;
									ofile<<line<<endl;
								}
								else if(strstr(line,"end")&&method&&!strstr(line,"#"))
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
									else if((strstr(line,"get ")&&strstr(line,"do"))||(strstr(line,"put ")&&strstr(line,"do"))||(strstr(line,"post ")&&strstr(line,"do"))||(strstr(line,"delete ")&&strstr(line,"do")))
										{
											//NEED TO PARSE THIS LINE TO GET THE METHOD NAME
											/*for(int i=0;i<strlen(line)-2;i++)
											{
												if(line[i]==' '&&line[i+1]=='d'&&line[i+2]=='o')
												{
													string mname(line);
													mname=mname.substr(0,i);
													mname=mname.substr(6,mname.length()-6);
													//trim(mname);
													x.methods.push_back(mname);
												}
											}
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
										}*/
										else if(strstr(line,"#")&&!strstr(line,"#{%"))
											{
												ofile<<"{% comment %}"<<endl;
												ofile<<line<<endl;
												ofile<<"{% endcomment %}"<<endl;
											}
											/*else if(strstr(line,"class"))
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
														x.name=hello;
														//hello=stringent.substr(a+2,b);
														//FIND INSTANCE OF FIRST SPACE AND 2ND SPACE, AND GET THE WORD IN BETWEEN THOSE TWO?
														//int a,b;
														//strchr
														
														//HERE GET ONLY THE RESOURCE WORD OUT OF THIS
														ofile<<line<<endl;
														ofile<<"{% endresource %}"<<endl;
													}*/
													//else if(strstr(line,"class"))
													else
													{
														//ofile<<line<<std::endl;
													}
								
						}
						classes.push_back(x);					
					}

					/*else
					{
						std::cout<<"File does not exist"<<std::endl;
					}*/
				}
				if(strstr(dirt->d_name,".js")||strstr(dirt->d_name,".java")||strstr(dirt->d_name,".cpp"))
				{
					char filename[100];
					strcpy(filename,dirname);
					strcat(filename,dirt->d_name);
					ifstream ifile(filename);
					bool method;
					int check=0;
					string hello="";
					char line[1000];
					if(ifile.good())
					{
						Contain x;

						while(ifile.getline(line,1000))	
						{
							if(strstr(line,"//{%"))
							{
								std::string aline(line);
								int slashslash = aline.find("//");
								aline.erase(slashslash,2);
								ofile<<aline<<std::endl;
								if(strstr(line,"{% method "))
								{
									//MUST PARSE METHOD TAG FOR THE NAME, the word after the name: 
									
									char *namaste = strstr(line,"name: ");
									string name(namaste);
									
									char* waste = strstr(line,", description");
									name=name.substr(6,name.length()-6-strlen(waste));
									x.methods.push_back(name);
									//need a method that will return start position of the , descr so that we can substring it from there... and not form length - 6
									//UNTIL THE SPACE OF THE NEXT WORD AFTER THE ONE YOU'RE LOOKING FOR, USING %} OR DESCRIPTION
								}
								else if(strstr(line,"{% resource "))
									{
										char *result = strstr(line,"resource ");
										string resource(result);
										resource=resource.substr(9,resource.length()-12);
										

										//IN THIS CASE, WE NEED TO SUBSTRING AT THE POITN OF THE " %}"
										x.name=resource;
								
									}
									else if(strstr(line,"//")&&!strstr(line,"{%"))
											{
												ofile<<"{% comment %}"<<endl;
												ofile<<line<<endl;
												ofile<<"{% endcomment %}"<<endl;
											}
							}
							else
							{
							//	ofile<<line<<std::endl;
							}
						}
					}	
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
			ofstream yamlfile("yamel.txt");
			yamlfile<<"---"<<endl;
			yamlfile<<"layout: post"<<endl;
			yamlfile<<"categories: jekyll update"<<endl;
			yamlfile<<"title: \"";
			string directname(dirname);
			directname=directname.substr(2,strlen(dirname)-2);
			yamlfile<<directname<<"\""<<endl;

			yamlfile<<"resources:"<<endl;
			for(int i=0;i<classes.size();i++)
			{
				yamlfile<<"  -"<<endl;
				yamlfile<<"    methods:"<<endl;
				for(int j=0;j<classes[i].methods.size();j++)
				{
					yamlfile<<"      - "<<classes[i].methods[j]<<endl;
				}
				yamlfile<<"    name: "<<classes[i].name<<endl;
			}
			yamlfile<<"---"<<endl;
			string outname ="2013-6-18-";
			outname+=directname;
			outname+=".markdown";
			ofstream marked(outname.c_str());
			ifstream yfile("yamel.txt");
			char linear[1000];
			while(yfile.good())
			{
				yfile.getline(linear,1000);
				marked<<linear<<endl;
			}
			ifstream outfile("newoutput.txt");
			while(outfile.good())
			{
				outfile.getline(linear,1000);
				marked<<linear<<endl;
			}
		}
		else
		{
			cout<<"DIRECTORY DOES NOT EXIST"<<endl;
		}
		
	}
}
