// a bracket to mount a Korg Volca Sample to a 19" rack

// from https://www.korg.com/us/products/dj/volca_sample/specifications.php
volca_height = 115;
volca_width = 193;
volca_depth = 45;  // is this the body only or does it include the knobs?

module volca() {
  cube([volca_width, volca_height, volca_depth]);
}

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

module rack_ear(num_U = 1, right=false) {
  W = 20; // width of the ear. holes are offset from the left side
  T = 3;  // thickness of the ear. 3mm is pretty strong.
  clr = 0.794; // clearance for overall height of ear

  module mounting_hole(offset) {
    translate([15.875/2,offset,-1])
      cylinder(d=7, h=10, $fn=64, center=true);
  }

  translate([right?W:0, 0, 0])
  scale([right?-1:1, 1, 1])
  difference() {
    cube([W, num_U*44.45, T]);
    for(i=[0:num_U-1]) {
      translate([0, i*44.45, 0]) {
        mounting_hole(6.35);
        mounting_hole(6.35+15.875);
        mounting_hole(6.35+31.75);
      }
    }
    cube([W, clr/2, T]); // trim bottom for clearance
    translate([0, num_U*44.45-clr/2, 0])
      cube([W, clr/2, T]);  // trim top for clearance
  }
}

module demo() {
  side_clamp();

  for(i=[1:4]) {
    translate([(i-1)*60+30, 0, 0]) {
      rack_ear(i);
      translate([30,0,0]) rack_ear(i, right=true);
    }
  }
}

module bracket() {
  // left ear
  translate([-15.875, 0, 0])
    rack_ear(3);

  // right ear
  translate([15.875-20+450.85,0,0])
    rack_ear(3, right=true);

  // plate
  clr = 0.794;
  W = 450.85;
  T = 3;
  difference() {
    cube([W, 44.45*3, T]);
    cube([W, clr/2, T]); // bottom clearance
    translate([0, 44.45*3-clr/2, 0])
      cube([W, clr/2, T]);  // top clearance
    translate([10, (44.45*3-volca_height)/2, -volca_depth/2 ]) volca();
    translate([450.85-volca_width-10, (44.45*3-volca_height)/2, -volca_depth/2 ]) volca();
  }

}

bracket();
%translate([10, (44.45*3-volca_height)/2, -volca_depth/2 ]) volca();
%translate([450.85-volca_width-10, (44.45*3-volca_height)/2, -volca_depth/2 ]) volca();

// how much space is in the middle? could we fit tiny eurorack rails?
d = 450.85-2*volca_width-2*10;
echo(str("distance between volcas = ", d, " mm (", d/5.08, " hp)"));
