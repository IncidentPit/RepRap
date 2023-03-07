// Setup
$fn = 100;
$fa = 1;
$fs = 0.4;

// NOTE - cut in PrusaSlicer and add connector

// Dimensions
// I'm guessing/assuming this should be 7/8 by 3/8
length = 353.0; // 270 + 83??
width  = 22.225;
depth  = 9.3;
lip    = 3.0;
top    = 5.0;

// Calculated
center = width / 2.0;
htop   = top / 2.0;
w1     = center - htop;
w2     = center + htop;

profile = [ [0,0], [0,lip], [w1,depth], [w2,depth], [width,lip], [width,0] ];

difference() {
    linear_extrude(height = length, center = false, convexity = 10, twist = 0, slices = 100, scale = 1.0) {
        polygon(profile);
    }
    // square off ends
    cube
}
