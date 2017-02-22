#include "textures.inc"
#include "colors.inc"
#include "glass.inc"
#include "stars.inc"
#include "woods.inc"

//avconv -r 10 -i assignment1%02d.png -b:v 1000k test.mov

global_settings { assumed_gamma 1.0 }

#if(clock<=0.7)
  #if(clock<=0.5)
    #declare bl = clock+0.3;
    #declare gr = clock+0.5;
  #else
    #declare bl = clock+0.3;
    #declare gr = 1;
  #end
#else
  #declare bl = 1;
  #declare gr = 1;
#end

#if(mod(clock,0.3)<0.15)
  #declare bob = 0+mod(clock,0.3)/3;
#else
  #declare bob = 0.1-mod(clock,0.3)/3;
#end

#if(mod(clock,0.5)<0.25)
  #declare boa =0+mod(clock,0.5)/5;
#else
  #declare boa = 0.1-mod(clock,0.5)/5;
#end

#declare light_wood = pigment { P_WoodGrain2A  color_map { M_Wood2A } }
#declare  dark_wood = pigment { P_WoodGrain12A color_map { M_Wood12A } }

#declare board_length = 1.5;
#declare board_width = 0.25;

light_source{<-5,100,-30> rgb<gr/6,gr/8,bl/7> shadowless}

camera {angle 30
        location  <0.0 , 1.0 ,-3.0>
        look_at   <-0.5 , 1.0 , 0.0>}

sphere{ <0,0,0>,0.4 scale <30,30,30> rotate<0,0,0> translate<-0.5,(clock*100)-25,1000>
        texture{ pigment{rgb<1,0.9,0.5>} finish{ambient 1}
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
           [0.0 color rgb<1,gr,bl>]
           [0.1-(clock/10) color rgb<gr,gr,gr>]
           [0.3-(clock/10) color rgb<0.1,0.25,0.75>] }
         } // end pigment
  finish {ambient bl diffuse 0}
  } // end of texture
 scale 10000
 }


// fog -------------
fog { fog_type   2
      distance   1000
      color      color rgbf<1,gr,bl,1>
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
              normal{ripples 1+clock
                     scale 1.25
                     turbulence 1.5+clock
                     translate< 0,0,-clock>}
              finish{ambient 0 diffuse 0.55
                     brilliance 3.0 phong 0.8 phong_size 120
                     reflection 1 }
             }// end of texture
     interior{I_Glass}
     }// end of plane 2
//-------------------------------------

#declare PlankNormal =
  normal
  { gradient x 2 slope_map { [0 <0,1>][.05 <1,0>][.95 <1,0>][1 <0,-1>] }
    scale 2
  };


union{
    cylinder{
            <0,-1,0>, <0,0.3,0>, 0.15 translate<0,0,0>
            }
    cylinder{
            <0,-1,0>, <0,0.3,0>, 0.15 translate<-1.5,0,0>
            }
    cylinder{
            <0,-1,0>, <0,0.3,0>, 0.15 translate<0,0,1.5>
            }
    cylinder{
            <0,-1,0>, <0,0.3,0>, 0.15 translate<-1.5,0,1.5>
            }
    cylinder{
            <0,-1,0>, <0,0.3,0>, 0.15 translate<0,0,-1.5>
            }
    cylinder{
            <0,-1,0>, <0,0.3,0>, 0.15 translate<0,0,-3>
            }
    box{
            <-1.7,0.28,-6>, <0.2,0.4,1.6>
       }
            translate<-2,0,5>
            pigment { gradient y
                pigment_map { [ 0.0 light_wood ]
                              [ 1.0 dark_wood ] }
                warp { repeat board_length*z offset 0.28*y }
                warp { repeat board_width*x offset board_length*5/2*z } }
            normal {	quilted 0.25
                      control0 0.0
                      control1 0.66
                      bump_size 0.25
                      scale <board_width,1,board_length>
                      warp { repeat board_length *z  }
                      warp { repeat board_width*x offset board_length*1.5*z } }
            finish { phong 1 }



    }

sphere{<0,0,0>, 0.2
      texture {
                pigment {
                    radial
                    color_map {
                        [ 0.0   color Blue ]
                        [ 0.24  color Blue ]
                        [ 0.25  color Yellow ]
                        [ 0.49  color Yellow ]
                        [ 0.5   color Red ]
                        [ 0.74  color Red ]
                        [ 0.75  color Yellow ]
                        [ 0.99  color Yellow ]
                    }
                    frequency 3
                }
                finish {
                    phong 1.0
                    phong_size 40
                    specular    1.0
                    roughness   0.01
                    brilliance  2.0
                    ambient clock/10
                }
      }
      rotate<clock*50,-clock*100,clock*100>
      translate<-clock/2,bob,7>
}

#declare boat=difference{
intersection{
      sphere{
            <0,0,0.5>, 2
      }
      sphere{
            <0,0,0>, 2
      }
}
sphere{
      <0,1,0.25>, 2
}
translate<0,0,0>
pigment { gradient y
    pigment_map { [ 0.0 light_wood ]
                  [ 1.0 dark_wood ] }
    warp { repeat board_length*z offset 0.28*y }
    warp { repeat board_width*x offset board_length*5/2*z } }
normal {	quilted 0.25
          control0 0.0
          control1 0.66
          bump_size 0.25
          scale <board_width,1,board_length>
          warp { repeat board_length *z  }
          warp { repeat board_width*x offset board_length*1.5*z } }
finish { phong 1 }
}

#declare sale=union{
difference{
  box{<0,0.5,0>,<0.5,2.5,2>}
  sphere{<-4.52,1.5,1>,5}
  texture{ pigment{color White} normal{ripples 1+clock
         scale 1.25
         turbulence 1.5+clock}
  finish{phong 1}}
}
cylinder{<0.4,0,1>,<0.4,2.5,1>, 0.1
texture{DMFLightOak} finish{ phong 1 }}
translate<1,0,0>
}

union{object{boat} object{sale}  rotate<0,-60,0> translate<-5+clock*2,0.2+boa*2,30+clock*2> }
