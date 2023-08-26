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

side_clamp();
