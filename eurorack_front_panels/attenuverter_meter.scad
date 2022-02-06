
//!OpenSCAD

use <panel_common.scad>

Width_HP = 10;
jack_dia = inches(0.245);
pot_dia = 6.8;  // knob dia is 12.9
switch_dia = 4.75; // TODO this seems way too small. maybe it's a pushbutton?

include <front_panel_common.scad>

module meter_volume() {
  cube([39.50, 8.7, 39.4]); // body
  translate([(39.5-35.25)/2, -2.7, 17])
    cube([35.25, 2.7, 20.30]); // front window
  translate([11.25, 8.7, 1.5])
    cube([16.8, 14.2, 17]); // rear coil housing
}

module cutouts() {
  // top meter
  translate([ x1/2 - 35.2/2, -0.1, 95]) {
    cube([35.2  , 4, 20.3 ]);
  }

  // left switch
  translate( [x1/3 - switch_dia/2, -0.01, 60])
    hole_for_switch();

  // left pot
  translate( [x1/3 - pot_dia/2, -0.01, 40])
    hole_for_potentiometer();

  // left jack
  translate( [x1/3 - jack_dia/2, -0.01, 20]) {
    hole_for_jack();
  }
  
  // right jack
  translate( [2*x1/3 + jack_dia/2, -0.01, 20]) {
    hole_for_jack();
  }
}

difference() {
  // all the positive stuff
  make_face_plate();

  // cutouts
  // add a second set of mounting slots if larger than 10hp
  union() {
    if (Width_HP <= 10) {
      make_slot_pair();
    } else {
      union(){
        make_right_slot_pair();
        make_slot_pair();
      }
    }
    cutouts();
  }
  echo("Final panel width: ", x1);
}

module volume_check() {
  color("green")
    translate([ x1/2 - 39.50/2, 2, 95-17])
      meter_volume();
}

%volume_check();
