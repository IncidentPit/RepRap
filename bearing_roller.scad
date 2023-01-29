// Setup
$fn = 100;
$fa = 1;
$fs = 0.4;

// Bearing size
width       = 7.0;
bore        = 8.0;
diameter    = 22.0;

// Parameters
totallength = 86.0;
overlap     = 20.0;
inner       = diameter;
outer       = 49.0;
rimdiam     = 70.0;
rimwidth    =  2.0;
retainwidth =  1.0;
tolerance   =  0.1;
notchdiam   = inner + ((outer - inner) / 2.0);
length      = totallength / 2.0;
halfoverlap = overlap / 2.0;

module rim() {
    cylinder(h = rimwidth, d = rimdiam, center = false);
}

// Male
translate([rimdiam / 2 + 5, 0 ,0])
union() {
    difference() {
        union() {
            rim();
            cylinder(h = length - halfoverlap, d = outer, center = false);
            cylinder(h = length + halfoverlap, d = notchdiam - tolerance , center = false);
        }
        translate([0,0,-0.001])
        cylinder(h = totallength + 0.002, d = inner, center = false); 
    }
}

// Female
translate(-[rimdiam / 2 , 0, 0])
union() {
    difference() {
        union() {
            rim();
            cylinder(h = length + halfoverlap, d = outer, center = false);
        }
        translate([0,0,-0.001])
        cylinder(h = totallength + 0.002, d = inner, center = false);
        translate([0, 0, length - halfoverlap])
        cylinder(h = overlap + 0.001, d = notchdiam, center = false);
    }
}
