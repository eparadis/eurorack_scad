/*
Common modules and functions for 1U Tiles
*/

function inches( x) = x * 25.4; // convert inches to mm

// put a hole in the tile of diameter 'd' at position 'x','z'
module hole( x, z, d) {
    translate([x, 0, z])
        rotate([270,0,0])
            cylinder(r=(d / 2), h=30, center=true);
}