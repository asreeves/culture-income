**** Can cultural consumption increase future earnings? Exploring the economic returns to cultural capital 
**** British Journal of Sociology

**** Aaron Reeves and Robert de Vries

**** Variable creation file - Understanding Society

/* 
Note:
A seprate set of code files will replicate the analysis in the British Household Panel Survey
*/


/*
Understanding Society data is available from the UK data archive. 
To recreate the dataset, download waves B and C and merge them together. 

The authors are happy to send the data files used in this analysis assuming the request comes from 
someone who has already registered with the UK Data Archive. 

Email: aaron.reeves@spi.ox.ac.uk

*/


**** Import Understanding Society data 

xtset pidp wave


** Main Independent variable
gen arts_event1 = arts2a1 + arts2a2 + arts2a3 + arts2a4 + arts2a5 + arts2a6 + arts2a7 if arts2a1>=0
gen arts_event2 = arts2b9 + arts2b10 + arts2b11 + arts2b12 + arts2b13 + arts2b14 + arts2b15 if arts2b9>=0
gen arts_event = arts_event1 + arts_event2

recode arts_event (6/14=6), g(arts_event_v2)

** Activity specific variables
gen film = arts2a1 if arts2a1>=0
gen gallery = arts2a2 if arts2a2>=0
gen videoart = arts2a3 if arts2a3>=0
gen book = arts2a4 if arts2a4>=0
gen streetart = arts2a5 if arts2a5>=0
gen carnival = arts2a6 if arts2a6>=0
gen circus = arts2a7 if arts2a7>=0
gen play = arts2b9 if arts2b9>=0
gen opera = arts2b10 if arts2b10>=0
gen classical = arts2b11 if arts2b11>=0
gen rock = arts2b12 if arts2b12>=0
gen ballet = arts2b13 if arts2b13>=0
gen contemp = arts2b14 if arts2b14>=0
gen african = arts2b15 if arts2b15>=0



**** Socio-demographics
** age squared
gen age_sq = age_cr*age_cr

*** Marital status
recode marstat (1=0) (2/3=1) (4/6=2) if marstat>0 & marstat<7, g(marital)

** Health
revrs sf1 
gen health_status = revsf1 if revsf1<6

** Education
revrs hiqual_dv 
gen educ = revhiqual_dv if revhiqual_dv <7
drop revhiqual_dv

recode educ (1=2), g(educ_v1)

recode educ (0/5=0) (6=1), g(eddeg)


** ftpt
gen ftpt = jbft_dv if jbft_dv>0


** sector
gen sector = jbsect if jbsect>0


** Social class
recode jbnssec8_dv (-9 -8=.) (8=0) (7=1) (6=2) (5=.) (4=3) (3=4) (1/2=5), g(classes) 
recode jbnssec8_dv (-9 -8=.) (8=0) (7=1) (6=2) (5=.) (4=3) (1/3=4), g(classes_v1) 
recode jbnssec8_dv (-9 -8=.) (8=0) (7=1) (6=2) (5=3) (4=4) (3=5) (1/2=6), g(classes_semp) 

gen nssec = jbnssec_dv if jbnssec_dv>0



** into service class
recode classes (0/3=0) (4/5=1), g(service)
gen Dservice = D.service
gen Lservice = service-L.service if L.service==0


recode classes (0/3=.) (4=0) (5=1), g(prof)
gen Lprof = prof-L.prof if L.prof==0

gen Lmobile0_1 = classes-L.classes if L.classes==0 & classes<2
gen Lmobile1_2 = classes-L.classes if L.classes==1 & classes<3 & classes>0
gen Lmobile2_3 = classes-L.classes if L.classes==2 & classes<4 & classes>1
gen mobile = Lmobile0_1
replace mobile = 0 if Lmobile1_2==0
replace mobile = 1 if Lmobile1_2==1

replace mobile = 0 if Lmobile2_3==0
replace mobile = 1 if Lmobile2_3==1


*** changing SOC codes
gen soc = jbsoc00_cc if jbsoc00_cc >0

gen Dsoc = D.soc

recode jbsoc00_cc (-9/-1=.) (111/119=1) (120/129=2) (211/221=3) (231/239=4) ///
	(241/249=5) (311/319=6) (321/329=7) (331=8) (341/349=9) (351/359=10) (411/419=11) ///
	(421=12) (511=13) (521/529=14) (531/539=15) (541/549=16) (611/619=17) (621/629=18) ///
	(711/719=19) (721=20) (811/819=21) (821/829=22) (911/919=23) (921/929=24), g(soc_v1)

gen Dsoc_v1 = D.soc_v1
	
recode soc_v1 (1 2 3 4 6 7 8 10=0) (5 9 =1) if soc_v1<11, g(soc_v1_new)	

** hours
gen hours = jbhrs if jbhrs>0

gen hours_v1 = hours
replace hours_v1 = jshrs if jshrs>0	



** total labour income
gen labinc = fimnlabgrs_dv if fimnlabgrs_dv>0
gen log_labinc = log(labinc)
gen Dlabinc = D.labinc 

** non-labour income
gen non_lab_inc = fimngrs_dv-fimnlabgrs_dv


** supervisor
recode jbmngr (3=0) (2=1) (-9/-1=.), g(supervisor1)
gen Lsupervisor1 = supervisor1-L.supervisor1 if L.supervisor1==0


** car use
gen car_use = caruse if caruse>0

** region
gen region = c_gor_dv if c_gor_dv>0
label values region c_gor_dv


** father's education
recode paedqf (-9/-1=0) (97/100=0) (2=1) (3=2) (4=3) (5=4), g(pat_educ)

** mother's education
recode maedqf (-9/-1=0) (97/100=0) (2=1) (3=2) (4=3) (5=4), g(mat_educ)


** number series
gen number_series = .
replace number_series = cgns1sc10_dv if cgns1sc10_dv>0 
replace number_series = cgns2sc10_dv if cgns1sc10_dv<0
mvdecode number_series, mv(-9 -8 -7)

** iq tests
gen word_recall = cgwri_dv if cgwri_dv>=0

gen numeric_ability = cgna_dv if cgna_dv>=0

gen verbal_fluency = cgvfc_dv if cgvfc_dv>=0


*** education ratios

foreach var of varlist  film gallery videoart book streetart carnival circus play opera classical rock ballet contemp african  {
	logit `var' eddeg sex_cr age_cr, or
	}



*** high-status
*** high-status (OR > 4)  = classical, opera, book, gallery
*** lower-status = rock, play, carnival, video art, film, street art
gen highstatus = classical + opera + book + gallery + streetart
gen lowstatus = rock + play + carnival + videoart + film 



**** Merge in data from Latent Class Analysis conducted in R
**** Code to create this data is also available
**** Data can be requested as above. 

merge 1:1 pidp wave using ".../lca.dta"
replace lca = L.lca if wave==2	
drop _merge

	

*** create sample
reg labinc cL.arts_event_v2  age_cr sex_cr iL.marital L.health iL.eddeg iL.classes_v1 i.ftpt L(0/1).hours ///
	car_use L.labinc i.region if labinc>0 & L.labinc>0 & employ==1 & L.employ==1, cluster(pidp) vsquish
gen sample = e(sample)
replace sample =1 if F.sample==1 & wave==1


