#!/bin/sh

# for each svg file
for svg in `find $1 -name *.svg` ; do 

    # the complete filename without the extension
    base=`echo $svg | sed s/.svg//`

    # export each 4 cards
    for i in `seq 4` ; do
        echo "===== ${base}_card_$i ====="
        time inkscape --export-png=${base}_card_$i.png --without-gui --export-id=card_$i --export-height=800 $svg
        echo "===== DONE ====="
    done

    # export the whole page
    echo "===== ${base} ====="
    time inkscape --export-png=$base.png --export-area-page --export-width=1024 --without-gui $svg
    echo "===== DONE ====="
done

