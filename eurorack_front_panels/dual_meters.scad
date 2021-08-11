
//!OpenSCAD

use <panel_common.scad>

Width_HP = 10;
jack_dia = inches(0.245);

include <front_panel_common.scad>


module cutouts() {
  // top meter
  translate([ x1/2 - 35.2/2, -0.1, 95]) {
    cube([35.2  , 4, 20.3 ]);
  }

  // bottom meter
  translate([ x1/2 - 35.2/2, -0.1, 45]) {
    cube([35.2  , 4, 20.3 ]);
  }

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
