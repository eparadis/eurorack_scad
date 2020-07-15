//!OpenSCAD

// from https://www.blockscad3d.com/community/projects/718412

module cutouts() {
  union(){
    translate([15, 0, (20 + 0 * 17.78)]){
      hole_for_jack();
    }
    translate([15, 0, (20 + 1 * 17.78)]){
      hole_for_jack();
    }
    translate([15, 0, (20 + 2 * 17.78)]){
      hole_for_jack();
    }
    translate([(15 + 17.78), 0, (20 + 0 * 17.78)]){
      hole_for_jack();
    }
    translate([(15 + 17.78), 0, (20 + 1 * 17.78)]){
      hole_for_potentiometer();
    }
    translate([(15 + 17.78), 0, (20 + 2 * 17.78)]){
      hole_for_potentiometer();
    }
    translate([(15 + 17.78), 0, (20 + 3 * 17.78)]){
      hole_for_potentiometer();
    }
    display_and_buttons();
  }
}

module display_and_buttons() {
  union(){
    translate([(x1 / 2), 0, 105]){
      cube([30, 10, 10], center=true);
    }
    translate([(5 + 8), 0, 90]){
      hole_for_switch();
    }
    translate([(5 + 32), 0, 90]){
      hole_for_switch();
    }
  }
}

Width_HP = 10;
jack_dia = 5.83;
pot_dia = 6.81;
switch_dia = 4.75;
text_depth = 1;

include <front_panel_common.scad>

difference() {
  // all the positive stuff
  make_face_plate();

  cutouts();

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

  panel_label("BeepBoop");
}
