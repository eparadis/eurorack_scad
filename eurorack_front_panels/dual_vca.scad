//!OpenSCAD

/* Description
This is a front panel for a Dual VCA eurorack module.

Each VCA has four jacks (input, output, CV) and a potentiometer to scale the
input CV.

This design has the six jacks at the bottom and the four potentiometers at 
the top.

Labels are inset into the face to be filled in with paint or marker.
*/

include <vca_common.scad>;

module make_face_plate() {
  difference() {
    cube([x1, y2, z1], center=false);

    union() {
        for (i=[0:5]) {
            translate([x1/2, 0, (15 + i * 12)]){
                hole_for_jack();
            }
        }
        for (i=[0:1]) {
            translate([x1/2, 0, (90 + i * 15)]){
                hole_for_potentiometer();
            }
        }
    }
  }
}

difference() {
  // all the positive stuff
  union() {
    make_face_plate();
    if (Width_HP > 10) {
        right_stiffening_rib();
    }
    left_stiffening_rib();
    right_stiffening_rib();
  }

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
  control_label("OUT1", 3.5, 15 + 3 * 12);
  control_label("IN1", 4, 15 + 4 * 12);
  control_label("CV1", 4, 15 + 5 * 12);

  control_label("CV2", 3, 90 + 0 * 15);
  control_label("CV1", 3, 90 + 1 * 15);
}
