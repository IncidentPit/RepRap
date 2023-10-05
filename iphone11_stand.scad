// modules
include <roundedcube.scad>

// Setup
$fn = 100;
$fa = 1;
$fs = 0.4;

// Phone dimensions per apple
width  = 75.7;
height = 150.9;
depth  = 8.3;

// Case (assumed currently)
thick  = 2.0;

// Charger
diameter  = 56.9; // NB 57.0 excellent fit but just not tight enough
thickness = 5.6;

// Stand
bezel_width  = 3.0;
bezel_height = 15.0;
bezel_thick  = (depth + thickness);
bezel_radius = 3.0;
stand_height = height + bezel_height + thick;
stand_width  = width + ((bezel_width + thick) * 2.0);

// Other
corner = 3.0;
join_tolerance = 0.2;
tol2 = 0.1;
screw = 3.05;
screw_head = 6.0;

// temp
intersection() {

// Create stand and remove phone and charger
difference() {
    // Stand
    union() {
        difference() {
            union() {
                // Stand
                roundedcube([stand_width, stand_height, bezel_thick], false, bezel_radius, "ymin");
                // Join
                translate([0,-bezel_thick/2+2,0])
                roundedcube([stand_width, bezel_thick, bezel_thick], false, bezel_thick / 2, "x");
            }
            // Remove join
            translate([stand_width / 4,-bezel_thick/2+2,0])
            roundedcube([stand_width / 2, bezel_thick, bezel_thick], false, (bezel_thick / 2) + join_tolerance, "x");
            // and a little extra underneath for rotation
            translate([stand_width / 4,-bezel_thick/2+2,0])
            cube([stand_width / 2, bezel_thick, bezel_thick/2], center = false);
        }
        // Base
        // Joint
        translate([stand_width / 4 + tol2,-bezel_thick/2+2,0])
        roundedcube([stand_width / 2 - (tol2*2), bezel_thick, bezel_thick], false, (bezel_thick / 2), "x");
        translate([stand_width / 4 + tol2,-15+2,0])
        cube([stand_width / 2 - (tol2*2), 15, bezel_thick /2], center = false);
        translate([0,-stand_width-7,0])
        roundedcube([stand_width, stand_width, bezel_thick /2], false, corner, "all");
        // emboss
        translate([8,-23,bezel_thick/2])
        scale([0.8,0.8,1])
        rotate([180,0,0])
        linear_extrude(1, center = true) {
            import("unicorn.svg");
        }
    }   

    // Remove screwhole
    translate([stand_width / 2,2,bezel_thick/2])
    rotate([0,90,0])
    cylinder(h = stand_width + 2, d= screw, center = true);
    // Remove screwheads
    translate([screw_head/2,2,bezel_thick/2])
    rotate([0,90,0])
    cylinder(h = screw_head, d= screw_head, center = true);
    translate([stand_width - screw_head/2,2,bezel_thick/2])
    rotate([0,90,0])
    cylinder(h = screw_head, d= screw_head, center = true);
    // Phone
    translate([bezel_width, bezel_height, thickness])
    roundedcube([width + thick * 2, height + thick * 2, depth + thick], false, corner, "all");
    // Speaker clearance
    clearancex = 16.0;
    clearancey = 5.0;
    translate([clearancex, bezel_height - clearancey, thickness])
    roundedcube([stand_width - clearancex * 2, clearancey * 2, clearancey *2], false, clearancey, "all");
    // Charger
    translate([bezel_width + thick + width / 2, bezel_height + thick + height / 2, 0])
    cylinder(h = thickness + 1, d = diameter, center = false);
    // Cable
    translate([bezel_width + thick + width / 2, bezel_height + thick + diameter / 1.5, (thickness - 0.5)/2])
    cube([10,25,thickness - 0.5],center=true);
    // Top cut - buttons start around 90mm up
    button_bot = 90.0;
    button_top = 140.0;
    translate([0, bezel_height + thick + button_bot, thickness])
    cube([stand_width, button_top - button_bot, bezel_thick + 1]);
    // nonslip pads
    padwidth = 76.0;
    padthick = 2.0;
    translate([(stand_width - padwidth) / 2.0, -stand_width-2, 0])
    roundedcube([padwidth, padwidth, padthick], false, 2, "xy");
}

//translate([0,35, 0])
//cube([stand_width,90, 20], center = false);
}
