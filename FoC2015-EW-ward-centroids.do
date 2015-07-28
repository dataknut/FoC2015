/*
**************************************************************

STATA code to more or less calculate centroids of England & Wales wards (2013 wards)

In support of #FoC2015: http://festival.yrs.io/

Author: Ben Anderson (b.anderson@soton.ac.uk, @dataknut, https://github.com/dataknut) 
	[Energy & Climate Change, Faculty of Engineering & Environment, University of Southampton]

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License 
(http://choosealicense.com/licenses/gpl-2.0/), or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

#YMMV - http://en.wiktionary.org/wiki/YMMV

*/

global droot "~/Downloads"
global oroot "~/Documents/Work/Projects/FoC2015"

* load example crime data for London wards
insheet using "$oroot/data/London-ward-crime-extract.csv", comma clear
gen wards_needed = 1

* check
duplicates report wd13nm lad13nm

save "$oroot/data/London-ward-crime-extract.dta", replace // for later

* load OA level look up table sourced from ONS at:
* https://t.co/46XP57Vqms
insheet using "$droot/Output_areas_(2011)_to_wards_(2013)_to_local_authority_districts_(2013)_E+W_lookup/OA11_WD13_LAD13_EW_LU.csv", comma clear

* check
li in 1/5

* save it
save "$droot/Output_areas_(2011)_to_wards_(2013)_to_local_authority_districts_(2013)_E+W_lookup/OA11_WD13_LAD13_EW_LU.dta", replace

* load the OA level weighted population estimates sourced from ONS at:
* http://t.co/Rks8ACzepZ
* (it has OA centroids)
use "$droot/Output_areas_(E+W)_2011_Population_Weighted_Centroids_V2/OA_2011_EW_PWC_COORD_V2.dta", clear

* check 
li in 1/5

* yep, OA code = oa11cd in each
* merge them - allow for multiples in using (centroid) data
merge 1:m oa11cd using "$droot/Output_areas_(2011)_to_wards_(2013)_to_local_authority_districts_(2013)_E+W_lookup/OA11_WD13_LAD13_EW_LU.dta", gen(m_matches)

* there were some non-matches
tab m_matches

* 17 of them - probably trivial code change errors, we just want the mean by ward

* BUT there may well be wards with the same names in different places so calculate means within wards & local authorities to be sure
collapse (mean) latitude longitude, by(wd13cd wd13nm lad13nm) // also keep ward code just in case to link to other data

* test
scatter latitude longitude, msize(tiny)

* check against London wards - need to match wards inside correct LAs!
merge 1:1 wd13nm lad13nm using "$oroot/data/London-ward-crime-extract.dta", gen(foc_merge)

tab foc_merge wards_needed, mi

keep if wards_needed == 1

li in 1/10

outsheet using "$oroot/results/EW-wards-2013-lat-long-centroids.csv", comma replace
