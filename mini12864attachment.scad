// Setup
$fn = 100;
$fa = 1;
$fs = 0.4;

// Parameters
case_horiz_x = 63.0;
case_diag_xy = 34.26;
case_thick   = 3.0;
case_hole_d  = 3.6;
case_clearance = 4.0;
case_clearance_x = 8.0;

// Calculated
case_vert_y  = sqrt((case_diag_xy ^ 2) - ((case_horiz_x / 2.0) ^ 2));
case_w = case_horiz_x + (case_clearance_x * 2.0);
case_h = case_vert_y + (case_clearance * 2.0);
off    = case_thick / 2.0;

print_xgap   = 40.0;
print_ygap   = 20.0;
print_xspace = (case_w - print_xgap) / 2.0;
print_yspace = 7.0;
print_hole_d = 4.5;

hinge_spacing = 18.0;
join_size     = hinge_spacing + case_thick * 2.0;

print_w = print_xgap + (print_xspace * 2.0);
print_h = print_ygap + (print_yspace * 2.0);

width_diff = (case_w - print_w) / 2.0;

union() {
// Support
linear_extrude(case_thick, center = false) {
    polygon([[0,0], [-(join_size - case_thick), 0],
    [-(join_size - case_thick), print_h], [17.17, 13.2]]); // HACK
}

translate([0,0,-(case_w - case_thick)])
rotate([0,-90,0])
union() {
// Case attachment
    rotate([-60,0,0])
difference() {
    cube([case_w, case_h, case_thick]);
    translate([case_clearance_x, case_h - case_clearance, off])
    cylinder(h = case_thick, d = case_hole_d, center = true);
    translate([case_w - case_clearance_x, case_h - case_clearance, off])
    cylinder(h = case_thick, d = case_hole_d, center = true);
    translate([case_w / 2.0, case_clearance, off])
    cylinder(h = case_thick, d = case_hole_d, center = true);
}
// Printer attachment
translate([width_diff, 0, hinge_spacing + case_thick])
difference() {
    cube([print_w, print_h, case_thick]);
    translate([print_w - print_xspace, print_yspace, off])
    cylinder(h = case_thick, d = print_hole_d, center = true);
    translate([print_w - print_xspace, print_h - print_yspace, off])
    cylinder(h = case_thick, d = print_hole_d, center = true);
    translate([print_xspace, print_h - print_yspace, off])
    cylinder(h = case_thick, d = print_hole_d, center = true);
}
// Top join
translate([width_diff, 0, 0])
cube([print_w, case_thick, join_size]);
}
}