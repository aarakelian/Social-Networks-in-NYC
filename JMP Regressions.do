*Large Sample
use "G:\THESIS_Jul22\new_data_jun22\2010-2014\Notcleansep10.dta", clear
*Small Sample
use "G:\THESIS_Jul22\new_data_jun22\2010-2014\3.8% notcleansep24.dta", clear

**I.a VARLISTS: DepVar Income
{
*omega
local om income
*x
local x age agesq male black asian hispanic ed deginhum deginss deginnats deginfors deginmeds deginbus military privins pubins
*omegabar
local PUMom PUMincome
local OCCom OCCincome
local INDom INDincome
local ANCom ANCincome
local SPom SPincome
local AGom AGincome
local OCCINDom OCCINDincome
local ANC_CITom ANC_CITincome
local ANC_NCITom ANC_NCITincome
local ANC_WIom ANC_WIincome
local ANC_BEom ANC_BEincome
local OCC_WIom OCC_WIincome
local OCC_BEom OCC_BEincome
local IND_WIom IND_WIincome
local IND_BEom IND_BEincome
local AGE_WIom AGE_WIincome
local AGE_BEom AGE_BEincome
*xbar
local PUMx PUMage - PUMpubins 
local OCCx OCCage - OCCpubins 
local INDx INDage - INDpubins  
local ANCx ANCage - ANCpubins  
local SPx SPage - SPpubins 
local AGx AGage - AGpubins 
local OCCINDx OCCINDage - OCCINDpubins 
local ANC_CITx ANC_CITage - ANC_CITpubins 
local ANC_NCITx ANC_NCITage - ANC_NCITpubins 
local ANC_WIx ANC_WIage - ANC_WIpubins
local ANC_BEx ANC_BEage - ANC_BEpubins  
local OCC_WIx OCC_WIage - OCC_WIpubins  
local OCC_BEx OCC_BEage - OCC_BEpubins
local IND_WIx IND_WIage - IND_WIpubins 
local IND_BEx IND_BEage - IND_BEpubins
local AGE_WIx AGE_WIage - AGE_WIpubins 
local AGE_BEx AGE_BEage - AGE_BEpubins 
}
.

**I.b VARLISTS: DepVar LogIncome
{
*omega
local om logincome
*x
local x age agesq male black asian hispanic ed deginhum deginss deginnats deginfors deginmeds deginbus military privins pubins
*omegabar
local PUMom PUMlogincome
local OCCom OCClogincome
local INDom INDlogincome
local ANCom ANClogincome
local SPom SPlogincome
local AGom AGlogincome
local OCCINDom OCCINDlogincome
local ANC_CITom ANC_CITlogincome
local ANC_NCITom ANC_NCITlogincome
local ANC_WIom ANC_WIlogincome
local ANC_BEom ANC_BElogincome
local OCC_WIom OCC_WIlogincome
local OCC_BEom OCC_BElogincome
local IND_WIom IND_WIlogincome
local IND_BEom IND_BElogincome
local AGE_WIom AGE_WIlogincome
local AGE_BEom AGE_BElogincome
*xbar
local PUMx PUMage - PUMpubins 
local OCCx OCCage - OCCpubins 
local INDx INDage - INDpubins  
local ANCx ANCage - ANCpubins  
local SPx SPage - SPpubins 
local AGx AGage - AGpubins 
local OCCINDx OCCINDage - OCCINDpubins 
local ANC_CITx ANC_CITage - ANC_CITpubins 
local ANC_NCITx ANC_NCITage - ANC_NCITpubins 
local ANC_WIx ANC_WIage - ANC_WIpubins
local ANC_BEx ANC_BEage - ANC_BEpubins  
local OCC_WIx OCC_WIage - OCC_WIpubins  
local OCC_BEx OCC_BEage - OCC_BEpubins
local IND_WIx IND_WIage - IND_WIpubins 
local IND_BEx IND_BEage - IND_BEpubins
local AGE_WIx AGE_WIage - AGE_WIpubins 
local AGE_BEx AGE_BEage - AGE_BEpubins 
}
.

