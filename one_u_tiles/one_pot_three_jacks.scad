/*
A Pulp Logic compatible 1U with cutouts to mount three jacks and one potentiometer.

Inspired by some of the examples given here:
http://pulplogic.com/1u_tiles/

units: millimeters
*/

use <blank_tile.scad>
use <tile_common.scad>

module cutouts() {
    $fs=0.01; // make cylinder curves more fine

    // top-left jack
    hole(x=inches(0.325), z=inches(1.180), d=inches(0.245));

    // top-right jack
    hole(x=inches(0.875), z=inches(1.180), d=inches(0.245));
    
    // bottom-left jack
    hole(x=inches(0.325), z=inches(0.600), d=inches(0.245));

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