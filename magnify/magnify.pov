// Magnifying Glass

#include "colors.inc" 
#include "textures.inc"    
#include "glass.inc"
                                                
background { color Cyan }

camera 
{
    location <0, 0.5, -2>
    look_at  <0, 0,  0>
} 

                 
light_source { <20, 40, -30> color White }
 
plane 
{ 
    <0, 1, 0>, -1.2
    pigment{ checker color Red, color Blue }
}


#declare lens=difference   // Create a lens
{  
 sphere{<0.0, 0.0, 0.0>, 1.22}    
 box{<-1.5,-1.5,-1.1>,< 1.5,1.5,1.5>}   
 pigment{ rgbf <1.0,1.0,1.0,0.95> }   
 finish{phong 0.9 phong_size 10 reflection 0.1}   
 interior{ior 1.5} 
 
 translate<0.25,0,1.1>  
}      
 
#declare mount=union       // Create a mount for the lens
{
 torus{0.5, 0.08 rotate<90,0,90>}
 cylinder{<-0.8,-0.8,0>,<-0.35,-0.35,0>, 0.08}           
 pigment{Brown_Agate}
 translate<0.25,0.0,0>  
}
  

cylinder                   // Object behind the magnifying glass
{ 
   <clock, 0, 0.5>, <clock, 0.8, 0.5>,0.2 
   pigment { color Green }
}

  
object{lens}
object{mount}
