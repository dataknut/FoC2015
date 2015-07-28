# England & Wales ward centroids

Request for help from @JakeSully123456 via #FoCSOS #FoC2015

NB: OA = census Output Area which covers c 100 households or c. 10 postcodes

The same logic will work for LSOAs, MSOAs and even Local Authorities. Much UK govt geo-data is at LSOA level...

Logic is:
 * get your file of ward level data
 * get a table of Output Area level centroids from the ONS (http://www.ons.gov.uk/ons/external-links/social-media/g-m/2011-oa-population-weighted-centroids.html)
 * get an Output Area to Ward look-up table from the ONS (https://geoportal.statistics.gov.uk/Docs/Lookups/Output_areas_(2011)_to_wards_(2013)_to_local_authority_districts_(2013)_E+W_lookup.zip)
 * take the two .csv files from those packages (you can play with the GIS .shp files but that may distract :-)
 * link the two OA tables using 'oa11cd' watching for potential errors and duplicate records
 * then calculate the mean of the lat/long which is in the centroid file _within_ each ward (wd13nm) and local authority (lad13nm). This is CRUCIAL as there are a lot of wards out there with the same name - e.g. 'Abbey' but none within the same local authority. Hopefully.
 * link the result to your file of ward level data

Hope that:
 * the ward names are (mostly) the same!

The accompanying STATA .do file implements this & it (mostly) works, @JakeSully123456 may have a different (& better) solution