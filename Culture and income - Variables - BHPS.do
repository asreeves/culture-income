**** Can cultural consumption increase future earnings? Exploring the economic returns to cultural capital 
**** British Journal of Sociology

**** Aaron Reeves and Robert de Vries

**** Variable creation file - British Household Panel Survey

/* 
Note:
A seprate set of code files will replicate the analysis in Understanding Society
*/


/*
Data on the BHPS are available from the UK Data Archive. 
Users will need to merge data on incmoe, leisure activities and employment history. 
Sample code for creating the data is given here: 

foreach wave in f h j l n p r {
	use `wave'hid `wave'hsownd `wave'rent* `wave'fieqfca `wave'fieqfcb using `wave'hhresp.dta, clear
	sort `wave'hid
	save hhresp`wave', replace
	clear
	
	use `wave'hid `wave'hhch12 `wave'ghq* pid `wave'*wght `wave'tenure `wave'sex `wave'hlghq1 `wave'fihhmn ///
	`wave'hlghq* `wave'xrwght `wave'xewght `wave'age `wave'fisit `wave'fisitc `wave'fisitx ///
	`wave'race `wave'nch* `wave'fenow `wave'hlstat `wave'hllt `wave'hlltw `wave'hlltwa `wave'jbsoc ///
	`wave'fimnl `wave'lact*  `wave'lfsat* `wave'mastat `wave'region `wave'qfedhi `wave'qfachi `wave'paygu `wave'jbseg `wave'jbgold `wave'jbisco ///
	`wave'jbcssf `wave'jbsec `wave'fimn `wave'fiyr `wave'fihhmn `wave'jbiscon using `wave'indresp.dta, clear
	sort `wave'hid
	
	merge m:1 `wave'hid using hhresp`wave'
	keep if _merge==3
	drop _merge
	renpfix `wave'
	if "`wave'" == "p" {
	rename id pid // careful about wave p
	}
	gen wave = index("fhjlnpr","`wave'")
	save cult_`wave', replace
	}

It is also crucial to note that the merged file used for the BHPS analysis contains data 
that I have matched back into the BHPS from USoc. This includes data on IQ, personality, 
and other measures of social position.

The authors are happy to send the data files used in this analysis assuming the request comes from 
someone who has already registered with the UK Data Archive. 

Email: aaron.reeves@spi.ox.ac.uk

*/




xtset pid wave_new

*** Cultural practice
foreach var of varlist zlactb zlactc zlactd zlacte zlactf {
	recode `var' (-9/-1=.) (1/3=1) (4/5=0), g(`var'N)
	}

egen cultural_practice2 = rowtotal(zlactbN zlactcN zlactdN zlacteN zlactfN) 


*** Social class
recode zjbsec (-9/0=.) (131/139=1) (121/129=2) (100/112=3) (80/99=4) (71/79=5) (40/69=6) ///
	(10/39=7), g(class)
recode class (4=.) (5=4) (6=5) (7=6), g(class_new)

*** Age
gen nzage =zage if zage >0

*** Female
gen female = sex-1

*** marital
recode zmastat (-9/-1 8/98=.) (0 6=0) (1 7=1) (2=2) (3 4 5=3), g(marital) 

*** health
recode zhlstat (-9/0=.) (4/5=0) (3=1) (2=2) (1=3), g(health)


*** education
recode zqfachi (-9/0=.) (1/2=1) (3/7=0), g(eddeg)

*** car use
recode zcaruse  (-9/0=.) (2/3=0), g(caruse)


*** promotion
recode jhstpy (-9/-1=0) (3/13=3), g(change_job_reason)


*** first difference in pay
gen Dzpaygu = D.zpaygu if zpaygu>0 & L.zpaygu>0


*** change in soc codes
gen D_jbsoc = D.zjbsoc

** Become a manager
recode zjbmngr (3=0) (2=1) (-9/-1=.), g(supervisor)
gen Dsupervisor = D.supervisor
gen Lsupervisor = supervisor-L.supervisor if L.supervisor==0

** region
gen region = zregion if zregion>=0


*** Sample creation
** gen sample with intelligence
qui reg zpaygu l.zpaygu l.cultural_practice2 l.nzage l.female il.marital l.health ///
	l.eddeg il.class i.caruse i.zregion number_series cgwri_dv cgna_dv cgvfc_dv if ///
	zpaygu>0 & zregion>=0, cluster(pid) vsquish
gen esample = e(sample)
