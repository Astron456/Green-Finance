clear all
*import data
 import excel "C:\Users\zhangxinyi\OneDrive\桌面\File 大三\绿色金融\data.xls", sheet("data") firstrow clear
 

xtset id year
gen lnrEPI = log(rEPI)
 
qui sum lndSG
replace lndSG=(lndSG-r(min))/(r(max)-r(min))

qui sum lnproGloan3
replace lnproGloan3=(lnproGloan3-r(min))/(r(max)-r(min))

qui sum pgdp
replace pgdp=(pgdp-r(min))/(r(max)-r(min))

qui sum lnrEPI
replace lnrEPI=(lnrEPI-r(min))/(r(max)-r(min))

qui sum lnRDexp
replace lnRDexp=(lnRDexp-r(min))/(r(max)-r(min))

qui sum lnFDIR
replace lnFDIR=(lnFDIR-r(min))/(r(max)-r(min))
 
 *regular panal regression,fixed effect
  reg lndSG lnproGloan3 pgdp lnrEPI lnRDexp lnFDIR
xtreg lndSG lnproGloan3 pgdp lnrEPI lnRDexp lnFDIR,re
est store re
xtreg lndSG lnproGloan3 pgdp lnrEPI lnRDexp lnFDIR,fe
est store fe
hausman fe re

xtreg lnRDexp lnproGloan3 pgdp lnrEPI lnFDIR,fe

 *import W matrix(space weight matrix)
 spatwmat using WM.dta, name(wm)  standardize
 
 *SDM model
xsmle lndSG lnproGloan3 pgdp lnrEPI lnRDexp lnFDIR, wmat(wm) model(sdm) fe type(ind) nsim(500) effects
