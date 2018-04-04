**** Can cultural consumption increase future earnings? Exploring the economic returns to cultural capital 
**** British Journal of Sociology

**** Aaron Reeves and Robert de Vries

**** Analysis file - Understanding Society

/* 
Note:
A seprate set of code files will replicate the analysis in the British Household Panel Survey

The authors are happy to send the data files used in this analysis assuming the request comes from 
someone who has already registered with the UK Data Archive. 

Email: aaron.reeves@spi.ox.ac.uk

*/


**** Import Understanding Society data 
**** Run variable creation file



*** scale reliability
alpha film gallery videoart book streetart carnival circus play opera classical rock ballet contemp african
corr film gallery videoart book streetart carnival circus play opera classical rock ballet contemp african


** table 1
eststo clear
eststo: qui reg fimnlabgrs_dv L.arts_event_v2 if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1, cluster(pidp) vsquish
eststo: qui reg fimnlabgrs_dv L.arts_event_v2 age_cr sex_cr iL.marital L.health if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1, cluster(pidp) vsquish
eststo: qui reg fimnlabgrs_dv L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg iL.classes_v1 i.ftpt L(0/1).hours ///
	car_use if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1, cluster(pidp) vsquish
eststo: qui reg fimnlabgrs_dv L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg iL.classes_v1 i.ftpt L(0/1).hours ///
	car_use L.fimnlabgrs_dv if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1, cluster(pidp) vsquish
eststo: qui reg fimnlabgrs_dv L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg iL.classes_v1 i.ftpt L(0/1).hours ///
	car_use L.fimnlabgrs_dv i.region if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1 , cluster(pidp) vsquish
esttab, replace nogap b(2) se(2) r2(2) compress 


** table 2
eststo clear
eststo: qui reg fimnlabgrs_dv L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg iL.classes_v1 i.ftpt L(0/1).hours ///
	car_use L.fimnlabgrs_dv i.region if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1 , cluster(pidp) vsquish
eststo: qui reg fimnlabgrs_dv L.arts_event_v2  age_cr sex_cr iL.marital L.health iL.eddeg iL.classes_v1 i.ftpt L(0/1).hours ///
	car_use i.region L.fimnlabgrs_dv number_series word_recall numeric_ability verbal_fluency  ///
	if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1, cluster(pidp) vsquish
eststo: qui reg fimnlabgrs_dv L.arts_event_v2 age_cr sex_cr il.marital L.health iL.eddeg il.classes_v1 i.ftpt L(0/1).hours ///
	car_use i.region L.fimnlabgrs_dv big5o_dv big5a_dv big5c_dv big5e_dv big5n_dv if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1, cluster(pidp) vsquish
eststo: qui reg fimnlabgrs_dv L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg iL.classes_v1 i.ftpt L(0/1).hours ///
	car_use i.region L.fimnlabgrs_dv big5o_dv big5a_dv big5c_dv big5e_dv big5n_dv ///
	number_series word_recall numeric_ability verbal_fluency if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1, cluster(pidp) vsquish
esttab, replace nogap b(2) se(2) r2(2) compress 



** table 3
eststo clear
eststo: reg fimnlabgrs_dv L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg iL.classes_v1 i.ftpt L(0/1).hours ///
	car_use L.fimnlabgrs_dv i.region if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1, cluster(pidp) vsquish
eststo: reg fimnlabgrs_dv L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg iL.classes_v1 i.ftpt L(0/1).hours ///
	car_use L.fimnlabgrs_dv i.region il.pat_educ il.mat_educ if fimnlabgrs_dv>0 & L.fimnlabgrs_dv & employ==1 & L.employ==1, cluster(pidp) vsquish
esttab, replace nogap b(2) se(2) r2(2) compress 


