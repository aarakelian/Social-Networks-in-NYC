*NewEra: cut 15 and >80 yr olds
use "G:\THESIS_Jul22\new_data_jun22\2010-2014\cleandata_newera.dta", clear

**I. VARIABLES CONSTRUCTION 
{
gen year=2010 if adjinc==1094136
replace year=2011 if adjinc==1071861
replace year=2012 if adjinc==1041654
replace year=2013 if adjinc==1024037
replace year=2014 if adjinc==1008425

gen income=pincp*adjinc/1000000
gen logincome=ln(income)

gen age=agep
gen agesq=age^2

gen male=1 if sex==1
replace male=0 if sex==2

gen black=racblk
gen asian=racasn
gen hispanic=1 if hisp!=1
replace hispanic=0 if hisp==1

gen ed=0 if schl<4
replace ed=schl-3 if schl>=4&schl<=14
replace ed=11.5 if schl==15
replace ed=11.75 if schl==17
replace ed=12 if schl==16
replace ed=12.5 if schl==18
replace ed=13 if schl==19
replace ed=14 if schl==20
replace ed=16 if schl==21
replace ed=18 if schl==22
replace ed=19 if schl==23
replace ed=22 if schl==24

gen field_of_degree=1 if (fod1p>=2601&fod1p<=2603)|(fod1p>=3301&fod1p<=3402)|(fod1p>=6000&fod1p<=6099)|fod1p==4801|fod1p==4901|fod1p==6402|fod1p==6403
replace field_of_degree=2 if (fod1p>=4000&fod1p<=4001)|(fod1p>=5200&fod1p<=5299)|(fod1p>=5500&fod1p<=5599)|fod1p==4007
replace field_of_degree=3 if (fod1p>=3600&fod1p<=3699)|(fod1p>=5000&fod1p<=5102)|fod1p==4002|fod1p==4006
replace field_of_degree=4 if (fod1p>=2100&fod1p<=2107)|(fod1p>=3700&fod1p<=3702)|fod1p==4005
replace field_of_degree=5 if fod1p>=6100&fod1p<=6199
replace field_of_degree=6 if fod1p>=6200&fod1p<=6299
replace field_of_degree=7 if field_of_degree==.&fod1p!=.

gen field_of_degree2=1 if (fod2p>=2601&fod2p<=2603)|(fod2p>=3301&fod2p<=3402)|(fod2p>=6000&fod2p<=6099)|fod2p==4801|fod2p==4901|fod2p==6402|fod2p==6403
replace field_of_degree2=2 if (fod2p>=4000&fod2p<=4001)|(fod2p>=5200&fod2p<=5299)|(fod2p>=5500&fod2p<=5599)|fod2p==4007
replace field_of_degree2=3 if (fod2p>=3600&fod2p<=3699)|(fod2p>=5000&fod2p<=5102)|fod2p==4002|fod2p==4006
replace field_of_degree2=4 if (fod2p>=2100&fod2p<=2107)|(fod2p>=3700&fod2p<=3702)|fod2p==4005
replace field_of_degree2=5 if fod2p>=6100&fod2p<=6199
replace field_of_degree2=6 if fod2p>=6200&fod2p<=6299
replace field_of_degree2=7 if field_of_degree2==.&fod2p!=.

gen deginhum=1 if field_of_degree==1| field_of_degree2==1
replace deginhum=0 if deginhum==.
label var deginhum "Degree in Humanities"

gen deginss=1 if field_of_degree==2| field_of_degree2==2
replace deginss=0 if deginss==.
label var deginss "Degree in Social Sciences"

gen deginnats=1 if field_of_degree==3| field_of_degree2==3
replace deginnats=0 if deginnats==.
label var deginnats "Degree in Natural Sciences"

gen deginfors=1 if field_of_degree==4| field_of_degree2==4
replace deginfors=0 if deginfors==.
label var deginfors "Degree in Formal Sciences"

gen deginmeds=1 if field_of_degree==5| field_of_degree2==5
replace deginmeds=0 if deginmeds==.
label var deginmeds "Degree in Medical Sciences"

gen deginbus=1 if field_of_degree==6| field_of_degree2==6
replace deginbus=0 if deginbus==.
label var deginbus "Degree in Business"

gen degother=1 if field_of_degree==7| field_of_degree2==7
replace degother=0 if degother==.
label var degother "Degree in Other"

gen military=1 if mil==1|mil==2|mil==3
replace military=0 if military==.

gen privins=1 if privcov==1
replace privins=0 if privins==.

gen pubins=1 if pubcov==1
replace pubins=0 if pubins==.

drop facrp- wgtp80 fagep - pwgtp80

*Group Identifs
gen puma= puma00 if puma00!=-9
replace puma=puma10 if puma10!=-9

gen ancestry= anc1p05 if anc1p05!=-9
replace ancestry= anc1p12 if anc1p12!=-9

gen o=occp10 if occp10!="N.A."
replace o=occp12 if occp12!="N.A."
replace o="0" if o==""
destring o, gen(occ)
drop o

gen ind=indp
replace ind=0 if ind==.
}
.

