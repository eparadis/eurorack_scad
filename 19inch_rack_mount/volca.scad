// a bracket to mount a Korg Volca Sample to a 19" rack

use <rack_ear.scad>;
use <eurorack_rails.scad>;

// from https://www.korg.com/us/products/dj/volca_sample/specifications.php
volca_height = 115;
volca_width = 193;
volca_depth = 45;  // is this the body only or does it include the knobs?

$fn=64;

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

module demo() {
  side_clamp();

  for(i=[1:4]) {
    translate([(i-1)*60+30, 0, 0]) {
      rack_ear(i);
      translate([30,0,0]) rack_ear(i, right=true);
    }
  }
}

module corner_clamp() {
  difference(){
    translate([10,20,20])
    rotate([-90,0,180]){
      side_clamp();
      translate([0, 0, 10]) {
        path = [
          [0,0], [20,0], [20,10], [20-5,10], [0,5]
        ];
        rotate([90,0,90])
        linear_extrude(10)
          polygon(path);
      }
    }
    translate([5,5,0]) cylinder(d=3.5, h=20);
    translate([5,5,3]) cylinder(d=7, h=20);
  }
}

module bracket() {
  // left ear
  translate([-15.875, 0, 0])
    rack_ear(3);

  // right ear
  translate([15.875-20+450.85,0,0])
    rack_ear(3, right=true);

  // // plate
  // clr = 0.794;
  // W = 450.85;
  // T = 3;
  // difference() {
  //   cube([W, 44.45*3, T]);
  //   cube([W, clr/2, T]); // bottom clearance
  //   translate([0, 44.45*3-clr/2, 0])
  //     cube([W, clr/2, T]);  // top clearance
  //   translate([10, (44.45*3-volca_height)/2, -volca_depth/2 ]) volca();
  //   translate([450.85-volca_width-10, (44.45*3-volca_height)/2, -volca_depth/2 ]) volca();
  // }

  // stub rails
  eurorack_rails(84);

}

corner_clamp();
//bracket();
%translate([10, (44.45*3-volca_height)/2, -volca_depth/2 ]) volca();
%translate([450.85-volca_width-10, (44.45*3-volca_height)/2, -volca_depth/2 ]) volca();

// how much space is in the middle? could we fit tiny eurorack rails?
d = 450.85-2*volca_width-2*10;
echo(str("distance between volcas = ", d, " mm (", d/5.08, " hp)"));
