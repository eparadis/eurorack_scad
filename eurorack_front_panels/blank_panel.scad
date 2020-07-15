
//!OpenSCAD

Width_HP = 12;

include <front_panel_common.scad>

difference() {
  // all the positive stuff
  make_face_plate();

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
}
