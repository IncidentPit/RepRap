// Setup
$fn = 100;
$fa = 1;
$fs = 0.4;

// Bearing size
//width       = 7.0;
bore        = 8.0;
//diameter    = 22.0;

// parameters
size  = 35.0;
width = 2.0;
depth = 1.0; // in addtion to width

// Male
translate([size / 1.9, 0 ,0])
difference() {
    union() {
        cylinder(h = width + depth, d = bore + depth, center = false);
        cylinder(h = width, d = size, center = false);
    }
    translate([0,0,-0.001])
    cylinder(h = width + depth + 0.002, d= bore, center = false);
}

// Female
translate([-size / 1.9, 0 ,0])
difference() {
    union() {
        cylinder(h = width + depth, d = bore + depth * 2, center = false);
        cylinder(h = width, d = size, center = false);
    }
    translate([0,0,-0.001])
    cylinder(h = width + depth + 0.002, d = bore + depth, center = false);
}
