/*
A Pulp Logic compatible 1U with cutouts to mount two jacks and one potentiometer.

based on the "2 Jacks and a Pot" example given here
http://pulplogic.com/1u_tiles/

units: millimeters
*/

use <blank_tile.scad>

function inches( x) = x * 25.4; // convert inches to mm

module cutouts() {
    $fs=0.01; // make cylinder curves more fine

    // top-left jack
    translate([inches(0.325), 0, inches(1.180)])
        rotate([270,0,0])
            cylinder(r=inches(0.245 / 2), h=10, center=true);

    // top-right jack
    translate([inches(0.875),0, inches(1.180)])
        rotate([270,0,0])
            cylinder(r=inches(0.245 / 2), h=10, center=true);
    
    // lower center potentiometer
    translate([inches(0.600), 0, inches(0.515)])
        rotate([270, 0, 0])
            cylinder(r=inches(0.380 / 2), h=10, center=true);
}

module one_pot_two_jacks() {
    difference() {
        blank_tile();
        cutouts();
    }
}

one_pot_two_jacks();