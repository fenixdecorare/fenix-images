f1=`basename ${1-qd} .svg` 
wm=${2-25}

brd=/home/hernani/Documents/fenix-brand
b=$brd/base
i=$brd/svg
c=$brd/comp
t=$brd/tmp
o=png
j=jpg
cps="-strip -interlace Plane -quality 75% -sampling-factor 4:2:0"

rsvg-convert -h 200 -a -f png $b/$f1.svg -o $o/$f1-wm.$o

while read f
do fex=`basename $f|cut -d"." -f2`
   fba=`basename $f|cut -d"." -f1`
   fdi=`dirname $f`
   # rezise feito para png so a compisicao final e comprimida
   convert $f -thumbnail '600x600>' -auto-orient -colorspace sRGB $o/$fba.$o
   composite $cps -dissolve $wm% -gravity center \
     $o/$f1-wm.$o $o/$fba.$o base/$fba.$j
done
