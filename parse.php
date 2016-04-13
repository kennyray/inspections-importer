<?php
/*
    Given a visit id, and inspection id, this will grab the html from the 
    state website, and parse the info for each inspection, and return it for display
*/

function getInspectionDetails($iVi,$iId)
{
    $numberOfSections = 0;

    $startOfSection = "<td><font face='verdana' size='-1' color=\"red\">";
    $currentSectionPointer = 0;
    
    $beforeCode = ")\"><u>";
    $codeStartPointer = 0;
    $afterCode = "</u></a></font>";
    $codeEndPointer = 0;

    $beforeDescription = "<font face='verdana' size='-1'>";
    $descriptionStartPointer = 0;
    $afterDescription = "</font>";
    $descriptionEndPointer = 0;

    // Get file
   // $iVi = "4641910";
   // $iId = "2176047";
    $uri = "https://www.myfloridalicense.com/inspectionDetail.asp?InspVisitID=" . $iVi . "&id=" . $iId;


    $fileContents = file_get_contents($uri);

    if ($fileContents) {
        
        $results = array();
        // Find out how many sections (report entries)
        $numberOfSections = substr_count($fileContents, $startOfSection);
        // Set pointer to first section
        $currentSectionPointer = strpos($fileContents, $startOfSection);

        // Loop over each section
        for ($i=0; $i < $numberOfSections ; $i++) { 
        
            // Set pointer for start of code
            $codeStartPointer = strpos($fileContents, $beforeCode, $currentSectionPointer) + strlen($beforeCode);   

            // Set pointer for end of code
            $codeEndPointer = strpos($fileContents, $afterCode, $codeStartPointer);

            // Get code
            $key = substr($fileContents, $codeStartPointer,$codeEndPointer-$codeStartPointer) . "<br />";


            //Set pointer for start of description
            $descriptionStartPointer = strpos($fileContents, $beforeDescription, $codeEndPointer);

            // Set pointer for end of description
            $descriptionEndPointer = strpos($fileContents, $afterDescription, $descriptionStartPointer);

            // Get description
            $val = substr($fileContents, $descriptionStartPointer, $descriptionEndPointer-$descriptionStartPointer);


            $results = array_push_assoc($results, $key, $val);


            $currentSectionPointer = $codeEndPointer;

        }
       
        return $results;

    }
    else
    {
        echo "not.";
    }

}

var_dump(getInspectionDetails(4641910,2176047));

function array_push_assoc(&$array, $key, $value){
$array[$key] = $value;
return $array;
}