// Setup
$fn = 100;
$fa = 1;
$fs = 0.4;

// Phone dimensions per apple
size   = 4 * 25.4; // 4 inches
thick  = 5.0;
count  = 5.0;

// Calcs
last = size - thick;
inc  = last / count;
echo(inc-thick);

// render
for(i = [0:inc:last]) {
    translate([i,0,0]) cube([thick, size, thick], false);
    translate([0,i,0]) cube([size, thick, thick], false);
}