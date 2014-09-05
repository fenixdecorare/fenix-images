
o=png
j=jpg
r=frames
cps="-strip -interlace Plane -quality 75% -sampling-factor 4:2:0"


while read f
do fex=`basename $f|cut -d"." -f2`
   fba=`basename $f|cut -d"." -f1`
   fdi=`dirname $f`

   fr1=goldthin
   top=$r/${fr1}_top.png
   btm=$r/${fr1}_btm.png
   fw1=`identify -format %h $top`
   fl1=`identify -format %w $top`

   # IM options to 'randomly rolled' the top and bottom pieces
   top="( $top -roll +$(($RANDOM % $fl1))+0 )"
   btm="( $btm -roll +$(($RANDOM % $fl1))+0 )"

   # Frame the image in a single IM command....
   convert $f                 -write mpr:image    +delete \
           $top               -write mpr:edge_top +delete \
           $btm   -rotate 180 -write mpr:edge_btm +delete \
           \
           mpr:image -alpha set -bordercolor none \
           -compose Dst -frame ${fw1}x$fw1+$fw1 -compose over \
             \
             -transverse  -tile mpr:edge_btm \
             -draw 'color 1,0 floodfill' -transpose -draw 'color 1,0 floodfill' \
             -transverse  -tile mpr:edge_top \
             -draw 'color 1,0 floodfill' -transpose -draw 'color 1,0 floodfill' \
             \
           mpr:image -gravity center -composite $cps variantes/$fba-$fr1.$j 
done