** table 4
eststo clear
eststo: logit Lservice L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg il.classes_v1 i.ftpt L(0/1).hours ///
	car_use i.region big5o_dv big5a_dv big5c_dv big5e_dv big5n_dv number_series word_recall ///
	numeric_ability verbal_fluency if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1, or cluster(pidp) vsquish

eststo: logit mobile L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg i.ftpt L(0/1).hours ///
	car_use i.region big5o_dv big5a_dv big5c_dv big5e_dv big5n_dv number_series word_recall ///
	numeric_ability verbal_fluency if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1, or cluster(pidp) vsquish

eststo: logit Lprof L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg i.ftpt L(0/1).hours ///
	car_use i.region big5o_dv big5a_dv big5c_dv big5e_dv big5n_dv number_series word_recall ///
	numeric_ability verbal_fluency if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1, or cluster(pidp) vsquish
esttab, replace nogap b(2) se(2) r2(2) compress 


*** figure 1 - education interaction
qui reg fimnlabgrs_dv iL.arts_event_v2##iL.educ age_cr age_sq sex_cr iL.marital L.health iL.classes_v1 ///
	car_use L.fimnlabgrs_dv i.region if  fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1 , cluster(pidp) vsquish
margins, at(L.educ=(1 2 3 4 5 6) L.arts_event_v2=(0 4)) 
marginsplot , yline(0) title("") xtitle(" ""{bf:Highest educational qualification}") legend(off) ///
	text(1850 2 "Participates in 0 activities") text(2400 4 "Participates in 4 activities") ///
	ytitle("Gross Labour  earnings last month (£)") xlabel(0.4 " " 1 "No qualifications" 2 "Apprenticeship" ///
	3 "GCSEs of equivalent" 4 "A Levels or equivalent" 5 "Further education" 6 "Degree" 6.7 " ", alternate) // cultural participation increases income


*** figure 2 - class interaction
reg fimnlabgrs_dv iL.arts_event_v2##iL.classes_v1 age_cr sex_cr iL.marital L.health iL.eddeg ///
	car_use L.fimnlabgrs_dv i.region if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1, cluster(pidp) vsquish
margins, at(L.classes_v1=(0 1 2 3 4) L.arts_event_v2=(0 4)) atmeans
marginsplot, yline(0) title("") xtitle(" ""{bf:NS-Socio-Economic Class}") legend(off) ///
	text(1850 3 "Participates in 0 activities") text(2400 3 "Participates in 4 activities") ///
	ytitle("Gross Labour earnings last month (£)") xlabel(-0.6 " " 0 "Routine" 1 "Semi-routine" 2 "Lower supervisory" ///
	3 "Intermediate" 4 "Professional" 4.7 " ") // cultural participation increases income


** table 5

eststo: logit Lsupervisor1 L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg il.classes_v1 i.ftpt L(0/1).hours ///
	car_use i.region big5o_dv big5a_dv big5c_dv big5e_dv big5n_dv number_series word_recall ///
	numeric_ability verbal_fluency if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1 & Dsoc_v1==0, or cluster(pidp) vsquish

	
*** Results from BHPS will be show in other code file. 


***** Web Appendix

*** Web Appendix 4
eststo clear
eststo: reg non_lab_inc L.non_lab_inc L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg il.classes_v1 i.ftpt L(0/1).hours ///
	car_use i.region  if non_lab_inc>0 & L.non_lab_inc>0 & employ==1 & L.employ==1, cluster(pidp) vsquish
gen non_lab_income_sample = e(sample)	
eststo: reg fimnlabgrs_dv L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg iL.classes_v1 i.ftpt L(0/1).hours ///
	car_use L.fimnlabgrs_dv i.region if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1 & non_lab_income_sample==1, cluster(pidp) vsquish
esttab, replace nogap b(2) se(2) r2(2) compress 
		

*** Web Appendix 5

