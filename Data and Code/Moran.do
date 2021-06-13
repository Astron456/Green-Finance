*import data
use "C:\Users\1\Desktop\Study\绿色金融\moran.dta" 
spatwmat using WM.dta, name(wm)  standardize

*g moran
spatgsa dSG2007,weight(wm) moran twotail
spatgsa dSG2008,weight(wm) moran twotail
spatgsa dSG2009,weight(wm) moran twotail
spatgsa dSG2010,weight(wm) moran twotail
spatgsa dSG2011,weight(wm) moran twotail
spatgsa dSG2012,weight(wm) moran twotail
spatgsa dSG2013,weight(wm) moran twotail
spatgsa dSG2014,weight(wm) moran twotail
spatgsa dSG2015,weight(wm) moran twotail
spatgsa dSG2016,weight(wm) moran twotail
spatgsa dSG2017,weight(wm) moran twotail
spatgsa dSG2018,weight(wm) moran twotail

*graph,year=2011
spatlsa dSG2011,weight(wm) moran graph (moran) symbol(n) twotail
