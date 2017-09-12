#include "colors.inc"
#include "textures.inc"

background{color White}

camera{location <10,10,-4> look_at <0,0,20>}

light_source{<4,4,0> color White}

#declare scene=text
{
ttf "crystal.ttf" "Graphics"
0.1 <0,0>
scale<2,2,2>
translate <-4,-0.5,20>
rotate<0,0,clock>
}

#declare objective=intersection
{
#declare R = 10.0;
#declare Over = 0.8;
sphere{<0,0,-R+Over>,R}
sphere{<0,0,R-Over>,R}
pigment{rgbf<1,1,1,1>}
finish{reflection 0.01}
interior{ior 1.4 dispersion 1.1}
translate<0,0,10>
}

#declare eyepiece=difference
{
cylinder{<0,0,0>,<0,0,0.2>,1.2}
sphere{<0,0,3.55>,3.5}
pigment{rgbf<1,1,1,1>}
finish{reflection 0.01}
interior{ior 1.4 dispersion 1.1}
translate<0,0,2.5>
}

#declare body=cone
{
<0,0,10>, 4.0
<0,0,2.5>, 1.2 open
pigment{rgbf<0,0,0,1>}
}

#declare scope=union
{
object{scene}
object{objective}
object{eyepiece}
object{body}
}

object{scope}
