/*
A Pulp Logic compatible 1U testing various label sizes and styles

units: millimeters
*/

use <blank_tile.scad>
use <tile_common.scad>

module test_text(x, z, size, str) {
    text_depth=0.5;
    translate([x,0,z])
    translate([0,text_depth,0])
    rotate([90, 0, 0])
    linear_extrude(height=3)
        text(str, size, "Krungthep", halign="left", valign="center" );
}

module cutouts() {
    $fs=0.01; // make cylinder curves more fine

    for (row=[0:5]) {
        test_text(x=inches(0.1), z=inches(0.1+0.25*row), size=2+row / 2, str="CV OUT IN 123");
    }
}

module one_pot_two_jacks() {
    difference() {
        blank_tile();
        cutouts();
    }
}

one_pot_two_jacks();