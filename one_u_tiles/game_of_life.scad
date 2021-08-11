/*
A Pulp Logic compatible 1U with cutouts .

modified version of 'opl2_vco.scad'

units: millimeters
*/

use <blank_tile.scad>
use <tile_common.scad>

 // Columns
 col_spacing = 0.585;
 left = inches(0.4);
// Rows
top = inches(1.180);
bottom = inches(0.520);

module cutouts() {
    $fs=0.01; // make cylinder curves more fine

    center = left + inches(col_spacing);
    right = left + 2 * inches(col_spacing);

    // top-left jack
    hole(x=left, z=top, d=inches(0.245));

    // top-center jack
    hole(x=center, z=top, d=inches(0.245));

    // bottom-left jack
    hole(x=left, z=bottom, d=inches(0.245));

    // bottom-center jack
    hole(x=center, z=bottom, d=inches(0.245));

    // screen: http://adafru.it/454
    translate([left + 2 * inches(col_spacing), -1, (top+bottom)/2 - 19.9/2 ] ){
        cube([19.9, 4, 19.9]);
    }
}

// example from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids
module prism(l, w, h){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module snap(w){
    cube([w,9,1]);
    translate([0,5+5.92,0]){
        mirror([0,1,0]){
            prism(w,3,2);
        }
    }
}

module display_snaps(){
    width = 10;
    offset = left + 2 * inches(col_spacing) + 19.9/2 - width/2;
    translate([offset, 0, (top+bottom)/2 - 19.9/2 - 1]){
        snap(width);
    }

    translate([offset , 0, (top+bottom)/2 + 19.9/2 + 1]){
        mirror([0,0,1]){
            snap(width);
        }
    }
}

module encoder_collar(){
    $fs=0.01; // make cylinder curves more fine
    difference(){
        translate([left + 5 * inches(col_spacing), 5, (top+bottom)/2]){
            rotate([90,0,0]){
                cylinder(10, 6, 6, center=true);
            }
        }
        translate([left + 5 * inches(col_spacing), 6, (top+bottom)/2+3]){
            cylinder(6, 1, 1, center=true);
        }
    }
}

module six_jacks() {
    union(){
        difference() {
            union(){
                blank_tile(14);
            }
            cutouts();
        }
        display_snaps();
        
    }
}

six_jacks();
