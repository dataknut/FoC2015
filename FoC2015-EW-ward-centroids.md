# England & Wales ward centroids

Request for help from @JakeSully123456 via #FoCSOS #FoC2015

Logic is:
 * get your file of ward level data
 * get a table of Output Area level centroids from the ONS ()
 * get an Output Area to Ward look-up table from the ONS ()
 * take the two .csv files from those packages (you can play with the GIS .shp files but that may distract)
 * link the two OA tables using 'oa11cd' watching for potential errors and duplicate records
 * then calculate the mean of the lat/long which is in the centroid file _within_ each ward (wd13nm) and local authority (lad13nm). This is CRUCIAL as there are a lot of wards out there with the same name - e.g. 'Abbey' but none within the same local authority!
 * link the result to your file of ward level data

Hope that:
 * the ward names are (mostly) the same!

 The STATA .do file implements this & it (mostly) works, @JakeSully123456 may have a different (& better!) solution