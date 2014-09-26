--[[
Ring Meters by londonali1010 (2009)
 
This script draws percentage meters as rings. It is fully customisable; all options are described in the script.
 
IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring straight away. The if statement on line 145 uses a delay to make sure that this doesn't happen. It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s is long enough, so if you update Conky every 1s, use update_num > 5 in that if statement (the default). If you only update Conky every 2s, you should change it to update_num > 3; conversely if you update Conky every 0.5s, you should use update_num > 10. ALSO, if you change your Conky, is it best to use "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.
 
To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
	lua_load ~/scripts/rings-v1.2.1.lua
	lua_draw_hook_pre ring_stats
 
Changelog:
+ v1.2.1 -- Fixed minor bug that caused script to crash if conky_parse() returns a nil value (20.10.2009)
+ v1.2 -- Added option for the ending angle of the rings (07.10.2009)
+ v1.1 -- Added options for the starting angle of the rings, and added the "max" variable, to allow for variables that output a numerical value rather than a percentage (29.09.2009)
+ v1.0 -- Original release (28.09.2009)
]]
 
settings_table = {

	{
		name='cpu',
		arg='cpu1',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.0,
		fg_colour=0x0092BF,
		fg_alpha=1.0,
		x=230, y=230,
		radius=165,
		thickness=17,
		start_angle=-90,
		end_angle=90
	},
	{
		name='cpu',
		arg='cpu2',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.0,
		fg_colour=0xddcd33,
		fg_alpha=1.0,
		x=230, y=230,
		radius=148,
		thickness=17,
		start_angle=-90,
		end_angle=90
	},
	{
		name='cpu',
		arg='cpu3',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.0,
		fg_colour=0x0092BF,
		fg_alpha=1.0,
		x=230, y=230,
		radius=131,
		thickness=17,
		start_angle=-90,
		end_angle=90
	},
	{
		name='cpu',
		arg='cpu4',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.0,
		fg_colour=0xddcd33,
		fg_alpha=1.0,
		x=230, y=230,
		radius=114,
		thickness=17,
		start_angle=-90,
		end_angle=90
	},

	{
		name='memperc',
		arg='',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.0,
		fg_colour=0xffffff,
		fg_alpha=1.0,
		x=230, y=230,
		radius=114,
		thickness=17,
		start_angle=-270,
		end_angle=-90
	},

}

settings_t = {
	{
		name='hwmon',
		arg='temp 2',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.0,
		fg_colour=0x0092BF,
		fg_alpha=1.0,
		x=230, y=231,
		radius=185,
		thickness=28,
		start_angle=-90,
		end_angle=-270
	},
	{
		name='hwmon',
		arg='temp 3',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.0,
		fg_colour=0xddcd33,
		fg_alpha=1.0,
		x=230, y=231,
		radius=148,
		thickness=28,
		start_angle=-90,
		end_angle=-270
	},
	{
		name='texeci 9',
		arg="hddtemp /dev/sda | awk '{ print $(NF-1) }' ",
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.0,
		fg_colour=0xC1272D,
		fg_alpha=1.0,
		x=230, y=231,
		radius=111,
		thickness=28,
		start_angle=-90,
		end_angle=-270
	}, 
}
require 'lcairo'
 
function rgb_to_r_g_b(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end
 
function draw_ring(cr,t,pt)
	local w,h=conky_window.width,conky_window.height
 
	local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
	local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']
 
	local angle_0=sa*(2*math.pi/360)-math.pi/2
	local angle_f=ea*(2*math.pi/360)-math.pi/2
	local t_arc=t*(angle_f-angle_0)
 
	-- Draw background ring
 
	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,ring_w)
	cairo_stroke(cr)
 
	-- Draw indicator ring
 
	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_stroke(cr)		
end
function draw_ring_cc(cr,t,pt)
	local w,h=conky_window.width,conky_window.height
 
	local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
	local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']
 
	local angle_0=sa*(2*math.pi/360)-math.pi/2
	local angle_f=ea*(2*math.pi/360)-math.pi/2
	local t_arc=t*(angle_f-angle_0)
 
	-- Draw background ring
 
	cairo_arc_negative(cr,xc,yc,ring_r,angle_0,angle_f)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,ring_w)
	cairo_stroke(cr)
 
	-- Draw indicator ring
 
	cairo_arc_negative(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_stroke(cr)		
end 
function conky_ring_stats()
	local function setup_rings(cr,pt)
		local str=''
		local value=0
 
		str=string.format('${%s %s}',pt['name'],pt['arg'])
		str=conky_parse(str)
 
		value=tonumber(str)
		if value == nil then value = 0 end
		pct=value/pt['max']
 
		draw_ring(cr,pct,pt)
	end
	local function setup_rings_cc(cr,pt)
		local str=''
		local value=0
 
		str=string.format('${%s %s}',pt['name'],pt['arg'])
		str=conky_parse(str)
 
		value=tonumber(str)
		if value == nil then value = 0 end
		pct=value/pt['max']
 
		draw_ring_cc(cr,pct,pt)
	end 
	if conky_window==nil then return end
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
 
	local cr=cairo_create(cs)	





	cairo_set_source_rgba(cr, rgb_to_r_g_b(0x0092bf,255))
	cairo_set_line_width(cr,28)

	cairo_move_to(cr,45,231) 
	cairo_line_to(cr,45,600)

  cairo_stroke(cr)

	cairo_set_source_rgba(cr, rgb_to_r_g_b(0xddcd33,255))
	cairo_set_line_width(cr,28)

	cairo_move_to(cr,82,341) 
	cairo_line_to(cr,82,600)

  cairo_stroke(cr)

	cairo_set_source_rgba(cr, rgb_to_r_g_b(0xc1272d,255))
	cairo_set_line_width(cr,28)

	cairo_move_to(cr,119,380) 
	cairo_line_to(cr,119,600)

  cairo_stroke(cr)








	local updates=conky_parse('${updates}')
	update_num=tonumber(updates)
 
	if update_num>5 then
		for i in pairs(settings_table) do
			setup_rings(cr,settings_table[i])
		end
		for i in pairs(settings_t) do
			setup_rings_cc(cr,settings_t[i])
		end

	cairo_set_source_rgba(cr, 255,255,255,255)
	cairo_set_line_width(cr, 2)

	cairo_move_to(cr,230,200) 
	cairo_line_to(cr,230,260)
 
	cairo_move_to(cr,15,230) 
	cairo_line_to(cr,450,230)
  
  cairo_stroke(cr)

end
end
