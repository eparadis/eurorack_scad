hp = 6; // width in hole points
plate_height = 1.7 * 25.4; // spec is 1.7"
plate_width = hp * 5.08 - 0.3; // general conversion factor with fudge for tolerance

module front_face() {
    thickness = 2; // thickness of PCB front panels
    cube([plate_width, thickness, plate_height], center=false);
}

rib_width = 2;
rib_inset = 2;
rib_height = 25; // max physically measured at 29.06
rib_depth = 8;
module left_stiffening_rib() {
    translate([rib_inset, 0, ((plate_height - rib_height) / 2)]){
        cube([rib_width, rib_depth, rib_height], center=false);
    }
}

module right_stiffening_rib() {
    translate([((plate_width - rib_width) - rib_inset), 0, ((plate_height - rib_height) / 2)]){
        cube([rib_width, rib_depth, rib_height], center=false);
    }
}

module material() {
    union() {
        front_face();
        left_stiffening_rib();
        right_stiffening_rib();
    }
}

module mounting_holes() {
    // make round shapes more fine
    $fs = 0.1;

    mounting_hole_dia = 0.125 * 25.4; // spec 0.125"
    hole_horiz_offset = 0.2 * 25.4; // spec 0.200"
    hole_vert_offset = 0.118 * 25.4; // spec 0.118"

    module hole_pair(h_offset) {
        translate([h_offset, 0, hole_vert_offset])
            rotate([270,0,0])
                cylinder(r=mounting_hole_dia / 2, h=10, center=true);
        
        translate([h_offset, 0, plate_height - hole_vert_offset])
            rotate([270,0,0])
                cylinder(r=mounting_hole_dia / 2, h=10, center=true);
    }
    hole_pair(hole_horiz_offset);
    hole_pair(plate_width - hole_horiz_offset);
}

module cutouts() {
    mounting_holes();
}
module blank_tile() {
    difference() {
        material();
        cutouts();
    }
}

blank_tile();