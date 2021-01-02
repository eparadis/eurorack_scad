/*
A Pulp Logic compatible 1U blank tile.

based on the dimensions given here:
http://pulplogic.com/1u_tiles/

units: millimeters
*/

use <tile_common.scad>;

plate_height = inches(1.7); // spec is 1.7"

module front_face(plate_width) {
    thickness = 2; // thickness of PCB front panels
    cube([plate_width, thickness, plate_height], center=false);
}

rib_width = 2;
rib_inset = 1;
rib_height = 25; // max physically measured at 29.06
rib_depth = 8;
module left_stiffening_rib() {
    translate([rib_inset, 0, ((plate_height - rib_height) / 2)]){
        cube([rib_width, rib_depth, rib_height], center=false);
    }
}

module right_stiffening_rib(plate_width) {
    translate([((plate_width - rib_width) - rib_inset), 0, ((plate_height - rib_height) / 2)]){
        cube([rib_width, rib_depth, rib_height], center=false);
    }
}

module material(plate_width) {
    union() {
        front_face(plate_width);
        left_stiffening_rib();
        right_stiffening_rib(plate_width);
    }
}

module mounting_holes(plate_width) {
    // make round shapes more fine
    $fs = 0.1;

    mounting_hole_dia = inches(0.125); // spec 0.125"
    hole_horiz_offset = inches(0.200); // spec 0.200"
    hole_vert_offset = inches(0.118); // spec 0.118"

    module hole_pair(h_offset) {
        hole(x=h_offset, z=hole_vert_offset, d=mounting_hole_dia);
        
        hole(x=h_offset, z=(plate_height - hole_vert_offset), d=mounting_hole_dia);
    }
    hole_pair(hole_horiz_offset);
    hole_pair(plate_width - hole_horiz_offset);
}

module cutouts(plate_width) {
    mounting_holes(plate_width);
}

// hp is the width in eurorack 'hole positions'
module blank_tile(hp = 6) {
    plate_width = hp * 5.08 - 0.3; // general conversion factor with fudge for tolerance
    difference() {
        material(plate_width);
        cutouts(plate_width);
    }
}

blank_tile();