#include "textures.inc"
#include "colors.inc"
#include "glass.inc"
#include "stars.inc"
//avconv -r 10 -i assignment1%02d.png -b:v 1000k test.mov

global_settings { assumed_gamma 1.0 }

camera {angle 30
        location  <0.0 , 1.0 ,-3.0>
        look_at   <-0.5 , 1.0 , 0.0>}

//light_source{<1500,2500,-2500> color White}

sphere{ <0,0,0>,0.4 scale <30,30,30> rotate<0,0,0> translate<-0.5,clock,1000>
        texture{ White_Wood finish{ambient 2}
                 normal{ripples 0.7
                     scale 1.25
                     turbulence 1.5
                     translate< 1.5,0,2>}}
      }

// sky ---------------------------
sphere{<0,0,0>,1 hollow
 texture{
  pigment{gradient <0,1,0>
          color_map{
           [0.0 color rgb<1,0.8,0.6>]
           [0.1 color White]
           [0.3 color rgb<0.1,0.25,0.75>] }
         } // end pigment
  finish {ambient 1 diffuse 0}
  } // end of texture
 scale 10000
 }


// fog -------------
fog { fog_type   2
      distance   1000
      color      color rgb<1,1,0.75>
      fog_offset 0.1
      fog_alt    1.5
      turbulence 1.8
    }

// ground -----------------------------
plane{<0,1,0>, 0  translate<0,-1.5,0>
       texture{pigment{color LightWood*0.5}
               normal {bumps 0.25
                       scale 0.05}
               finish {ambient 0
                       diffuse 0.85}
               }// end of texture
       }// end of plane 1

// sea water --------------------------
plane{<0,1,0>, 0
      texture{ Glass
              normal{ripples 0.7
                     scale 1.25
                     turbulence 1.5
                     translate< clock,0,2>}
              finish{ambient 0 diffuse 0.55
                     brilliance 3.0 phong 0.8 phong_size 120
                     reflection 0.5 }
             }// end of texture
     interior{I_Glass}
     }// end of plane 2
//-------------------------------------
