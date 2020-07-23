/*
A Pulp Logic compatible 1U with cutouts to mount four jacks.

based on the "4 Jacks" example given here
http://pulplogic.com/1u_tiles/

units: millimeters
*/

use <blank_tile.scad>
use <tile_common.scad>

function inches( x) = x * 25.4; // convert inches to mm

module cutouts() {
    $fs=0.01; // make cylinder curves more fine

    // top-left jack
    hole(x=inches(0.325), z=inches(1.180), d=inches(0.245));

    // top-right jack
    hole(x=inches(0.875), z=inches(1.180), d=inches(0.245));
    
    // bottom-left jack
    hole(x=inches(0.325), z=inches(0.520), d=inches(0.245));

    // bottom-right jack
    hole(x=inches(0.875), z=inches(0.520), d=inches(0.245));
}

module one_pot_two_jacks() {
    difference() {
        blank_tile();
        cutouts();
    }
}

one_pot_two_jacks();