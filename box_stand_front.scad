// Setup
$fn = 50;
$fa = 1;
$fs = 0.4;

// Box parameters
angle = 5.5;
width = 85.0; // flat - not on angle
length = 60.0;
lip_height = 13.0; // needs checking

// Stand parameters
thickness = 1.5;
bolt_offset = 7.0;
bolt_diameter = 3.0;
gap = 5.0;

module Support(th, le, he) {
    cube([th, le, he]);
    translate([-th / 2, 0, he - 2]) cube([th * 2, le, th / 3]);
}

// Calculated
// overall minimum height, accounting for angle, width covered and additional lip clearance

angled_width = width / cos(angle);
bot_drop   = (tan(angle) * width);
drop1      = tan(angle) * bolt_offset;
drop2      = tan(angle) * (width-bolt_offset);
bot_height = bot_drop + lip_height;
top_height = bot_drop + thickness;
total_height = top_height + bot_height + gap;
offsets = [[bolt_offset,bolt_offset, drop1],
           [width-bolt_offset, bolt_offset, drop2],
           [bolt_offset, length - bolt_offset, drop1],
           [width-bolt_offset, length - bolt_offset, drop2]];

union() {
intersection() {
    difference() {
        union() {
            // side walls
            cube([width,thickness,bot_height], center = false);
            translate([0,length - thickness, 0]) cube([width,thickness,bot_height], center = false);
            cube([thickness,length,bot_height], center = false);
            translate([width - thickness, 0, 0]) cube([thickness,length,bot_height], center = false);
            // top of bottom...
            translate([-5,-5,bot_height - thickness]) rotate([0,angle, 0]) cube([width + 10, length + 10, thickness]);
            // bottom of top
            translate([-5,-5,bot_height + gap]) rotate([0,angle,0]) cube([width + 10, length + 10, thickness]);
            // add flats around bolt holes
            for (o = offsets) {
                translate([o[0],o[1], bot_height - thickness * 2 - o[2]]) cylinder(h = thickness * 3 + gap, d = bolt_diameter + 4.0, center = false);
            }
        }
        // bolt holes
        for (o = offsets) {
            translate([o[0], o[1], 0]) cylinder(h = total_height, d = bolt_diameter, center = false);
        }
        // remove gap
        translate([-5,-5,bot_height]) rotate([0,angle,0]) cube([width+10,length+10, gap]);
    }
    // cleanup around sides
    cube([width,length,total_height]);    
}

// Heaters
ptc_length = 25.0;
ptc_width  = 20.3;
ptc_thick  = 5.0;

gap = 5.0;
thick = 1.0;
start = 10.5;
space = ptc_width + thick;

translate([0,0,bot_drop + lip_height + gap + thickness - 1.1])
rotate([0,angle,0])
union() {
    translate([start, 0, 0]) Support(thick, ptc_length, ptc_thick + gap);
    translate([start + space, 0, 0]) Support(thick, ptc_length, ptc_thick + gap);
    translate([start + space * 2, 0, 0]) Support(thick, ptc_length, ptc_thick + gap);
    translate([start + space * 3, 0, 0]) Support(thick, ptc_length, ptc_thick + gap);
   
}

// Fan support
fan_angle = -45.0;
fan_width = 51.0;
fan_extra = 2.0;
fan_thick = 15.0;
supp_width = 2.0;
hole_dia   = 3.5;
half_fan = fan_width / 2.0;
half_hole  = hole_dia / 2.0;

translate([0,0,bot_drop + lip_height + gap + thickness - .5])
rotate([0,angle,0])
translate([angled_width - fan_width - bolt_offset,ptc_length + fan_thick /2,0])
rotate([fan_angle, 0, 0])
difference() {
    union() {
        //translate([0,0,14.5]) rotate([-45,0,0]) cube([fan_width - 10, 11.5, supp_width]);
        cube([fan_width, supp_width, fan_width + fan_extra]);
    }
    translate([10,0,15]) cube([fan_width, supp_width, fan_width]);
    translate([half_hole,0,half_hole + fan_extra])
    translate([half_fan - 23.0,0,half_fan + 20.0])
    rotate([90,0,0])
    cylinder(h = supp_width * 3, d = hole_dia, center = true);
    translate([half_hole,0,half_hole + fan_extra])
    translate([half_fan + 20.0,0,half_fan - 18.0])
    rotate([90,0,0])
    cylinder(h = supp_width * 3, d = hole_dia, center = true);
}
}