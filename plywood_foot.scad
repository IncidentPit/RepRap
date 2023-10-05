// Setup
$fn = 100;
$fa = 1;
$fs = 0.4;

moulding = 25.5; // 0.5mm tolerance
plywood  = 18.0;
thick    = 7.0;
lip      = 6.0;
width    = 30.0;
top      = 25.0;
hole     = 5.0;

difference() {
linear_extrude(width) {
    polygon([[0,moulding], [moulding,0], [moulding+plywood+lip,0],
             [moulding+plywood+lip,thick+lip-1], [moulding+plywood+lip-1,thick+lip],
             [moulding+plywood+1,thick+lip], [moulding+plywood,thick+lip-1],
             [moulding+plywood,thick],
             [moulding,thick], [thick,moulding],
             [thick,moulding+top], [0,moulding+top]]);
}
translate([0,moulding+top/2,width/2]) rotate([0,90,0]) cylinder(h = thick*2, d= hole, center = true);
}