*II. REGRESSIONS ON Wy ONLY: Large Sample
{
*One factor:
{ 
*OLS
reg `om' `x', vce(robust)

*One factor:
*Geo
ivregress 2sls `om' `x' (`PUMom' = `PUMx'), vce(robust)
ivregress 2sls `om' `x' (`SPom' = `SPx'), vce(robust)

ivregress 2sls `om' `x' (`PUMom' `SPom' = `PUMx' `SPx'), vce(robust)

*Ancestry
ivregress 2sls `om' `x' (`ANCom' = `ANCx'), vce(robust)
ivregress 2sls `om' `x' (`ANC_CITom' = `ANC_CITx'), vce(robust)
ivregress 2sls `om' `x' (`ANC_NCITom' = `ANC_NCITx'), vce(robust)
ivregress 2sls `om' `x' (`ANC_CITom' `ANC_NCITom' = `ANC_CITx' `ANC_NCITx'), vce(robust)

ivregress 2sls `om' `x' (`ANC_WIom' = `ANC_WIx'), vce(robust)
ivregress 2sls `om' `x' (`ANC_BEom' = `ANC_BEx'), vce(robust)
ivregress 2sls `om' `x' (`ANC_WIom' `ANC_BEom' = `ANC_WIx' `ANC_BEx'), vce(robust)

*Employment
ivregress 2sls `om' `x' (`OCCom' = `OCCx'), vce(robust)
ivregress 2sls `om' `x' (`INDom' = `INDx'), vce(robust)
ivregress 2sls `om' `x' (`OCCINDom' = `OCCINDx'), vce(robust)
ivregress 2sls `om' `x' (`OCCom' `INDom' = `OCCx' `INDx'), vce(robust)
ivregress 2sls `om' `x' (`OCCom' `INDom' `OCCINDom' = `OCCx' `INDx' `OCCINDx')

ivregress 2sls `om' `x' (`OCC_WIom' = `OCC_WIx'), vce(robust)
ivregress 2sls `om' `x' (`OCC_BEom' = `OCC_BEx'), vce(robust)
ivregress 2sls `om' `x' (`OCC_WIom' `OCC_BEom' = `OCC_WIx' `OCC_BEx'), vce(robust)

ivregress 2sls `om' `x' (`IND_WIom' = `IND_WIx'), vce(robust)
ivregress 2sls `om' `x' (`IND_BEom' = `IND_BEx'), vce(robust)
ivregress 2sls `om' `x' (`IND_WIom' `IND_BEom' = `IND_WIx' `IND_BEx'), vce(robust)

ivregress 2sls `om' `x' (`OCC_WIom' `IND_WIom' = `OCC_WIx' `IND_WIx'), vce(robust)
ivregress 2sls `om' `x' (`OCC_WIom' `OCC_BEom' `IND_WIom' `IND_BEom' = `OCC_WIx' `OCC_BEx' `IND_WIx' `IND_BEx'), vce(robust)

*AgeGroup
ivregress 2sls `om' `x' (`AGom' = `AGx'), vce(robust)

ivregress 2sls `om' `x' (`AGE_WIom' = `AGE_WIx'), vce(robust)
ivregress 2sls `om' `x' (`AGE_BEom' = `AGE_BEx'), vce(robust)
ivregress 2sls `om' `x' (`AGE_WIom' `AGE_BEom' = `AGE_WIx' `AGE_BEx'), vce(robust)

}
.
*Combining 2 Factors
{
*Employment and AgeGroup
ivregress 2sls `om' `x' (`OCC_WIom' `OCC_BEom' `IND_WIom' `IND_BEom' `AGE_WIom' `AGE_BEom' = `OCC_WIx' `OCC_BEx' `IND_WIx' `IND_BEx' `AGE_WIx' `AGE_BEx'), vce(robust)
ivregress 2sls `om' `x' (`OCC_WIom' `IND_WIom' `AGE_WIom' = `OCC_WIx' `IND_WIx' `AGE_WIx'), vce(robust)
ivregress 2sls `om' `x' (`OCC_WIom' `OCC_BEom' `AGE_WIom' `AGE_BEom' = `OCC_WIx' `OCC_BEx' `AGE_WIx' `AGE_BEx'), vce(robust)
ivregress 2sls `om' `x' (`OCC_WIom' `AGE_WIom' = `OCC_WIx' `AGE_WIx'), vce(robust)
ivregress 2sls `om' `x' (`OCCom' `INDom' `OCCINDom' `AGE_WIom' `AGE_BEom' = `OCCx' `INDx' `OCCINDx' `AGE_WIx' `AGE_BEx')
ivregress 2sls `om' `x' (`OCCom' `INDom' `OCCINDom' `AGE_WIom' = `OCCx' `INDx' `OCCINDx' `AGE_WIx')
ivregress 2sls `om' `x' (`OCCINDom' `AGE_WIom' `AGE_BEom' = `OCCINDx' `AGE_WIx' `AGE_BEx')
ivregress 2sls `om' `x' (`OCCINDom' `AGE_WIom' = `OCCINDx' `AGE_WIx')

*Employment and Ancestry
ivregress 2sls `om' `x' (`OCC_WIom' `OCC_BEom' `IND_WIom' `IND_BEom' `ANC_WIom' `ANC_BEom' = `OCC_WIx' `OCC_BEx' `IND_WIx' `IND_BEx' `ANC_WIx' `ANC_BEx'), vce(robust)
ivregress 2sls `om' `x' (`OCC_WIom' `IND_WIom' `ANC_WIom' = `OCC_WIx' `IND_WIx' `ANC_WIx'), vce(robust)
ivregress 2sls `om' `x' (`OCC_WIom' `OCC_BEom' `ANC_WIom' `ANC_BEom' = `OCC_WIx' `OCC_BEx' `ANC_WIx' `ANC_BEx'), vce(robust)
ivregress 2sls `om' `x' (`OCC_WIom' `ANC_WIom' = `OCC_WIx' `ANC_WIx'), vce(robust)
ivregress 2sls `om' `x' (`OCCom' `INDom' `OCCINDom' `ANC_WIom' `ANC_BEom' = `OCCx' `INDx' `OCCINDx' `ANC_WIx' `ANC_BEx')
ivregress 2sls `om' `x' (`OCCom' `INDom' `OCCINDom' `ANC_WIom' = `OCCx' `INDx' `OCCINDx' `ANC_WIx')
ivregress 2sls `om' `x' (`OCCINDom' `ANC_WIom' `ANC_BEom' = `OCCINDx' `ANC_WIx' `ANC_BEx')
ivregress 2sls `om' `x' (`OCCINDom' `ANC_WIom' = `OCCINDx' `ANC_WIx')

*Employment and Geo
ivregress 2sls `om' `x' (`OCCom' `INDom' `OCCINDom' `PUMom' = `OCCx' `INDx' `OCCINDx' `PUMx')
ivregress 2sls `om' `x' (`OCCom' `INDom' `OCCINDom' `PUMom' `SPom' = `OCCx' `INDx' `OCCINDx' `PUMx' `SPx')
ivregress 2sls `om' `x' (`OCC_WIom' `IND_WIom' `PUMom' = `OCC_WIx' `IND_WIx' `PUMx')
ivregress 2sls `om' `x' (`OCC_WIom' `IND_WIom' `PUMom' `SPom' = `OCC_WIx' `IND_WIx' `PUMx' `SPx')

*Age and Ancestry
ivregress 2sls `om' `x' (`AGE_WIom' `AGE_BEom' `ANC_WIom' `ANC_BEom' = `AGE_WIx' `AGE_BEx' `ANC_WIx' `ANC_BEx')
ivregress 2sls `om' `x' (`AGE_WIom' `ANC_WIom' = `AGE_WIx' `ANC_WIx')

*Age and Geo
ivregress 2sls `om' `x' (`AGE_WIom' `AGE_BEom' `PUMom' = `AGE_WIx' `AGE_BEx' `PUMx')
ivregress 2sls `om' `x' (`AGE_WIom' `SPom' = `AGE_WIx' `SPx')

*Ancestry and Geo
ivregress 2sls `om' `x' (`ANC_WIom' `ANC_BEom' `PUMom' = `ANC_WIx' `ANC_BEx' `PUMx')
ivregress 2sls `om' `x' (`ANC_WIom' `SPom' = `ANC_WIx' `SPx')
}
.
*Combining 3 and 4 factors
{
ivregress 2sls `om' `x' (`OCC_WIom' `IND_WIom' `AGE_WIom' `ANC_WIom' = `OCC_WIx' `IND_WIx' `AGE_WIx' `ANC_WIx'), vce(robust)
ivregress 2sls `om' `x' (`OCC_WIom' `IND_WIom' `AGE_WIom' `ANC_WIom' `PUMom'= `OCC_WIx' `IND_WIx' `AGE_WIx' `ANC_WIx' `PUMx'), vce(robust)
ivregress 2sls `om' `x' (`OCC_WIom' `IND_WIom' `AGE_WIom' `ANC_WIom' `SPom'= `OCC_WIx' `IND_WIx' `AGE_WIx' `ANC_WIx' `SPx'), vce(robust)
ivregress 2sls `om' `x' (`OCC_WIom' `OCC_BEom' `IND_WIom' `IND_BEom' `ANC_WIom' `ANC_BEom' `AGE_WIom' `AGE_BEom' = `OCC_WIx' `OCC_BEx' `IND_WIx' `IND_BEx' `ANC_WIx' `ANC_BEx' `AGE_WIx' `AGE_BEx'), vce(robust)
ivregress 2sls `om' `x' (`OCC_WIom' `OCC_BEom' `IND_WIom' `IND_BEom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `OCC_BEx' `IND_WIx' `IND_BEx' `ANC_WIx' `AGE_WIx'), vce(robust)
}
.
}
.

*Loading spatial matrices: Small Sample
{
cd C:\Users\botani\Desktop\New_spatial_matrices
*or G:\THESIS_Jul22\new_data_jun22\New_spatial_matrices
spmat use W_PUM using W_PUM.spmat
spmat use W_SP_A using W_SP_A.spmat
spmat use W_SP_B using W_SP_B.spmat

spmat use W_OCC using W_OCC.spmat
spmat use W_IND using W_IND.spmat
spmat use W_OCCIND using W_OCCIND.spmat
spmat use W_OCC_WI using W_OCC_WI.spmat
spmat use W_OCC_BE using W_OCC_BE.spmat
spmat use W_IND_WI using W_IND_WI.spmat
spmat use W_IND_BE using W_IND_BE.spmat

spmat use W_ANC using W_ANC.spmat
spmat use W_ANC_CIT using W_ANC_CIT.spmat
spmat use W_ANC_NCIT using W_ANC_NCIT.spmat
spmat use W_ANC_WI using W_ANC_WI.spmat
spmat use W_ANC_BE using W_ANC_BE.spmat

spmat use W_AG using W_AG.spmat
spmat use W_AGE_WI using W_AGE_WI.spmat
spmat use W_AGE_BE using W_AGE_BE.spmat
}
.

*III. REGRESSIONS ON Wepsilon ONLY: Small Sample
{
spreg gs2sls `om' `x', id(k_pum) elmat(W_PUM)
spreg gs2sls `om' `x', id(k_sp_a) elmat(W_SP_A)
spreg gs2sls `om' `x', id(k_sp_b) elmat(W_SP_B)

spreg gs2sls `om' `x', id(k_occ) elmat(W_OCC)
spreg gs2sls `om' `x', id(k_ind) elmat(W_IND)
spreg gs2sls `om' `x', id(k_occind) elmat(W_OCCIND)
spreg gs2sls `om' `x', id(k_occ_wi) elmat(W_OCC_WI)
spreg gs2sls `om' `x', id(k_occ_be) elmat(W_OCC_BE)
spreg gs2sls `om' `x', id(k_ind_wi) elmat(W_IND_WI)
spreg gs2sls `om' `x', id(k_ind_be) elmat(W_IND_BE)

spreg gs2sls `om' `x', id(k_anc) elmat(W_ANC)
spreg gs2sls `om' `x', id(k_anc_cit) elmat(W_ANC_CIT)
spreg gs2sls `om' `x', id(k_anc_ncit) elmat(W_ANC_NCIT)
spreg gs2sls `om' `x', id(k_anc_wi) elmat(W_ANC_WI)
spreg gs2sls `om' `x', id(k_anc_be) elmat(W_ANC_BE)

spreg gs2sls `om' `x', id(k_ag) elmat(W_AG)
spreg gs2sls `om' `x', id(k_age_wi) elmat(W_AGE_WI)
spreg gs2sls `om' `x', id(k_age_be) elmat(W_AGE_BE)
}
.

*Extra prepping: no missing values
local Wx `PUMx' `OCCx' `INDx' `ANCx' `SPx' `AGx' `OCCINDx' `ANC_CITx' `ANC_NCITx' `ANC_WIx' `ANC_BEx' `OCC_WIx' `OCC_BEx' `IND_WIx' `IND_BEx' `AGE_WIx' `AGE_BEx'
local Wom `PUMom' `OCCom' `INDom' `ANCom' `SPom' `AGom' `OCCINDom' `ANC_CITom' `ANC_NCITom' `ANC_WIom' `ANC_BEom' `OCC_WIom' `OCC_BEom' `IND_WIom' `IND_BEom' `AGE_WIom' `AGE_BEom'
foreach v of varlist `Wx' `Wom' {
replace `v'=0 if `v'==.
}
.


*IV. REGRESSIONS ON BOTH Wy AND Wepsilon: Small Sample
{
spivreg `om' `x' (`OCC_WIom' `IND_WIom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `IND_WIx' `ANC_WIx' `AGE_WIx'), id(k_pum) elmat(W_PUM) het
spivreg `om' `x' (`OCC_WIom' `IND_WIom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `IND_WIx' `ANC_WIx' `AGE_WIx'), id(k_sp_a) elmat(W_SP_A) het

spivreg `om' `x' (`OCC_WIom' `IND_WIom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `IND_WIx' `ANC_WIx' `AGE_WIx'), id(k_occ_wi) elmat(W_OCC_WI) het
spivreg `om' `x' (`OCC_WIom' `IND_WIom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `IND_WIx' `ANC_WIx' `AGE_WIx'), id(k_ind_wi) elmat(W_IND_WI) het
spivreg `om' `x' (`OCC_WIom' `IND_WIom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `IND_WIx' `ANC_WIx' `AGE_WIx'), id(k_anc_wi) elmat(W_ANC_WI) het
spivreg `om' `x' (`OCC_WIom' `IND_WIom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `IND_WIx' `ANC_WIx' `AGE_WIx'), id(k_age_wi) elmat(W_AGE_WI) het

spivreg `om' `x' (`IND_WIom' `ANC_WIom' `AGE_WIom' = `IND_WIx' `ANC_WIx' `AGE_WIx'), id(k_occ_wi) elmat(W_OCC_WI) het
spivreg `om' `x' (`OCC_WIom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `ANC_WIx' `AGE_WIx'), id(k_ind_wi) elmat(W_IND_WI) het
spivreg `om' `x' (`OCC_WIom' `IND_WIom' `AGE_WIom' = `OCC_WIx' `ANC_WIx' `AGE_WIx'), id(k_anc_wi) elmat(W_ANC_WI) het
spivreg `om' `x' (`OCC_WIom' `IND_WIom' `ANC_WIom' = `OCC_WIx' `IND_WIx' `ANC_WIx'), id(k_age_wi) elmat(W_AGE_WI) het

spivreg `om' `x' (`OCC_WIom' `IND_WIom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `IND_WIx' `ANC_WIx' `AGE_WIx'), id(k_occ_be) elmat(W_OCC_BE) het
spivreg `om' `x' (`OCC_WIom' `IND_WIom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `IND_WIx' `ANC_WIx' `AGE_WIx'), id(k_ind_be) elmat(W_IND_BE) het
spivreg `om' `x' (`OCC_WIom' `IND_WIom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `IND_WIx' `ANC_WIx' `AGE_WIx'), id(k_anc_be) elmat(W_ANC_BE) het
spivreg `om' `x' (`OCC_WIom' `IND_WIom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `IND_WIx' `ANC_WIx' `AGE_WIx'), id(k_age_be) elmat(W_AGE_BE) het

spivreg `om' `x' (`OCC_WIom' `OCC_BEom' `IND_WIom' `IND_BEom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `OCC_BEx' `IND_WIx' `IND_BEx' `ANC_WIx' `AGE_WIx'), id(k_occ_wi) elmat(W_OCC_WI) het
spivreg `om' `x' (`OCC_WIom' `OCC_BEom' `IND_WIom' `IND_BEom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `OCC_BEx' `IND_WIx' `IND_BEx' `ANC_WIx' `AGE_WIx'), id(k_occ_be) elmat(W_OCC_BE) het
spivreg `om' `x' (`OCC_WIom' `OCC_BEom' `IND_WIom' `IND_BEom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `OCC_BEx' `IND_WIx' `IND_BEx' `ANC_WIx' `AGE_WIx'), id(k_ind_wi) elmat(W_IND_WI) het
spivreg `om' `x' (`OCC_WIom' `OCC_BEom' `IND_WIom' `IND_BEom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `OCC_BEx' `IND_WIx' `IND_BEx' `ANC_WIx' `AGE_WIx'), id(k_ind_be) elmat(W_IND_BE) het
spivreg `om' `x' (`OCC_WIom' `OCC_BEom' `IND_WIom' `IND_BEom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `OCC_BEx' `IND_WIx' `IND_BEx' `ANC_WIx' `AGE_WIx'), id(k_anc_wi) elmat(W_ANC_WI) het
spivreg `om' `x' (`OCC_WIom' `OCC_BEom' `IND_WIom' `IND_BEom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `OCC_BEx' `IND_WIx' `IND_BEx' `ANC_WIx' `AGE_WIx'), id(k_age_wi) elmat(W_AGE_WI) het

spivreg `om' `x' (`OCC_BEom' `IND_WIom' `IND_BEom' `ANC_WIom' `AGE_WIom' = `OCC_BEx' `IND_WIx' `IND_BEx' `ANC_WIx' `AGE_WIx'), id(k_occ_wi) elmat(W_OCC_WI) het
spivreg `om' `x' (`OCC_WIom' `IND_WIom' `IND_BEom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `IND_WIx' `IND_BEx' `ANC_WIx' `AGE_WIx'), id(k_occ_be) elmat(W_OCC_BE) het
spivreg `om' `x' (`OCC_WIom' `OCC_BEom' `IND_BEom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `OCC_BEx' `IND_BEx' `ANC_WIx' `AGE_WIx'), id(k_ind_wi) elmat(W_IND_WI) het
spivreg `om' `x' (`OCC_WIom' `OCC_BEom' `IND_WIom' `ANC_WIom' `AGE_WIom' = `OCC_WIx' `OCC_BEx' `IND_WIx' `ANC_WIx' `AGE_WIx'), id(k_ind_be) elmat(W_IND_BE) het
spivreg `om' `x' (`OCC_WIom' `OCC_BEom' `IND_WIom' `IND_BEom' `AGE_WIom' = `OCC_WIx' `OCC_BEx' `IND_WIx' `IND_BEx' `AGE_WIx'), id(k_anc_wi) elmat(W_ANC_WI) het
spivreg `om' `x' (`OCC_WIom' `OCC_BEom' `IND_WIom' `IND_BEom' `ANC_WIom' = `OCC_WIx' `OCC_BEx' `IND_WIx' `IND_BEx' `ANC_WIx'), id(k_age_wi) elmat(W_AGE_WI) het
}
.
