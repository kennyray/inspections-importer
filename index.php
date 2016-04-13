<?php
/*
    This file just grabs the data and dumps it, as a proof that it works.
    Be sure to set the db user/pass as needed for your environment

*/

error_reporting(E_ALL);
ini_set('display_errors', '1');

require 'vendor/redbean/rb.php';

// set up database connection
R::setup('mysql:host=127.0.0.1;dbname=inspection','inspection','password');
R::freeze(true);


$businesses = R::load('businesses', 80);

$inspections = R::find('inspections',
        ' license_number = :haystack ORDER BY :sortorder', 
            array( 
                ':sortorder'=>'ASC', 
                ':haystack'=>$businesses->license_number 
            )
        );
echo "<br /><br /><br /><br /><br />";

var_dump($inspections);
echo '<br />';
echo '<br />';

foreach ($inspections as $inspection) {
    echo 'Inspection Date: ' . $inspection->inspection_date . "<br />";
    echo 'Inspection Number: ' . $inspection->inspection_visit_id . "<br />";
    echo 'Basic Violations: ' . $inspection->number_of_basic_violations . "<br />";
    echo 'Intermediate Violations: ' . $inspection->number_of_intermediate_violations . "<br />";
    echo 'High Priority Violations: ' . $inspection->number_of_high_priority_violations . "<br />";
    echo 'Critical Violations: ' . $inspection->number_of_critical_violations . "<br />";
    echo 'Non-Critical Violations: ' . $inspection->number_of_noncritical_violations . "<br />";

    echo '<br />';
}


echo "<br /><br /><br /><br /><br />";

foreach(R::find('businesses') as $business)
{
    echo $business->business_name . " id:" . $business->id . "<br />";

}





?>