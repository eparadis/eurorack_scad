// rail of holes to mount eurorack modules to

module eurorack_rail(length_hp=10) {
  difference() {
    cube([length_hp*5.08, 10, 3]);
    for(i=[0:length_hp-1]) {
      translate([i*5.08+5.08/2, 5, -1]) {
        cylinder(d=3, h=10, $fn=32);
      }
    }
  }
}

module eurorack_rails(length_hp=10, size_1U=false) {
  eurorack_rail(length_hp);
  translate([0, size_1U?37.186:122.5, 0]) { // pulp logic 1U format
    eurorack_rail(length_hp);
  }
}

eurorack_rails(10, size_1U=true);