//!OpenSCAD

/* Description
This is a front panel for a Dual VCA eurorack module.

Each VCA has four jacks (input, output, CV) and a potentiometer to scale the
input CV.

This design has the VCAs grouped separately: input, output, CV, and the CV
control for each VCA are adjacent.

Labels are inset into the face to be filled in with paint or marker.
*/

// 'include' instead of 'use' in order to properly compute various dimensions
include <vca_common.scad>;

module single_vca_cutouts(offset) {
    union() {
        for (i=[0:2]) {
            translate([x1/2, 0, (offset + i * 12)]){
                hole_for_jack();
            }
        }
        translate([x1/2, 0, offset + 39]){
            hole_for_potentiometer();
        }
    }
}

difference() {
  // all the positive stuff
  make_face_plate();

  single_vca_cutouts(15);
  single_vca_cutouts(69);

  // cutouts
  // add a second set of mounting slots if larger than 10hp
  if (Width_HP <= 10) {
    make_slot_pair();
  } else {
    union(){
      make_right_slot_pair();
      make_slot_pair();
    }
  }
  echo("Final panel width: ", x1);

  panel_label("2VCA");

  control_label("OUT2", 3.5, 15 + 0 * 12);
  control_label("IN2", 4, 15 + 1 * 12);
  control_label("CV2", 4, 15 + 2 * 12);
  control_label("CV2", 3, 54);

  control_label("CV1", 3, 108);  
  control_label("CV1", 4, 108 - 15);
  control_label("IN1", 4, 108 - 15 - 12);
  control_label("OUT1", 3.5, 108 - 15 - 12 - 12);
}
