f1=`basename ${1-qd} .svg` 
wm=${2-25}

brd=/home/hernani/Documents/fenix-brand
b=$brd/base
i=$brd/svg
c=$brd/comp
t=$brd/tmp
o=png
j=jpg

rsvg-convert -h 200 -a      -f png $b/$f1.svg -o $t/$f1-wm.$o

while read f
do fex=`basename $f|cut -d"." -f2`
   fba=`basename $f|cut -d"." -f1`
   fdi=`dirname $f`
   #echo "File: $f $fba $fdi $fex"
   #fwi=`identify -format "%w" $f`
   #fhi=`identify -format "%h" $f`
   #fwi=`expr $fwi / 2`
   #fhi=`expr 600 / 4`
   convert $f -thumbnail '600x600>' -auto-orient -colorspace sRGB $t/$fba.$o
   #rsvg-convert -h $fhi -a      -f png $b/$f1.svg -o $t/$f1-wm.$o
   composite -dissolve $wm% -gravity center \
     $t/$f1-wm.$o $t/$fba.$o base/$fba.$o 
done
