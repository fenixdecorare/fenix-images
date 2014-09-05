#!/bin/bash

PROGNAME=${0##*/}

usage()
{
  cat << EO
Actualiza fenix images para todos os locais apropriados
EO

  cat <<EO | column -s\& -t

  -h          & show this output
  -l          & actualiza brand da loja
EO
}

# default logos & compositions
f1=qa # fenix.3red
f2=qd # logo-dark.2reds
f3=qc # fenix.5cor

l1=ca # logo-light-red-byfenixdecorare
l2=cb # logo-light-bw-byfenixdecorare
l3=cc # logo-dark-black-tagline

i1=ea # cesto-compras

# operation dirs & output dirs for apps (loja e comunidade)
w="/home/hernani/Documents"
b="$w/fenix-images/base"
m="$w/fenix-images/variantes"
h="$w/as3w/fenix/fdbr/public/fenix-images"
z="$h/base"
x="$h/variantes"

SOPTS="h"
LOPTS=""

ARGS=$(getopt -a -o $SOPTS --name $PROGNAME -- "$@")

eval set -- "$ARGS"

while true; do
    case $1 in
    -h)   usage ; exit 0;;
    --)  shift  ; break;;
    *)   shift  ; break;;
    esac
    shift
done

# loja.fenix

if [ ! -d $z ];then mkdir -p $z;fi
if [ ! -d $x ];then mkdir -p $x;fi

# produtos base & variantes
cp $b/* $z
cp $m/* $x
