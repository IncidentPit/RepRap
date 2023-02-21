// Setup
$fn = 50;
$fa = 1;
$fs = 0.4;

// Box parameters
angle = 5.5;
width = 85.0; // flat - not on angle
length = 60.0;
lip_height = 10.0; // needs checking

// Stand parameters
thickness = 1.5;
bolt_offset = 7.0;
bolt_diameter = 3.0;
gap = 5.0;

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

// PCB holder (perf board - 11 strips wide 1.1inch
pcb_width = 27.95;
pcb_thickness = 1.61;
pcb_length = 40.0;
offset = 3.5;
thick  = 2.54;
notch = thick / 2.0;
start = (angled_width /2.0) - (pcb_width / 2.0);

translate([start, 0, bot_height + gap - 2])
rotate([0,angle,0])
difference() {
    union() {
        cube([thick,pcb_length,offset + notch + notch], center = false);
        translate([pcb_width,0,0]) cube([thick,pcb_length,offset + notch + notch], center = false);
        translate([-10, bolt_offset,0]) cylinder(h = offset + thick, d = 8, center = false);
        translate([pcb_width + thick + 10, bolt_offset,0]) cylinder(h = offset + thick, d = 8, center = false);
    }
    translate([notch,0,offset]) cube([notch,pcb_length,notch], center = false);
    translate([pcb_width,0,offset]) cube([notch,pcb_length,notch], center = false);
    translate([-10, bolt_offset,0]) cylinder(h = offset + thick, d = 4, center = false);
    translate([pcb_width + thick + 10, bolt_offset,0]) cylinder(h = offset + thick, d = 4, center = false);
}
}

