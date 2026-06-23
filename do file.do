use ""C:\Users\mjnpo\Documents\dataset\UKDA-9500-stata\stata\stata13\apsp_o24s25_eul_pwta22.dta.dta"", clear
* load in the dataset according to your own file directory 


replace NETWK = . if NETWK == -8
replace NETWK = . if NETWK == -9 
* clean out the answers "does not apply" and "no answer" for the NETWK variable
histogram NETWK 
* histogram of the net weekly pay variable


replace SATIS = . if SATIS == -8
replace SATIS = . if SATIS == -9
* clean out the answers "does not apply" and "no answer" for the SATIS variable
histogram SATIS 
* histogram of the life satisfaction variable

oneway NETWK SATIS, tabulate
* initial ANOVA with no controls 
tabulate NETWK SATIS, chi2 
* check for association between weekly pay and life satisfaction by means of a contingency table 

histogram SEX, discrete xlabel(1 "Man" 2 "Woman") width(0.5)
* histogram of the sex variable
tabulate NETWK SEX, chi2
* confirm that there is an association between weekly pay and gender 
bys SEX: oneway NETWK SATIS, tabulate
* ANOVA conditioning on sex 

histogram QUAL21_1, discrete xlabel(0 "No Degree" 1 "Degree") xtitle("Whether respondant has a degree level qualification or not") width(0.5)
* histogram of whether an individual has a degree level qualification or not
tabulate NETWK QUAL21_1, chi2
* confirm that there is an association between weekly pay and presence of a degree 
bys QUAL21_1: oneway NETWK SATIS, tabulate
* ANOVA conditioning on whether an individual has a degree or not 

replace AGE = 0 if AGE < 40
replace AGE = 0 if AGE > 65
replace AGE = 1 if AGE >= 40 
* transfrom the AGE variable to output 1 if an individual is aged 40-65 (inclusive), and 0 otherwise
histogram AGE, discrete xlabel(0 "Not Middle-Aged" 1 "Middle-Aged") xtitle("Whether respondant is middle-aged or not") width(0.5)
* histogram of the age variable
tabulate NETWK AGE, chi2
* check for association between weekly pay and being middle-aged or not
bys AGE: oneway NETWK SATIS, tabulate 
* ANOVA conditioning on middle-aged or not 


replace LNGLST = . if LNGLST < 0
replace LNGLST = . if LNGLST > 2
drop if LNGLST == .
* clean out the answers "does not apply", "no answer", "don't know", "refusal" for the LNGLST variable
histogram LNGLST, discrete xlabel(1 "Health Condition" 2 "No Health Condition") xtitle("Whether respondant has a long-lasting health condition or not") width(0.5) 
* histogram of the long-lasting health condition variabel
tabulate NETWK LNGLST, chi2
* check for association between weekly pay and presence of a long-lasting health condition 
bys LNGLST: oneway NETWK SATIS, tabulate
* ANOVA conditioing on presence of long-lasting health condition or not 

histogram NETWK, by(SEX)
* histograms of net weekly pay for men and women 
 histogram NETWK, by(QUAL21_1, note("Graphs by whether degree-level qualification or not"))
* histograms of net weekly pay by presence of degree or not
label define agelabel 0 "Not Middle Aged" 1 "Middle Aged"
label values AGE agelabel
histogram NETWK, by(AGE, note("Graphs by whether middle-aged or not"))
* histograms of net weekly pay by middle-aged or not
histogram NETWK, by(LNGLST, note("Graphs by presence of long-lasting health condition")) 
* histograms of net weekly pay by presence of long-lasting health condition 
