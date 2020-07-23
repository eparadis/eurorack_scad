
// put a hole in the tile of diameter 'd' at position 'x','z'
module hole( x, z, d) {
    translate([x, 0, z])
        rotate([270,0,0])
            cylinder(r=(d / 2), h=10, center=true);
}