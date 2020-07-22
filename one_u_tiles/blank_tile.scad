hp = 6; // width in hole points
plate_height = 1.7 * 25.4; // spec is 1.7"
plate_width = hp * 5.08 - 0.3; // general conversion factor with fudge for tolerance


module front_face() {
    thickness = 2; // thickness of PCB front panels
    cube([plate_width, thickness, plate_height], center=false);
}

rib_width = 2;
rib_inset = 2.9;
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

union() {
    front_face();
    left_stiffening_rib();
    right_stiffening_rib();
}