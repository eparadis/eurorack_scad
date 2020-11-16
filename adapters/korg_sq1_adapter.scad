
use <../one_u_tiles/tile_common.scad>;

module cutouts(){
    $fs=0.1; // min feature size - increases arc quality

    // two mounting holes for the eurorack
    left = 3;
    hole(x=left, z=4.5, d=3);
    hole(x=left+5.08*3, z=4.5, d=3);

    // hole to mount Korg front panel screws
    hole(x=12, z=15, d=2.5);
}

module positive() {
    cube([21,2,20]);
}

difference() {
    positive();
    cutouts();
}