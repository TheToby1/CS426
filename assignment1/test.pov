#include "functions.inc"
#include "textures.inc"
#include "colors.inc" 

global_settings { assumed_gamma 1.0 }

light_source{<1500,2500,-2500> color White}

#declare HF_Res_X = 1024; // number of points in x
#declare HF_Res_Z = 1024; // number of points in z
#declare SF =
 function {
   pigment {
   spherical
     color_map {
       [0.0, color 0.0 ]
       [0.5, color 0.8 ]
       [1.0, color 1.0 ]
     } // end color_map
    scale <0.5,1,0.5>
    translate<0.5,0,0.5>
   } // end pigment
 } // end function

#declare HF_Function   =
 function(x, y, z)
  {1+f_snoise3d(x*10,y*10,z*10)*0.3 * SF(x,y,z).gray}

#declare HF_Amplitude    = 0.5;
#declare D = 0.00001; // just a little bit!

union{ // height_field + ground
 intersection{
  height_field{
   function  HF_Res_X, HF_Res_Z
   { HF_Function(x,0,y) * HF_Amplitude }
   //smooth
    translate<0,D-0.4 ,0>
   } // end HF
  box{ <D,-0.10,D>,<1-D,0.2-D,1-D>
   } // end box
  translate<0,-0.10,0>
 } // end intersection

difference{ // ground minus hole for height_field
 plane { <0,1,0>, 0 }   // plane of the ground
 box{ <D,-0.10,D>,<1-D,0.2-D,1-D> }
 } // end difference

 scale <1,1,1>
 translate<0,0,0>
 texture { pigment{ color rgb<1,0.95,0.8>}
           normal { bumps 0.75 scale 0.0025 }
           finish { phong 0.1 }
         }// end texture


}// end of  height_field + ground ------------- 


