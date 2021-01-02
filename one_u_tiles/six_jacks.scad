/*
A Pulp Logic compatible 1U with cutouts to mount six jacks.

modified version of 'four_jacks.scad'

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

    // top-right jack
    hole(x=right, z=top, d=inches(0.245));

    // bottom-left jack
    hole(x=left, z=bottom, d=inches(0.245));

    // bottom-center jack
    hole(x=center, z=bottom, d=inches(0.245));

    // bottom-right jack
    hole(x=right, z=bottom, d=inches(0.245));
}

module six_jacks() {
    difference() {
        blank_tile(10);
        cutouts();
    }
}

six_jacks();