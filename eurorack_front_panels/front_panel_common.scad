// panel dimensions
// these will likely stay the same one dialed in
x1 = Width_HP * 5.08 - 0.3; // width of the front plate
x2 = 2.9; // inset of the stiffening ribs behind the front plate from the edges
x3 = 2;   // width of the stiffening ribs
x4 = 7.3; // distance to center of left-hand radius of mounting slot
x5 = 9.9; // distance to center of right-hand radius of mounting slot
y1 = 8;  // height of stiffening ribs (distance they extend back into the rack)
y2 = 2;   // thickness of front plate
z1 = 128.5; // height of the plate
z2 = 110.5; // length of the stiffening ribs (vertical distance)
z3 = 3;   // radius of mounting slots
z4 = 3;   // distance to center of radius/slot from lower edge of front plate

// make round shapes more fine
$fs = 0.1;

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

module panel_label(label) {
  translate([x1/2,0,116])
  translate([0,text_depth,0])
  rotate([90, 0, 0])
  linear_extrude(height=3)
    text(label, 5, "Krungthep", halign="center" );
}