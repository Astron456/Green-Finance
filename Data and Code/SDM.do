*import data
 import excel "C:\Users\1\Desktop\Study\绿色金融\data.xls", sheet("data") firstrow clear
 
 *固定截面,一定是id在前，year在后！！空间杜宾模型需要
 xtset id year
 
 *regular panal regression,fixed effect
xtreg lndSG lnproGloan3 pgdp lnrEPI lnRDexp lnFDIR,fe
 
 *import W matrix(space weight matrix)
 spatwmat using WM.dta, name(wm)  standardize
 
 *SDM model
xsmle lndSG lnproGloan3 pgdp lnrEPI lnRDexp lnFDIR, wmat(wm) model(sdm) fe type(ind) nsim(500) effects