*Large Sample
save "G:\THESIS_Jul22\new_data_jun22\2010-2014\largedata_nogroupfx.dta"
*Small Sample
sort puma
by puma: sample 4.06
save "G:\THESIS_Jul22\new_data_jun22\2010-2014\smalldata_nogroupfx.dta"


**II. CREATING GROUP VARS
{
*x
local x age agesq male black asian hispanic ed deginhum deginss deginnats deginfors deginmeds deginbus military privins pubins

gen PUM=puma
gen ANC=ancestry
gen OCC=occ
gen IND=ind
local group_identificators PUM ANC OCC IND

*Making exclusive group means
foreach ident of varlist `group_identificators' {
foreach var of varlist income logincome `x' {
by `ident', sort : egen s = sum(`var')
by `ident', sort : egen c = count(`var')
gen `ident'`var'=(s - `var') / (c - 1)
drop s c
}
}

*Making overlapping group means
*Matrix A
spmat use Wcont using G:\THESIS_Jul22\new_data_jun22\nypuma_15d\derivatives\Wcont.spmat
spmat getmatrix Wcont Wcontmata
mata
st_matrix("A", Wcontmata)
end
matlist A

tab puma, gen(pum)
gen puma_id=1 if pum1==1
forvalues i=2/55 {
replace puma_id=`i' if pum`i'==1
}
drop pum1-pum55

