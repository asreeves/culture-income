**** Can cultural consumption increase future earnings? Exploring the economic returns to cultural capital 
**** British Journal of Sociology

**** Aaron Reeves and Robert de Vries

**** Analysis file - Britis Household Panle Survey

/* 
Note:
A seprate set of code files will replicate the analysis in the Understanding Society

The authors are happy to send the data files used in this analysis assuming the request comes from 
someone who has already registered with the UK Data Archive. 

Email: aaron.reeves@spi.ox.ac.uk

*/


**** Import BHPS
**** Run variable creation file


** Table 5
logit supervisor l.cultural_practice2 l.nzage l.female il.marital l.health l.eddeg i.caruse ///
	i.region wave_new big5o_dv big5a_dv big5c_dv big5e_dv big5n_dv cgwri_dv cgna_dv cgvfc_dv ///
	if D_jbsoc==0 & l.supervisor==0, cluster(pid) vsquish or 

	
	
** Web Appendix 2
eststo: reg zpaygu l.zpaygu l.cultural_practice2 l.nzage l.female il.marital l.health l.eddeg il.class_new ///
	i.caruse i.region big5o_dv big5a_dv big5c_dv big5e_dv big5n_dv number_series cgwri_dv cgna_dv cgvfc_dv ///
	wave_new if zpaygu>0 & L.zpaygu>0 & zregion>=0 & big5o_dv>0 & esample==1, cluster(pid) vsquish
	
	
** Web Appendix 3
logit change_job_reason l.cultural_practice2 l.nzage l.female il.marital l.health l.eddeg i.caruse i.region ///
	wave_new big5o_dv big5a_dv big5c_dv big5e_dv big5n_dv cgwri_dv cgna_dv cgvfc_dv  if change_job_reason<2 & ///
	zpaygu>0 & L.zpaygu>0 & zregion>=0 , cluster(pid) vsquish or 
	



*** Web Appendix 6
eststo clear
eststo: xtreg zpaygu cultural_practice2 wave_new if zpaygu>0  , fe cluster(pid) 
eststo: xtreg zpaygu cultural_practice2 nzage wave_new if zpaygu>0 , fe cluster(pid) 
eststo: xtreg zpaygu cultural_practice2 nzage health wave_new if zpaygu>0 , fe cluster(pid) 
eststo: xtreg zpaygu cultural_practice2 nzage health class_new wave_new if zpaygu>0  , fe cluster(pid) 
eststo: xtreg zpaygu cultural_practice2 nzage health class_new i.marital wave_new if zpaygu>0  , fe cluster(pid) 
eststo: xtreg zpaygu cultural_practice2 nzage health class_new i.marital caruse wave_new if zpaygu>0 , fe cluster(pid) 
esttab, replace nogap b(2) se(2) r2(2) compress 


** Web Appendix 13
eststo: reg zpaygu l.zpaygu l2.zpaygu l.cultural_practice2 l.nzage l.female il.marital ///
	l.health l.eddeg il.class_new i.caruse i.region wave_new if zpaygu>0 & L.zpaygu>0 ///
	& zregion>=0 , cluster(pid) vsquish
	
	
** Web Appendix 14
reg Dzpaygu l.cultural_practice2 l.nzage l.female il.marital l.health l.eddeg il.class_new ///
	i.caruse i.region wave_new if zpaygu>0 & L.zpaygu>0 & zregion>=0 , cluster(pid) vsquish
	
