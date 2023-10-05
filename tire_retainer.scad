// Setup
$fn = 100;
$fa = 1;
$fs = 0.4;

innerdiameter = 65.0;
outerdiameter = 85.0;
bore  = 8.0;
thick = 3.0; 
lip   = 6.0;

difference() {
union() {
difference() {
    union() {
        cylinder(h = thick, d = outerdiameter, center = true);
        translate([0,0,thick *3/2]) cylinder(h = lip,   d = innerdiameter, center = true);
    }
    translate([0,0,(thick *3/2)]) cylinder(h = lip + 1, d = innerdiameter - (thick * 2), center = true);
}
translate([0,0,thick *3/2]) cylinder(h = lip, d = bore * 2, center = true);
translate([0, 0, thick * 3/2]) cube([innerdiameter, lip, lip], center = true);
rotate([0,0,90])
translate([0, 0, thick * 3/2]) cube([innerdiameter, lip, lip], center = true);
}
cylinder(h = 100, d = bore, center = true);
}