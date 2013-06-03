  	/*function showClasses(elid){
  		if(elid.className="link")
  		{
  			elid.className="clickedlink";
  			document.getElementById("classes").slideDown("slow");
  		}
  		else
  		{
  			return;
  		}
  	}*/
  	
  	$(document).ready(function(){
  	    $(".link").click(function(e){

  	    	e.preventDefault();
  	    	$(".posts").slideDown("slow");
  	    	
  	    });
  		                    
    });       
	
    //document.getElementByID("someID").className = "asdf"; 
    //name.id="fruit"; alert(document.URL);

           	 