*SP
foreach var of varlist income logincome `x' {
gen SP`var'=.
forvalues i = 1/55 {
gen include=1 if A[`i',puma_id]!=0
replace include=0 if include==.
egen s=sum(include*`var') 
egen c=sum(include)
replace SP`var'=s/c if puma_id==`i'
drop include s c
}
}
*AG
foreach var of varlist income logincome `x' {
gen AG`var'=.
forvalues i=15/95 {
gen include=1 if (age>=`i'-5)&(age<=`i'+5)
replace include=0 if include==.
egen s=sum(include*`var')
egen c=sum(include)
replace AG`var'=(s-`var')/(c-1) if age==`i'
drop include c s
}
}

*Making extra groupings

*OCCIND
foreach var of varlist income logincome `x' {
by occ ind, sort : egen s = sum(`var')
by occ ind, sort : egen c = count(`var')
gen OCCIND`var'=(s - `var') / (c - 1)
drop s c
}

gen citizen=1 if cit!=5
replace citizen=0 if cit==5
gen noncitizen=1 if citizen==0
replace noncitizen=0 if citizen==1

*ANC_CIT
foreach var of varlist income logincome `x' {
by ancestry, sort : egen s = sum(`var'*citizen)
by ancestry, sort : egen c = sum(citizen)
gen ANC_CIT`var'=(s - `var')/(c - 1) if citizen==1
replace ANC_CIT`var'=s/c if citizen==0
drop s c
}
*ANC_NCIT
foreach var of varlist income logincome `x' {
by ancestry, sort : egen s = sum(`var'*noncitizen)
by ancestry, sort : egen c = sum(noncitizen)
gen ANC_NCIT`var'=(s - `var')/(c - 1) if noncitizen==1
replace ANC_NCIT`var'=s/c if noncitizen==0
drop s c
}
*Groupings within-between puma
*ANC_WI
foreach var of varlist income logincome `x' {
gen ANC_WI`var'=.
forvalues i=1/55 {
by ancestry, sort : egen s = sum(`var') if puma_id==`i'
by ancestry, sort : egen c = count(`var') if puma_id==`i'
replace ANC_WI`var'=(s - `var')/(c - 1) if puma_id==`i'
drop s c
}
}
*ANC_BE
foreach var of varlist income logincome `x' {
gen ANC_BE`var'=.
forvalues i=1/55 {
by ancestry, sort: egen m = mean(`var') if puma_id!=`i'
by ancestry, sort: egen mm = mean(m)
replace ANC_BE`var'=mm if puma_id==`i'
drop m mm
}
}
*OCC_WI
foreach var of varlist income logincome `x' {
gen OCC_WI`var'=.
forvalues i=1/55 {
by occ, sort : egen s = sum(`var') if puma_id==`i'
by occ, sort : egen c = count(`var') if puma_id==`i'
replace OCC_WI`var'=(s - `var')/(c - 1) if puma_id==`i'
drop s c
}
}
*OCC_BE
foreach var of varlist income logincome `x' {
gen OCC_BE`var'=.
forvalues i=1/55 {
by occ, sort: egen m = mean(`var') if puma_id!=`i'
by occ, sort: egen mm = mean(m)
replace OCC_BE`var'=mm if puma_id==`i'
drop m mm
}
}
*IND_WI
foreach var of varlist income logincome `x' {
gen IND_WI`var'=.
forvalues i=1/55 {
by ind, sort : egen s = sum(`var') if puma_id==`i'
by ind, sort : egen c = count(`var') if puma_id==`i'
replace IND_WI`var'=(s - `var')/(c - 1) if puma_id==`i'
drop s c
}
}
*IND_BE
foreach var of varlist income logincome `x' {
gen IND_BE`var'=.
forvalues i=1/55 {
by ind, sort: egen m = mean(`var') if puma_id!=`i'
by ind, sort: egen mm = mean(m)
replace IND_BE`var'=mm if puma_id==`i'
drop m mm
}
}
*AGE_WI
foreach var of varlist income logincome `x' {
gen AGE_WI`var'=.
forvalues a=15/95 {
forvalues i=1/55 {
gen include=1 if (age>=`a'-5)&(age<=`a'+5)&puma_id==`i'
replace include=0 if include==.
egen s=sum(`var'*include)
egen c=sum(include)
replace AGE_WI`var'=(s-`var')/(c-1) if age==`a'&puma_id==`i'
drop s c include
}
}
}
*AGE_BE
foreach var of varlist income logincome `x' {
gen AGE_BE`var'=.
forvalues a=15/95 {
forvalues i=1/55 {
gen include=1 if (age>=`a'-5)&(age<=`a'+5)&puma_id!=`i'
replace include=0 if include==.
egen s=sum(`var'*include)
egen c=sum(include)
replace AGE_BE`var'=s/c if age==`a'&puma_id==`i'
drop s c include
}
}
}

}
.

*Large Sample
save "G:\THESIS_Jul22\new_data_jun22\2010-2014\largedata_groupfx.dta"
*Small Sample
save "G:\THESIS_Jul22\new_data_jun22\2010-2014\smalldata_groupfx.dta"

**III. CREATING SPATIAL MATRICES FOR SMALL SAMPLE
{
set matsize 11000
*PUM
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if puma[`i']==puma[`j'] & `i'!=`j' {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_pum=seq()
spmat putmatrix W_PUM C, id(k_pum) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_PUM using W_PUM.spmat
}
.
*OCC
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if occ[`i']==occ[`j'] & `i'!=`j' {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_occ=seq()
spmat putmatrix W_OCC C, id(k_occ) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_OCC using W_OCC.spmat
}
.
*IND
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if ind[`i']==ind[`j'] & `i'!=`j' {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_ind=seq()
spmat putmatrix W_IND C, id(k_ind) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_IND using W_IND.spmat
}
.
*OCCIND
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if occ[`i']==occ[`j'] & ind[`i']==ind[`j'] & `i'!=`j' {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_occind=seq()
spmat putmatrix W_OCCIND C, id(k_occind) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_OCCIND using W_OCCIND.spmat
}
.
*OCC_WI
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if occ[`i']==occ[`j'] & puma[`i']==puma[`j'] & `i'!=`j' {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_occ_wi=seq()
spmat putmatrix W_OCC_WI C, id(k_occ_wi) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_OCC_WI using W_OCC_WI.spmat
}

.
*OCC_BE
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if occ[`i']==occ[`j'] & puma[`i']!=puma[`j'] {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_occ_be=seq()
spmat putmatrix W_OCC_BE C, id(k_occ_be) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_OCC_BE using W_OCC_BE.spmat
}

.
*IND_WI
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if ind[`i']==ind[`j'] & puma[`i']==puma[`j'] & `i'!=`j' {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_ind_wi=seq()
spmat putmatrix W_IND_WI C, id(k_ind_wi) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_IND_WI using W_IND_WI.spmat
}

.
*IND_BE
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if ind[`i']==ind[`j'] & puma[`i']!=puma[`j'] {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_ind_be=seq()
spmat putmatrix W_IND_BE C, id(k_ind_be) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_IND_BE using W_IND_BE.spmat
}

.
*ANC
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if ANC[`i']==ANC[`j'] & `i'!=`j' {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_anc=seq()
spmat putmatrix W_ANC C, id(k_anc) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_ANC using W_ANC.spmat
}
.
*ANC_CIT
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if ANC[`i']==ANC[`j'] & citizen[`j']==1 &`i'!=`j' {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_anc_cit=seq()
spmat putmatrix W_ANC_CIT C, id(k_anc_cit) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_ANC_CIT using W_ANC_CIT.spmat
}
.
*ANC_NCIT
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if ANC[`i']==ANC[`j'] & citizen[`j']==0 &`i'!=`j' {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_anc_ncit=seq()
spmat putmatrix W_ANC_NCIT C, id(k_anc_ncit) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_ANC_NCIT using W_ANC_NCIT.spmat
}
.
*ANC_WI
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if ANC[`i']==ANC[`j'] & puma[`i']==puma[`j'] & `i'!=`j' {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_anc_wi=seq()
spmat putmatrix W_ANC_WI C, id(k_anc_wi) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_ANC_WI using W_ANC_WI.spmat
}

.
*ANC_BE
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if ANC[`i']==ANC[`j'] & puma[`i']!=puma[`j'] {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_anc_be=seq()
spmat putmatrix W_ANC_BE C, id(k_anc_be) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_ANC_BE using W_ANC_BE.spmat
}

.
*AG
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if age[`i'] - age[`j']<=5 & age[`j'] - age[`i']<=5 & `i'!=`j' {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_ag=seq()
spmat putmatrix W_AG C, id(k_ag) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_AG using W_AG.spmat
}
.
*AGE_WI
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if age[`i'] - age[`j']<=5 & age[`j'] - age[`i']<=5 & puma[`i']==puma[`j'] & `i'!=`j' {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_age_wi=seq()
spmat putmatrix W_AGE_WI C, id(k_age_wi) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_AGE_WI using W_AGE_WI.spmat
}
.
*AGE_BE
{
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if age[`i'] - age[`j']<=5 & age[`j'] - age[`i']<=5 & puma[`i']!=puma[`j'] {
matrix C[`i',`j']=1
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_age_be=seq()
spmat putmatrix W_AGE_BE C, id(k_age_be) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_AGE_BE using W_AGE_BE.spmat
}
.
*SP
{
spmat use Wcont using G:\THESIS_Jul22\new_data_jun22\nypuma_15d\derivatives\Wcont.spmat
spmat getmatrix Wcont Wcontmata
mata: st_matrix("A", Wcontmata)
matlist A
spmat use Wdist using G:\THESIS_Jul22\new_data_jun22\nypuma_15d\derivatives\Wdist.spmat
spmat getmatrix Wdist Wdistmata
mata: st_matrix("B", Wdistmata)
matlist B

*SP_A
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if `i'!=`j' {
matrix C[`i',`j']=A[puma_id[`i'], puma_id[`j']]
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_sp_a=seq()
spmat putmatrix W_SP_A C, id(k_sp_a) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_SP_A using W_SP_A.spmat
*SP_B
matrix C=J(10977,10977,.)
forvalues i=1/10977 {
forvalues j=1/10977 {
if `i'!=`j' {
matrix C[`i',`j']=B[puma_id[`i'], puma_id[`j']]
}
else {
matrix C[`i',`j']=0
}
}
}
mata: C=st_matrix("C")
egen k_sp_b=seq()
spmat putmatrix W_SP_B C, id(k_sp_b) normalize(row)
cd C:\Users\botani\Desktop\New_spatial_matrices
spmat save W_SP_B using W_SP_B.spmat
}
.
}
.

*Small Sample
save "G:\THESIS_Jul22\new_data_jun22\2010-2014\smalldata_groupfxk.dta"
