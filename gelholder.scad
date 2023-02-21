// Setup
$fn = 100;
$fa = 0.1;
$fs = 0.1;

// Bolt size
bolt_diameter = 8.0;

// M8 nuts - approx
nut_diameter = 15.0; // with wiggle room
nut_depth    = 6.0;  // approx

// Enclosure
tot_diameter  = 150.0;
end_width     = 1.5;
side_width    = 1.5;
perf_diameter = 2.5;

// Calculated
tot_depth = nut_depth * 2.0;
circumference = PI * tot_diameter;
perf_size = perf_diameter + side_width + 0.5;
angle = 180.0 / ((circumference / (perf_size * 2.0)));

// Male
difference() {
    union() {
        // End
        cylinder(h = end_width, d = tot_diameter, center = false);
        // Center 'wall'
        difference() {
            cylinder(h = tot_depth, d = nut_diameter + side_width * 2.0, center = false);
            cylinder(h = tot_depth - 1.5, d = nut_diameter, center = false);
        }
        // Side wall
        difference() {
            cylinder(h = tot_depth, d = tot_diameter, center = false);
            cylinder(h = tot_depth + 1.0, d = tot_diameter - side_width * 2.0, center = false);
            // Perforations
            for (i = [end_width + 2.0, end_width + 2.0 + perf_size]) {
                for (j = [0:angle:180]) {
                    translate([0, 0.0, i])
                    rotate([0, 90, j])
                    cube([perf_diameter, perf_diameter,tot_diameter + 2.0], center = true);
                }
            }
        }
    }
    
    // Bolt hole
    translate([0,0,-1.0]) cylinder(h = tot_depth + 2.0, d = bolt_diameter, center = false);
    // Clearance for nut
    translate([0,0,-1.0]) cylinder(h = 4.0 , d = nut_diameter, center = false);
    render();
    // Perforations
    for (r = [nut_diameter / 2.0 + 5.0: perf_size : tot_diameter / 2.0 - side_width * 3.0]) {
        circ = PI * r * 2.0;
        rad = circ / (perf_size * 1.0);
        ang = 360 / floor(rad);
        for (b = [0.0:ang:360]) {
            rotate(b, [0,0,1])
            translate([r, 0, 1.0])            
            cylinder(h = end_width + 1.0, d = perf_diameter, center = true);
        }
    }
}