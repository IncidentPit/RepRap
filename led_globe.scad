// Setup
$fn = 100;
$fa = 1;
$fs = 0.4;

diameter = 100.0;
top      = 40.0;
basethick = 3.0;
union() {
    intersection() {
        difference() {
            sphere(d = diameter);
            sphere(d = diameter - 2);
        }
        translate([0,0,-top]) cylinder(h = basethick, d = diameter);
    }
    difference() {
        sphere(d = diameter);
        sphere(d = diameter - 2);
        translate([0,0,-top - 100]) cylinder(h = 100, d = diameter);
    }
}

    
