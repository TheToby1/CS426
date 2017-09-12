#include "colors.inc"
#include "textures.inc"

global_settings{max_trace_level 24}

background{color White}

camera{location <2,4,-4> look_at <0,0,1>}

light_source{<2,4,-3> color White}

#declare image=pigment
{
	image_map
	{
		gif "logo.gif"
		once
	}
}

#declare mirrors = union
{
	#local mirror = 0;
	#local num_mirrors = 3;

	#while(mirror<num_mirrors)
	#local theta = (mirror/num_mirrors)*360.0;

	box
	{
		<0,0.5,0>,<0.01,-0.5,10>
		translate<0.5/tan(pi/num_mirrors),0,0>
		rotate<0,0,theta>
	}

	#local mirror = mirror + 1;
	#end

	finish
	{
		reflection 1
		ambient 0
		specular 0
	}
}

#declare kaleidoscope = union
{
	object{mirrors}

	cylinder
	{
		<0,0,0>,<0,0,10>, 0.6 open
		texture
		{
			pigment {color Red}
		}
	}

	plane
	{
		<0,0,1>, 10
		pigment{image}
		scale<4,4,1>
		translate<-2+clock,-2,0>
		finish{ambient 1.5}
	}
}

object{kaleidoscope}
