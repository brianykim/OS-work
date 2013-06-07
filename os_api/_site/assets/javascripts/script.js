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
  	/*
  	var urlname = $(document).URL;
	$(document).ready(function(){
  	if (urlname=="http://localhost:4000/platform/")
  	{
  		$(".posts").slideDown("slow");
  	}   	
  	    });
       */
      
			/*if(clicked=="link")
			{
				var sibs = origEl.siblings();
        for(var j=0; j<sibs.length; j++)
          {
            if(sibs[j].tagName=="UL")
            {
              sibs[j].className="clickedul";  
              break;
            }
			}
      var elems = getElementsByClassName("posts");
			for(var i=0; i<elems.length; i++)
			{
				if(elems[i]!=origEl)
				{
					elems[i].className="posts";
					
				
					}
				}
			}
    */

   // $("#accordion").accordion({collapsible:true});
      /*   
     $(document).ready( function(){
      $("body").css("color","red");
      });
		*/

      
      function getEl(){
      var ev = arguments[0] || window.event;
      origEl = ev.target || ev.srcElement;
      //alert(origEl.tagName);
      if(origEl.id=="unclicked")
      {
        origEl.id="clicked";
        var uls = document.getElementsByName("giveitashot");
        for(var i=0; i<uls.length; i++)
        {
          if(uls[i].parent.id==clicked)
          {

            break;
          }
        }
        uls[0].setAttribute("id","clickedul");
        alert(uls[0].id);
        /*for(var i=0; i<sibs.length; i++)
        {
          if(sibs[i].id=="posts")
          {
            sibs[i].id="clickedul";
            
            alert(getElementById("clickedul"));
            break;
          }

        }
        //YOU HAVE TO CHANGE THE SIBLING.... UL IS NOT A CHILD OF ORIGEL THE LINK.... *SIGH* BRIAN...
    
          origEl.id="clicked";
          var e = document.getElementById("clicked");
          alert(e.id);*/
      }
      

    }
document.onclick = getEl;
/*
  	$(document).ready(function(){
  	    $(".link").click(function(e){
  	    	
  	    	e.preventDefault();
  	  
  	    	$(".posts").slideDown("slow");
  	    	if(e.isDefaultPrevented())
  	    	{
  	    		e.trigger();
  	    	}
  	    });
  		                    
    });       */
	
    //document.getElementByID("someID").className = "asdf"; 
    //name.id="fruit"; alert(document.URL);

           	 