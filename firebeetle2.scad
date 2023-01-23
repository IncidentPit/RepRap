// Imports
use <MCAD/boxes.scad>

// Setup
$fn = 50;
$fa = 1;
$fs = 0.4;

// Board details
boardwidth      = 25.4;
boardlength     = 60.0;
maxthickness    = 7.2;
pcbthickness    = 1.6;
edgetohole      = 0.7;
holeradius      = 1.0;
holediameter    = 1.6; // 2mm actual
pillardiameter  = 2.5;
switchsize      = 4;
switchoffset    = 6.5;
// hole spacing - width
// 0.7-2.0-20.0-2.0-0.7 == 25.4
// length
// 0.7-2.0-54.6-2.0-0.7 == 60.0

// Enclosure as a function of board
clearanceabove  = 1;
clearancebelow  = 1.2;
clearancesides  = 1;
wallthickness   = 0.8;
ventilationstrips = 7;
ventilationwidth  = 0.5;
ventilationlength = 0.0125;

// Computed
sides = clearancesides * 2;
walls = wallthickness  * 2;
length = boardlength + sides;
width  = boardwidth + sides;
totallength = length + walls;
totalwidth  = width + walls;
partspacing = 2;
radius      = 1;
edge1 = wallthickness + clearancesides;
edge2 = edgetohole + holeradius;
x1 = edge1 + edge2;
x2 = edge1 + boardwidth - edge2;
y1 = edge1 + edge2;
y2 = edge1 + boardlength - edge2;
offsets = [[x1, y1], [x1, y2], [x2, y1], [x2, y2]];

// Base
{
    basevoid   = clearancebelow + pcbthickness;
    baseheight = basevoid + wallthickness;
    translate([partspacing, 0, 0])
    union() {
        difference() {
            translate([totalwidth / 2, totallength / 2, baseheight / 2])
            roundedBox([totalwidth, totallength, baseheight], radius, true);
            translate([totalwidth / 2, totallength / 2, (baseheight / 2) + (wallthickness / 2)])
            roundedBox([width, length, basevoid + 0.01], radius, true);
        }
        for (xy = offsets)
        {
            translate([xy.x, xy.y, 0])
                cylinder(wallthickness + clearancebelow, d1 = pillardiameter, d2 = pillardiameter, true);
            translate([xy.x, xy.y, 0])
                cylinder(baseheight, d1 = holediameter, d2 = holediameter, true);
        }
    }
}

// Top
{
    topvoid   = clearanceabove + (maxthickness - pcbthickness);
    topheight = topvoid + wallthickness;
    translate([-(totalwidth + partspacing), 0, 0])
    union() {
        difference() {
            translate([totalwidth / 2, totallength / 2, topheight / 2])
            roundedBox([totalwidth, totallength, topheight], radius, true);
            translate([totalwidth / 2, totallength / 2, (topheight / 2) + (wallthickness / 2)])
            roundedBox([width, length, topvoid + 0.01], radius, true);
            //Reset switch
            translate([-0.1 + totalwidth - walls, switchoffset, topheight - switchsize])
            cube(switchsize + 0.1);
            //Other switch
            translate([-0.1, switchoffset, topheight - switchsize])
            cube(switchsize + 0.1);
            // USB-C
            usbwidth  = 10;
            usbheight = 4;
            translate([totalwidth / 2 - usbwidth / 2, -0.1, topheight - usbheight])
            cube([usbwidth, walls, usbheight + 0.1], false);
            // Ventilation
            venwidth = totalwidth * ventilationwidth;
            venlength = totallength * ventilationlength;
            venx = (totalwidth - venwidth) / 2;
            veny = totallength / (ventilationstrips + 1);
            for (y = [veny - venlength/2:veny:totallength-venlength])
                translate([venwidth, y, -0.1]) roundedBox([venwidth, venlength,5],venlength/2,true);
        }
        // Pillars/retainers
        for (xy = offsets)
            translate([xy.x, xy.y, 0])
                cylinder(topheight, d1 = pillardiameter, d2 = pillardiameter, true);
    }
}
    
