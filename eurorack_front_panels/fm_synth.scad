//!OpenSCAD

// from https://www.blockscad3d.com/community/projects/718412

module cutouts() {
  union(){
    translate([15, 0, (20 + 0 * 17.78)]){ // bottom left - 1v/oct CV input
      hole_for_jack();
    }
    translate([15, 0, (20 + 1 * 17.78)]){ // 2nd from bottom, left - modulation CV input
      hole_for_jack();
    }
    translate([15, 0, (20 + 2 * 17.78)]){ // top, left - osc ratio CV input
      hole_for_jack();
    }
    translate([(15 + 17.78), 0, (20 + 0 * 17.78)]){ // bottom right - audio out
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
    // "0.91 inch OLED" display module from eBay
    translate([(x1 / 2), 0, 105]){
      cube([26.48, 10, 11.58], center=true); // the viewable area
      translate([4.79/2, 3.27-1.18+2, 0]) {
        cube([38.20, 3.27, 12.04], center=true); // the PCB
      }
    }
    translate([(5 + 8), 0, 90]){
      hole_for_switch();
      translate([0, 7, 0])
        cube([13.2, 9.5, 7.9], center=true); // body of double momentary
    }
    translate([(5 + 32), 0, 90]){
      hole_for_switch();
    }
  }
}

module supports() {
  // experimenting with a "support" around the switch body
  translate([(5 + 8), 4, 90]){
      cube([13.2+2, 4, 7.9+2], center=true);
    }
}

Width_HP = 10;
jack_dia = 5.83;
pot_dia = 6.81;
switch_dia = 6; // double momentary 6mm, pushbutton 7mm
text_depth = 1;

include <front_panel_common.scad>

difference() {
  // all the positive stuff
  union() {
    make_face_plate();
    supports();
  }

  // cutouts
  cutouts();

  
  // add a second set of mounting slots if larger than 10hp
  //if (Width_HP <= 10) {
  //  make_slot_pair();
  //} else {
    union(){
      make_right_slot_pair();
      make_slot_pair();
    }
  //}
  echo("Final panel width: ", x1);

  panel_label("BeepBoop");
}
