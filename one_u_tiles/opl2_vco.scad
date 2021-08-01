/*
A Pulp Logic compatible 1U with cutouts .

modified version of 'six_jacks.scad'

units: millimeters
*/

use <blank_tile.scad>
use <tile_common.scad>

module cutouts() {
    $fs=0.01; // make cylinder curves more fine
    // Rows
    top = inches(1.180);
    bottom = inches(0.520);
    // Columns
    col_spacing = 0.585;
    left = inches(0.4);
    center = left + inches(col_spacing);
    right = left + 2 * inches(col_spacing);

    // top-left jack
    hole(x=left, z=top, d=inches(0.245));

    // top-center jack
    hole(x=center, z=top, d=inches(0.245));

    // bottom-left jack
    hole(x=left, z=bottom, d=inches(0.245));

    // bottom-center jack
    hole(x=center, z=bottom, d=inches(0.245));

    // bottom-right jack
    hole(x=right, z=bottom, d=inches(0.245));

    // screen: http://adafru.it/454
    translate([left + 2.5 * inches(col_spacing), -1, (top+bottom)/2 - 19.9/2 ] ){
        cube([19.9, 4, 19.9]);
    }

    // top-right jack
    hole(x=right, z=top, d=6.88);

}

module six_jacks() {
    difference() {
        blank_tile(14);
        cutouts();
    }
}

six_jacks();