** Part A - Brow-level by ratio
eststo: reg fimnlabgrs_dv L.fimnlabgrs_dv L.lowstatus L.highstatus age_cr sex_cr iL.marital L.health iL.eddeg iL.classes_v1 i.ftpt L(0/1).hours ///
	car_use i.region if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1 , cluster(pidp) vsquish

	
** Part B - Comapring dummy variable model of cultural consumption with the LCA model
*** LCA model
eststo: reg fimnlabgrs_dv ib1L.lca age_cr sex_cr iL.marital L.health iL.eddeg iL.classes_v1 i.ftpt L(0/1).hours ///
	car_use L.fimnlabgrs_dv i.region if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1 , cluster(pidp) vsquish
margins l.lca, post 
eststo lca
coefplot, ylabel(1 "Film" 2 "Film, Play, Rock" 3 "Omnivore") xtitle("Gross Labour earnings last month (£)")


eststo: reg fimnlabgrs_dv iL.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg iL.classes_v1 i.ftpt L(0/1).hours ///
	car_use L.fimnlabgrs_dv i.region if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1 , cluster(pidp) vsquish
margins L.arts_event_v2, post
eststo dummy
coefplot, vertical xtitle(Number of cultural activities) xlabel(1 "None" 2 "1 activity" 3 "2 activities" ///
	4 "3 activities" 5 "4 activities" 6 "5 activities" 7 "6 activities") ///
	ytitle("Gross Labour earnings last month (£)")


coefplot lca dummy,  vertical ytitle("Gross Labour earnings last month (£)") ///
	xlabel(1 "Film" 2 "Film, Play, Rock" 3 "Omnivore" 4 "None" 5 "1 activity" 6 "2 activities" ///
	7 "3 activities" 8 "4 activities" 9 "5 activities" 10 "6 activities", angle(45)) ///
	xtitle(" ") text(1900 2 "LCA model") text(1900 7 "Dummy model")  legend(off) 
 	
	
*** web appendix 7: stable soc code
eststo: reg fimnlabgrs_dv L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg iL.classes_v1 i.ftpt L(0/1).hours ///
	car_use L.fimnlabgrs_dv i.region if Dsoc==0 & fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1 , cluster(pidp) vsquish

	
	
*** web appendix: detailed social class
eststo: reg fimnlabgrs_dv L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg iL.nssec i.ftpt L(0/1).hours ///
	car_use L.fimnlabgrs_dv i.region if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1 , cluster(pidp) vsquish

	
*** web appendix 9: logged income
eststo: reg log_labinc L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg iL.classes i.ftpt L(0/1).hours ///
	car_use L.log_labinc i.region if log_labinc>0 & L.log_labinc>0 & employ==1 & L.employ==1 , cluster(pidp) vsquish
		
		
		
*** web appendix 10: remove outliers
eststo clear
eststo: reg labinc L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg iL.classes i.ftpt L(0/1).hours ///
	car_use L.labinc i.region if Dlabinc>-10000 & Dlabinc<10000 & labinc>0 & L.labinc>0 & employ==1 & L.employ==1 , cluster(pidp) vsquish
	
	
	
*** web appendix 11: own account workers
eststo: reg labinc L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg iL.classes_semp i.ftpt L(0/1).hours_v1 ///
	car_use L.labinc i.region if labinc>0 & L.labinc>0 & jbsemp>0 & L.jbsemp>0 , cluster(pidp) vsquish
	
	
*** web appendix 12: all variables
eststo: reg fimnlabgrs_dv L.arts_event_v2 age_cr sex_cr iL.marital L.health iL.eddeg iL.classes i.ftpt L(0/1).hours ///
	car_use i.region L.fimnlabgrs_dv big5o_dv big5a_dv big5c_dv big5e_dv big5n_dv ///
	number_series word_recall numeric_ability verbal_fluency il.pat_educ il.mat_educ ///
	if fimnlabgrs_dv>0 & L.fimnlabgrs_dv>0 & employ==1 & L.employ==1, cluster(pidp) vsquish
	
