// Setup
$fn = 100;
$fa = 1;
$fs = 0.4;

thick = 3.1;
sensor_hole  = (0.1 * 25.4) + 0.1; // circa 2.5mm plus tolerance
fixing_hole  = 3.1; // M3 plus tolerance;

sensor_width = 0.7 * 25.4;
spacing_w    = 0.5 * 25.4;
sensor_length = 1.0 * 25.4;
spacing_l     = 0.8 * 25.4;

// import the pre-existing frame
translate([0,0,-thick/2])
linear_extrude(thick) {
    projection() {
        import("frame.stl",center=false);
    }
}

// initial frame for sensor - with X adjustment
max_adj = 4.0; // 2mm either side
offset = 20.0;
off2 = 0;
difference() {
    union() {
        // sensor frame
        translate([0,0,offset]) cube([sensor_width*1.5,sensor_length*2,thick], center=true);
        // additional bracing
        cube([12,90,thick],center = true);
        rotate([0,0,90])
        cube([12,90,thick],center = true);
        //main frame
        translate([0,0,off2])
        cube([sensor_width*2,90, thick],center=true);

    }
    translate([spacing_w/2,0,offset])
    cube([sensor_hole,spacing_l+sensor_hole+max_adj,offset], center=true);
    translate([-spacing_w/2,spacing_l/2,offset])
    cube([sensor_hole,sensor_hole+max_adj,thick*2], center=true);
    translate([-spacing_w/2,-spacing_l/2,offset])
    cube([sensor_hole,sensor_hole+max_adj,thick*2], center=true);
    // alignment notchs X
    translate([0,spacing_l/2,offset+thick-0.3])
    cube([sensor_width*1.5,0.3,thick],center=true);
    translate([0,-spacing_l/2,offset+thick-0.3])
    cube([sensor_width*1.5,0.3,thick],center=true);
    // alignment notchs Y
    translate([-spacing_w/2,0,thick-0.3])
    cube([0.3,90,thick],center=true);
    translate([spacing_w/2,0,thick-0.3])
    cube([0.3,90,thick],center=true);
    // M3 through holes
    translate([-spacing_w/2,-sensor_length+fixing_hole*2,(offset+thick*2)/2-thick])
    cylinder(h = offset+thick*2, d = fixing_hole, center=true);
    translate([spacing_w/2,-sensor_length+fixing_hole*2,(offset+thick*2)/2-thick])
    cylinder(h = offset+thick*2, d = fixing_hole, center=true);
    translate([-spacing_w/2,sensor_length-fixing_hole*2,(offset+thick*2)/2-thick])
    cylinder(h = offset+thick*2, d = fixing_hole, center=true);
    translate([spacing_w/2,sensor_length-fixing_hole*2,(offset+thick*2)/2-thick])
    cylinder(h = offset+thick*2, d = fixing_hole, center=true);
    // M3 Y adj
    translate([-spacing_w/2,-sensor_length+fixing_hole*2,0])
    cube([fixing_hole+max_adj,fixing_hole,thick],center=true);
    translate([spacing_w/2,-sensor_length+fixing_hole*2,0])
    cube([fixing_hole+max_adj,fixing_hole,thick],center=true);
    translate([-spacing_w/2,sensor_length-fixing_hole*2,0])
    cube([fixing_hole+max_adj,fixing_hole,thick],center=true);
    translate([spacing_w/2,sensor_length-fixing_hole*2,0])
    cube([fixing_hole+max_adj,fixing_hole,thick],center=true);
    // wiring
    translate([spacing_w/2,0,0])
    cube([sensor_hole+max_adj,spacing_l+sensor_hole,thick], center=true);
}