// rack ears for making your own brackets

module one_U_hole_pattern() {
  module mounting_hole(offset) {
    translate([15.875/2,offset,-1])
    cylinder(d=7, h=50, $fn=64, center=true);
  }
  mounting_hole(6.35);
  mounting_hole(6.35+15.875);
  mounting_hole(6.35+31.75);
}

module one_U_screw_head_clearance() {
    translate([15.875/2, 6.35, 5]) cylinder(h=20, d=9);
    translate([15.875/2, 6.35+15.875, 5]) cylinder(h=20, d=9);
    translate([15.875/2, 6.35+31.75, 5]) cylinder(h=20, d=9);
  }

module rack_ear(num_U = 1, right=false) {
  W = 20; // width of the ear. holes are offset from the left side
  T = 3;  // thickness of the ear. 3mm is pretty strong.
  clr = 0.794; // clearance for overall height of ear

  translate([right?W:0, 0, 0])
  scale([right?-1:1, 1, 1])
  difference() {
    cube([W, num_U*44.45, T]);
    for(i=[0:num_U-1]) {
      translate([0, i*44.45, 0]) {
        one_U_hole_pattern();
      }
    }
    cube([W, clr/2, T]); // trim bottom for clearance
    translate([0, num_U*44.45-clr/2, 0])
      cube([W, clr/2, T]);  // trim top for clearance
  }
}