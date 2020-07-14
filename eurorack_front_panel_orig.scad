//!OpenSCAD

// from https://www.blockscad3d.com/community/projects/718412

module hole_for_switch() {
  hole_in_front_plate(switch_dia);
}

module hole_for_potentiometer() {
  hole_in_front_plate(pot_dia);
}

module hole_for_jack() {
  hole_in_front_plate(jack_dia);
}

module hole_in_front_plate(diameter) {
  translate([0,-y2/2,0])
  rotate([270, 0, 0]){
    cylinder(r1=diameter/2, r2=diameter/2, h=y2*2, center=false);
  }
}

module make_face_plate() {
  difference() {
    cube([x1, y2, z1], center=false);

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
}

module make_slot_pair() {
  union(){
    translate([0, 0, (z1 - z4)]){
      make_slot();
    }
    translate([0, 0, z4]){
      make_slot();
    }
  }
}

module make_right_slot_pair() {
  translate([(x4 + 5.08 * (Width_HP - 4)), 0, 0]){
    union(){
      translate([0, 0, (z1 - z4)]){
        make_slot();
      }
      translate([0, 0, z4]){
        make_slot();
      }
    }
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

module make_slot() {
  translate([0,-y2/2,0])
  union(){
    translate([x5, 0, 0]){
      rotate([270, 0, 0]){
        cylinder(r1=(z3 / 2), r2=(z3 / 2), h=y2*2, center=false);
      }
    }
    translate([x4, 0, 0]){
      rotate([270, 0, 0]){
        cylinder(r1=(z3 / 2), r2=(z3 / 2), h=y2*2, center=false);
      }
      translate([0, 0, ((z3 / 2) * -1)]){
        cube([(x5 - x4), y2*2, z3], center=false);
      }
    }
  }
}

module left_stiffening_rib() {
  translate([x2, 0, ((z1 - z2) / 2)]){
    cube([x3, y1, z2], center=false);
  }
}

module right_stiffening_rib() {
  translate([((x1 - x3) - x2), 0, ((z1 - z2) / 2)]){
    cube([x3, y1, z2], center=false);
  }
}

Width_HP = 10;
jack_dia = 5.83;
pot_dia = 6.81;
switch_dia = 4.75;

// panel dimensions
// these will likely stay the same one dialed in
x1 = Width_HP * 5.08 - 0.3; // width of the front plate
x2 = 2.9; // inset of the stiffening ribs behind the front plate from the edges
x3 = 3;   // width of the stiffening ribs
x4 = 7.3; // distance to center of left-hand radius of mounting slot
x5 = 9.9; // distance to center of right-hand radius of mounting slot
y1 = 16;  // height of stiffening ribs (distance they extend back into the rack)
y2 = 3;   // thickness of front plate
z1 = 128.5; // height of the plate
z2 = 110.5; // length of the stiffening ribs (vertical distance)
z3 = 3;   // radius of mounting slots
z4 = 3;   // distance to center of radius/slot from lower edge of front plate
union(){
  left_stiffening_rib();
  right_stiffening_rib();
  
  difference() {
    make_face_plate();

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
}