
//!OpenSCAD

use <panel_common.scad>
sigma = 0.01;
Width_HP = 10;
jack_dia = 5.85;
pot_dia = 6.8;  // knob dia is 12.9
switch_dia = 5.8; // 5.75 + .05 clr

include <front_panel_common.scad>

module meter_volume() {
  cube([39.50, 8.7, 39.4]); // body
  translate([(39.5-35.25)/2, -2.7, 17])
    cube([35.25, 2.7, 20.30]); // front window
  translate([11.25, 8.7, 1.5])
    cube([16.8, 14.2, 17]); // rear coil housing
}

// example from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids
module prism(l, w, h){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module snap(w){
  clr = 8.7;
  cube([w, clr+3 , 2]);  // riser of the snap
  translate([0, clr + 3, 1])
    mirror([0,1,0])
      prism(w,3,2); // beveled clip
}

module meter_snaps() {
  translate([x1/2 - 39.5/2 - 2, 2-sigma, 105])
    rotate([0, 90, 0])
      snap(10);

  translate([39.5 + 2*2, 0, 0])
  translate([x1/2 - 39.5/2 - 2, 2-sigma, 105])
  mirror([1, 0, 0])
    rotate([0, 90, 0])
  snap(10);
}

module cutouts() {
  // top meter
  translate([ x1/2 - 35.2/2, -0.1, 95]) {
    cube([35.2  , 4, 20.3 ]);
  }

  left_col = x1 / 3 - 3;
  right_col = 2*x1 / 3 + 3;

  // left switch
  translate( [left_col, -0.01, 60])
    hole_for_switch(true);

  // left pot
  translate( [left_col, -0.01, 40])
    hole_for_potentiometer(true);

  // left jack
  translate( [left_col, -0.01, 20]) {
    hole_for_jack(true);
  }
  
  // right switch
  translate( [right_col, -0.01, 60])
    hole_for_switch(true);

  // right pot
  translate( [right_col, -0.01, 40])
    hole_for_potentiometer(true);

  // right jack
  translate( [right_col, -0.01, 20]) {
    hole_for_jack(true);
  }
}

difference() {
  // all the positive stuff
  union(){
    make_face_plate();
    meter_snaps();
  }

  // cutouts
  // add a second set of mounting slots if larger than 10hp
  union() {
    if (Width_HP < 10) {
      make_slot_pair();
    } else {
      union(){
        make_right_slot_pair();
        make_slot_pair();
      }
    }
    cutouts();
  }
}

module volume_check() {
  color("green")
    translate([ x1/2 - 39.50/2, 2, 95-17])
      meter_volume();
  // color("yellow")
  //   translate([ x1/2 - 39.50/2, 2, 55-17])
  //     meter_volume();
}

%volume_check();
