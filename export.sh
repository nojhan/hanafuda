#!/bin/sh

# for each svg file
for svg in `find . -name *.svg` ; do 

    # the complete filename without the extension
    base=`echo $svg | sed s/.svg//`
    
    # export each 4 cards
    for i in `seq 4` ; do
        inkscape --export-png=${base}_card_$i.png --without-gui --export-id=card_$i --export-height=800 $svg
    done

    # export the whole page
    inkscape --export-png=$base.png --export-area-page --export-width=1024 --without-gui $svg
done

