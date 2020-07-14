Width_HP = 4;
jack_dia = 5.8;
pot_dia = 6.8;  // knob dia is 12.9
switch_dia = 4.75;
text_depth = 1;

include <front_panel_common.scad>

module control_label(label, x, z) {
    translate([x,0,z])
    translate([0,text_depth,0])
    rotate([90, 0, 0])
    linear_extrude(height=3)
        text(label, 2, "Krungthep", halign="center", valign="center" );
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

