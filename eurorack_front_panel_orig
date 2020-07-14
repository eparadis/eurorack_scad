//!OpenSCAD

// from https://www.blockscad3d.com/community/projects/718412

module hole_for_switch() {
  rotate([270, 0, 0]){
    cylinder(r1=switch_dia, r2=switch_dia, h=y2, center=false);
  }
}

module hole_for_potentiometer() {
  rotate([270, 0, 0]){
    cylinder(r1=pot_dia, r2=pot_dia, h=y2, center=false);
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

module hole_for_jack() {
  rotate([270, 0, 0]){
    cylinder(r1=jack_dia, r2=jack_dia, h=y2, center=false);
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
  union(){
    translate([x5, 0, 0]){
      rotate([270, 0, 0]){
        cylinder(r1=(z3 / 2), r2=(z3 / 2), h=y2, center=false);
      }
    }
    translate([x4, 0, 0]){
      rotate([270, 0, 0]){
        cylinder(r1=(z3 / 2), r2=(z3 / 2), h=y2, center=false);
      }
      translate([0, 0, ((z3 / 2) * -1)]){
        cube([(x5 - x4), y2, z3], center=false);
      }
    }
  }
}

Width_HP = 10;
jack_dia = 5.83;
pot_dia = 6.81;
switch_dia = 4.75;
x1 = Width_HP * 5.08 - 0.3;
x2 = 2.9;
x3 = 3;
x4 = 7.3;
x5 = 9.9;
y1 = 16;
y2 = 3;
z1 = 128.5;
z2 = 110.5;
z3 = 3;
z4 = 3;
union(){
  translate([x2, 0, ((z1 - z2) / 2)]){
    cube([x3, y1, z2], center=false);
  }
  translate([((x1 - x3) - x2), 0, ((z1 - z2) / 2)]){
    cube([x3, y1, z2], center=false);
  }
  difference() {
    make_face_plate();

    if (Width_HP <= 10) {
      make_slot_pair();
    } else {
      union(){
        make_right_slot_pair();
        make_slot_pair();
      }
    }

  }
}