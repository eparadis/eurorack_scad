// 1U shelf brackets

include <BOSL2/std.scad>;
include <rack_ear.scad>;

$fn=32;

module profile() {
  tcmds = [
    // wing towards the back
    "move",20, "right",60, "untily",-20, "left",60, "untilx",40,
    // return to front edge
    "left",90, "move",50,
    // wing towards the front
    "left",90, "move",10, "left",40, "untilx",0,
    // flat surface for rack mounting screws
    //"setdir",180, "untilx",0,
  ];
  path = turtle(tcmds);
  polygon(path);
}

module shelf_slot() {
  cube([20, 5, 100]);
}

module shelf_bracket() {
  H = 29; // height of the bracket
  difference() {
    rotate([90,0,0]) translate([0,0,-H]) linear_extrude(height=H, convexity=10) profile();
    one_U_hole_pattern();
    translate([25, -2.5+H/2, -50]) shelf_slot();
    one_U_screw_head_clearance();
    translate([40-15/2, 25, -5]) ycyl(l=60,d=5);
    translate([40-15/2, 25, 20]) ycyl(l=60,d=5);
  }
}

shelf_bracket();
translate([100,0,0]) mirror([1,0,0]) shelf_bracket();

%color("yellow") translate([0,0,-3]) rack_ear(1);