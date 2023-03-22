// Setup
$fn = 100;
$fa = 1;
$fs = 0.4;

// tripod
width   = 40.5;
tapered = 35.5;
depth   = 8.4;
lip     = 1.9;
taper   = (width - tapered) / 2.0;
extra   = 9.0;

// level
// 'bulge'
tolerance = 0.3;
lwidth    = 20.7 + tolerance;
llength   = 24.44 + tolerance;
ldepth    = 2.5 + tolerance;
center    = 16.0;
adjust    = (tapered / 2.0) - center;

// bolt
hole = 6.5;
head = 12.5;
thicky = 2.0;

difference() {
    rotate([90,0,0])
    linear_extrude(width) {
        polygon([[0,0],[0,lip],[taper,depth],
                 [taper,depth+extra],[width-taper,depth+extra],
                 [width-taper,depth],[width,lip],[width,0]]);
    }
    translate([(width / 2.0) - adjust,-width/2.0,depth+extra-ldepth/2]) cube([lwidth,llength,ldepth],center=true);
    translate([(width / 2.0) - adjust,-width/2.0,(depth+extra)/2]) cylinder(h=depth+extra,d=hole,center=true);
    translate([(width / 2.0) - adjust,-width/2.0,(depth+extra)/2-ldepth-thicky]) cylinder(h=depth+extra, d=head,center=true);
}