// a bracket to mount a Korg Volca Sample to a 19" rack

// from https://www.korg.com/us/products/dj/volca_sample/specifications.php
volca_height = 115;
volca_width = 193;
volca_depth = 45;  // is this the body only or does it include the knobs?

module side_clamp() {
  /*
    _______
    |   __| B
    |  |
    |  |_C_
    |_____| B
      A
  */

  A = 10;
  B = 5;
  C = 5;
  thickness = 10; // how far this profile is extruded
  clamp_gap = 1;  // fudge factor for the clamp

  profile = [
    [0,0], [A,0], [A,B], [A-C,B],
    [A-C,B+volca_depth+clamp_gap,],
    [A,B+volca_depth+clamp_gap],
    [A,2*B+volca_depth+clamp_gap],
    [0,2*B+volca_depth+clamp_gap]
  ];

  linear_extrude(thickness)
    polygon(profile);
}

module rack_ear(num_U = 1) {
  W = 20; // width of the ear. holes are offset from the left side
  T = 3;  // thickness of the ear. 3mm is pretty strong.
  clr = 0.794; // clearance for overall height of ear

  module mounting_hole(offset) {
    translate([15.875/2,offset,-1])
      cylinder(d=7, h=10, $fn=64, center=true);
  }

  difference() {
    cube([W, num_U*44.45, T]);
    mounting_hole(6.35);
    mounting_hole(6.35+15.875);
    mounting_hole(6.35+31.75);
    cube([W, clr/2, T]); // trim bottom for clearance
    translate([0, num_U*44.45-0.794/2, 0])
      cube([W, clr/2, T]);  // trim top for clearance
  }
}


side_clamp();

for(i=[1:4]) {
  translate([i*30, 0, 0])
    rack_ear(i);
}

