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

// Stand diameter and depth
stand_depth = 18.0;
stand_size  = 90.0;
stand_width = 1.4; // reduced and optimised for 0.2mm layer height

// Modified to add stand and ensure box is stable when changing filament etc.
// For simpler printing, the male 'union' is removed and the female 'socket' enlarged
// Male
translate([size / 1.9, 0 ,0])
difference() {
    cylinder(h = stand_depth, d = stand_size, center = false);
    translate([0,0,stand_width]) cylinder(h = stand_depth, d = stand_size - width, center = false);
    cylinder(h = width + depth, d = bore, center = false);
}

// Female
translate([-stand_size / 1.9, 0 ,0])
difference() {
    union() {
        cylinder(h = width + depth, d = bore + depth * 2, center = false);
        cylinder(h = width, d = size, center = false);
    }
    //cylinder(h = width + depth + 0.002, d = bore + depth, center = false);
    cylinder(h = width + depth, d = bore, center = false);
}
