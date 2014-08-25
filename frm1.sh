image=balto_low.jpg
image_w=`convert $image -format %w info:`
image_h=`convert $image -format %h info:`

top=frames/goldthin_top.png
btm=frames/goldthin_btm.png

width=`convert $top -format %h info:`
length=`convert $top -format %w info:`

# Size of the new image ( using BASH integer maths)
new_size=$(($image_w+$width*2))x$(($image_h+$width*2))

# IM options to read a 'randomly rolled' version for the edge pieces
lft="( $top -roll +$(($RANDOM % $length))+0  -transpose )"
rht="( $btm -roll +$(($RANDOM % $length))+0  -transpose )"

# IM options to 'randomly rolled' the top and bottom pieces
top="( $top -roll +$(($RANDOM % $length))+0 )"
btm="( $btm -roll +$(($RANDOM % $length))+0 )"

# Frame the image in a single IM command....
convert $image             -write mpr:image    +delete \
        $top               -write mpr:edge_top +delete \
        $btm   -rotate 180 -write mpr:edge_btm +delete \
          \
          mpr:image -alpha set -bordercolor none \
          -compose Dst -frame ${width}x$width+$width -compose over \
          \
          -transverse  -tile mpr:edge_btm \
          -draw 'color 1,0 floodfill' -transpose -draw 'color 1,0 floodfill' \
          -transverse  -tile mpr:edge_top \
          -draw 'color 1,0 floodfill' -transpose -draw 'color 1,0 floodfill' \
          \
          mpr:image -gravity center -composite    frame_gold.png
#convert -page +$width+$width  $image  +page -alpha set \
#  \( +clone -compose Dst -bordercolor none -frame ${width}x$width+$width \
#     -fill none -draw "matte 0,0 replace" \
#        -flip   -draw "matte 0,0 replace"   -flip \) \
#  \( $top $btm -append -background none -splice 0x${image_h}+0+$width \
#     -write mpr:horz +delete -size $new_size tile:mpr:horz +size \
#     -clone 1  -compose DstOut -composite \) \
#  \( $lft $rht +append -background none -splice ${image_w}x0+$width+0 \
#     -write mpr:vert +delete -size $new_size tile:mpr:vert +size \
#     -clone 1  -compose DstIn -composite \) \
#  -delete 1  -compose Over  -mosaic   framed_script.png
