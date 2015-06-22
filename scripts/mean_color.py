#!/usr/bin/python2

import sys
import Image
import ImageStat

def cal_col(col):
    avg = sum(col)/len(col)
    diff = [x - avg for x in col]
    m = min(diff)
    return [int(x - m) for x in diff], (avg/256)*100

def color_name(color, intensity):
    r,g,b = color[:3]
    if max(color) < 0x10:
        return "white" if intensity > 80 else "black" if intensity < 20 else "grey"
    elif max(color) == r:
        if g > r*0.6:
            return "yellow" if intensity > 50 else "dark yellow"
        elif g > r*0.3:
            return "orange" if intensity > 70 else "brown"
        elif b < r*0.6:
            return "magenta" if intensity > 60 else "dark magenta"
        else:
            return "red" if intensity > 60 else "dark red"
    elif max(color) == b:
        if r > b*0.5:
            return "purple" if intensity > 80 else "dark purple"
        elif g > b*0.8:
            return "cyan" if intensity > 70 else "dark cyan"
        else: 
            return "blue" if intensity > 60 else "dark blue"
    elif max(color) == g:
        if r > g*0.7:
            return "yellow" if intensity > 50 else "dark yellow"
        elif b > g*0.5:
            return "teal" if intensity > 50 else "dark teal"
        else:
            return "green" if intensity > 60 else "dark green"
    else:
        return "Unknown"

def main(args):
    if (len(args) > 1):
        im = Image.open(args[1])
        im = im.convert("RGB")
        st = ImageStat.Stat(im)
        color, intensity = cal_col(st.mean[:3])
        if (len(args) > 2 and args[2] == "--intensity"):
            print int(intensity)
        else:
            print color_name(color, intensity)
        #print 'Col: #'+''.join(["%02x " % x for x in color])+' intensity: %i%%' % int((intensity/256)*100)
        #print 'RMS: #'+''.join(["%02x " % x for x in st.rms])
        #print 'dev: #'+''.join(["%02x " % x for x in st.stddev])
        #print 'Med: #'+''.join(["%02x " % x for x in st.median])
        #print 'Mea: #'+''.join(["%02x " % x for x in st.mean])

if __name__ == '__main__':
    main(sys.argv)
