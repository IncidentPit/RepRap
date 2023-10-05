// Setup
$fn = 100;
$fa = 1;
$fs = 0.4;

plywood = 18.0;
width   = 25.0;
filet   = 2.0;
latch   = 5.0;
hole    = 5.0;

difference() {
    union() {
        cylinder(h=plywood+filet,d=width,center=false);
        translate([-width/2,0,0]) cube([width,width/2,plywood+filet],center=false);
        translate([-width/2,0,0]) cube([width,width,filet]);
        
        translate([0,0,plywood+filet+5]) cylinder(h=latch,d=width,center=false);
        translate([-width/2,0,plywood+filet+5]) cube([width,width,latch],center=false);
    }
    cylinder(h = plywood+filet+5+latch+5, d=hole,center=false);
}