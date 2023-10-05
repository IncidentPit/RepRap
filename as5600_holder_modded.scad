// Setup
$fn = 100;
$fa = 1;
$fs = 0.4;

old_diam = 2.5;
new_diam = 3.45;
l = 18.6;
w = 18.3;
thick = 4.0;

l_off = (l - old_diam) / 2.0;
w_off = (w - old_diam) / 2.0;

// import the pre-existing frame
import("as5600_holder.stl",center=false);

translate([l_off, w_off, thick/2]) cylinder(h = thick, d= new_diam, center = true);
translate([-l_off, w_off, thick/2]) cylinder(h = thick, d= new_diam, center = true);
translate([l_off, -w_off, thick/2]) cylinder(h = thick, d= new_diam, center = true);
translate([-l_off, -w_off, thick/2]) cylinder(h = thick, d= new_diam, center = true);
