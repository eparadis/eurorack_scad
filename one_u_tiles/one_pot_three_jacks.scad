/*
A Pulp Logic compatible 1U with cutouts to mount three jacks and one potentiometer.

Inspired by some of the examples given here:
http://pulplogic.com/1u_tiles/

units: millimeters
*/

use <blank_tile.scad>
use <tile_common.scad>

module label(x, z, s) {
    text_depth=1;
    translate([x,0,z])
    translate([0,text_depth,0])
    rotate([90, 0, 0])
    linear_extrude(height=3)
        text(s, 2, "Krungthep", halign="center", valign="center" );
}

module cutouts() {
    $fs=0.01; // make cylinder curves more fine

    // top-left jack
    hole(x=inches(0.325), z=inches(1.180), d=inches(0.245));
    label(x=inches(0.325), z=inches(1.42), s="IN");

    // top-right jack
    hole(x=inches(0.875), z=inches(1.180), d=inches(0.245));
    label(x=inches(0.875), z=inches(1.42), s="OUT");
    
    // bottom-left jack
    hole(x=inches(0.325), z=inches(0.600), d=inches(0.245));
    label(x=inches(0.6), z=inches(0.300), s="CV");

    // bottom-right potentiometer
    hole(x=inches(0.800), z=inches(0.600), d=inches(0.380));
}

module one_pot_two_jacks() {
    difference() {
        blank_tile();
        cutouts();
    }
}

one_pot_two_jacks();