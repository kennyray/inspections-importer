<?php
/*

This file will download all the files from the FTP site, and loop over them, inserting all the data in the DB.

** Be sure to set the user/pass for your db as needed **

** Also, make sure you have run the queries in 'CREATE TABLE inspections.sql' first to set up the db **



*/

error_reporting(E_ALL);
ini_set('display_errors', '1');

set_time_limit(120);

require 'vendor/redbean/rb.php';


function utf8_fopen_read($fileName) { 
    $fc = iconv('windows-1250', 'utf-8', file_get_contents($fileName)); 
    $handle=fopen("php://memory", "rw"); 
    fwrite($handle, $fc); 
    fseek($handle, 0); 
    return $handle; 
} 


$files=array("1fdinspi.csv", "2fdinspi.csv", "3fdinspi.csv", "4fdinspi.csv", "5fdinspi.csv", "6fdinspi.csv", "7fdinspi.csv", );

// set up database connection
R::setup('mysql:host=127.0.0.1;dbname=inspection','inspection','password');
R::freeze(true);

try
{
// Before beginning, delete existing data
R::wipe('inspectionviolations');
R::wipe('inspections');
R::wipe('businesses');
}
catch(exception $e)
{
    echo "Error wiping";
    var_dump($e);

}

echo "File array size: " . count($files) .  "<br />";

foreach ($files as $this_file) 
{
    echo "Working with " . $this_file . "<br />";

    // Get file
    $handle = fopen('php://temp', 'r+');
    $remote = utf8_fopen_read('ftp://dbprftp.state.fl.us/pub/llweb/' . $this_file, 'r');


    if ($remote) 
    {

        
        stream_copy_to_stream($remote, $handle);
        fclose($remote);

        // Reset to start of file
        rewind($handle);


        // Start DB transaction
        R::begin();

        // Watch for errors so we can roll back
        try{

          // wipe was here

            // FIRST LOOP: INSERT ALL BUSINESSES
            $license_buffer="";

            while (($row = fgetcsv($handle)) !== false) {

                $this_license = $row[4];
                $this_name = $row[5];
                $this_address = $row[6];
                $this_city = $row[7];
                $this_zipcode = $row[8];

                // This ensures that we only use each business once
                if($this_license != $license_buffer)
                {

                   // echo $this_name;
                   // echo "<br />***<br />";

                    $business = R::dispense('businesses'); // Use the businesses table
                    $business->business_name    = (string)$this_name;
                    $business->location_address = (string)$this_address;
                    $business->location_city    = (string)$this_city;
                    $business->location_zipcode = (string)$this_zipcode;
                    $business->license_number   = (integer)$this_license;
                    $business->region           = (integer)substr($this_file, 0, 1);
                    
                    $id = R::store($business);  
                    
                }

                // Update name buffer to contain the current business name
                $license_buffer = $this_license;
            }



            // Reset to start of file
            rewind($handle);

            // SECOND LOOP: INSERT ALL INSPECTIONS
            while (($row = fgetcsv($handle)) !== false) {

                $this_license = $row[4];
                $this_inspection_number = $row[9];
                $this_visit_number = $row[10];
                $this_inspection_class = $row[11];
                $this_inspection_type = $row[12];
                $this_inspection_disposition = $row[13];
                $this_inspection_date = $row[14];
                $this_number_critical = $row[15];
                $this_number_noncritical = $row[16];
                $this_total_violations = $row[17];
                $this_high_violations = $row[18];
                $this_intermediate_violations = $row[19];
                $this_basic_violations = $row[20];
                $this_inspection_visit_id = $row[81];

                //echo $this_inspection_date . "<br />";

                // Create a date object from the string taken from CSV, then format it correctly for DB insertion
                $thisdate =  date_format(date_create_from_format('m/d/Y', $this_inspection_date), 'Y-m-d');
                

                $inspection = R::dispense('inspections'); // Use the inspections table
                $inspection->license_number = (integer)$this_license;
                $inspection->inspection_number = (integer)$this_inspection_number;
                $inspection->visit_number = (integer)$this_visit_number;
                $inspection->inspection_class = (string)$this_inspection_class;
                $inspection->inspection_type = (string)$this_inspection_type;
                $inspection->inspection_disposition = (string)$this_inspection_disposition;
                $inspection->inspection_date = $thisdate;
                $inspection->number_of_critical_violations = (integer)$this_number_critical;
                $inspection->number_of_noncritical_violations = (integer)$this_number_noncritical;
                $inspection->total_number_of_violations = (integer)$this_total_violations;
                $inspection->number_of_high_priority_violations = (integer)$this_high_violations;
                $inspection->number_of_intermediate_violations = (integer)$this_intermediate_violations;
                $inspection->number_of_basic_violations = (integer)$this_basic_violations;
                $inspection->inspection_visit_id = (integer)$this_inspection_visit_id;
               
                $id = R::store($inspection);  

            }

            // Reset to start of file
            rewind($handle);
            

            // THIRD LOOP: INSERT ALL INSPECTION VIOLATIONS
            while (($row = fgetcsv($handle)) !== false) {

                $this_inspection_visit_id = $row[81];

                // Loop over the violation columns. W through CB
                for($i=22; $i<=76; $i++)
                {
                    $this_violation_count = $row[$i];

                    // Stop at 26th column, or 25th element in array
                    if ($i <= 25){
                        $prefix = "";
                        $offset = 65;
                    }
                    // Start at 27th, or 26th in array. End at 52nd, or 51st in array 
                    elseif ($i >= 26 && $i <=51) {
                        $prefix = "A";
                        $offset = 39;
                    }
                    // Start at 53rd, or 52nd in array
                    else{
                        $prefix = "B";
                        $offset = 13;
                    }

                    

                    // Only store this one if there is a violation
                    if($this_violation_count > 0)
                    {

                        $inspection_violation = R::dispense('inspectionviolations'); 
                        $inspection_violation->inspection_visit_id = $this_inspection_visit_id;
                        $inspection_violation->spreadsheet_column = $prefix . chr($i + $offset);
                        $inspection_violation->number_of_violations = $this_violation_count;
                        
                        $id = R::store($inspection_violation);                  
                    }
                }
                

            }


             R::commit();
        }
        catch(exception $e)
        {
            echo "OOPS!<BR>";
            echo $e;
            R::rollback();
        }

        fclose($handle);
        
    }
    else
    {
        echo "could not retrieve file " . $this_file;
    }
}
    R::close();