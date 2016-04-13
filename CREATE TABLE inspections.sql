CREATE TABLE businesses(
id INT NOT NULL AUTO_INCREMENT,
business_name VARCHAR(255) NOT NULL,
location_address VARCHAR(255) NOT NULL,
location_city VARCHAR(255) NOT NULL,
location_zipcode VARCHAR(255) NOT NULL,
license_number INT NOT NULL,
UNIQUE INDEX (license_number),
PRIMARY KEY (id)
);


CREATE TABLE inspections(
id INT NOT NULL AUTO_INCREMENT,
license_number INT NOT NULL,
inspection_number INT NOT NULL,
visit_number TINYINT NOT NULL,
inspection_class VARCHAR(25) NOT NULL,
inspection_type VARCHAR(255) NOT NULL,
inspection_disposition VARCHAR(255) NOT NULL,
inspection_date DATE NOT NULL,
number_of_critical_violations TINYINT NOT NULL,
number_of_noncritical_violations TINYINT NOT NULL,
number_of_high_priority_violations TINYINT NOT NULL,
number_of_intermediate_violations TINYINT NOT NULL,
number_of_basic_violations TINYINT NOT NULL,
total_number_of_violations TINYINT NOT NULL,
inspection_visit_id INT NOT NULL,
INDEX (license_number),
UNIQUE INDEX (inspection_visit_id),
FOREIGN KEY (license_number) REFERENCES businesses (license_number),
PRIMARY KEY (id)
);

CREATE TABLE inspectionviolations(
id INT NOT NULL AUTO_INCREMENT,
inspection_visit_id INT NOT NULL,
spreadsheet_column VARCHAR(2) NOT NULL,
number_of_violations TINYINT NOT NULL,
INDEX (inspection_visit_id),
FOREIGN KEY (inspection_visit_id) REFERENCES inspections (inspection_visit_id),
PRIMARY KEY (id)
);

CREATE TABLE LOOKUPviolationseverity(
id TINYINT NOT NULL,
violation_severity VARCHAR(25) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE violationdescriptions(
id INT NOT NULL AUTO_INCREMENT,
spreadsheet_column VARCHAR(2) NOT NULL,             
violation_code VARCHAR(50) NOT NULL,
violation_code_description TEXT NOT NULL, 
violation_summary VARCHAR(255) NOT NULL,       
violation_description_rewrite TEXT NOT NULL,
violation_severity TINYINT NOT NULL,
INDEX (violation_severity),
FOREIGN KEY (violation_severity) REFERENCES LOOKUPviolationseverity (id),
PRIMARY KEY (id)
);

INSERT INTO LOOKUPviolationseverity ( id,violation_severity ) VALUES ( 1, 'Basic' );
INSERT INTO LOOKUPviolationseverity ( id,violation_severity ) VALUES ( 2, 'Intermediate' );
INSERT INTO LOOKUPviolationseverity ( id,violation_severity ) VALUES ( 3, 'High Priority' );









INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('W','01B-07-4','High Priority: (A) A food that is unsafe, adulterated, or not honestly presented as specified under Section 3-101.11 shall be discarded or reconditioned according to an approved procedure. Food shall be safe, unadulterated, and, as specified under Section 3-601.12, honestly presented. The division may stop the sale, and supervise the proper destruction, of any food or food product when the director or the director''s designee determines that such food or food product represents a threat to the public safety or welfare.','Approved source','',3);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('X','02C-02-4','Intermediate: (A) Except when packaging food using a reduced oxygen packaging method as specified under Section 3-502.12, and except as specified in (D) and (E) of this section, refrigerated, ready-to-eat, potentially hazardous food (time/temperature control for safety food) prepared and held in a food establishment for more than 24 hours shall be clearly marked to indicate the date or day by which the food shall be consumed on the premises, sold, or discarded when held at a temperature of 41 degrees Fahrenheit or less for a maximum of 7 days. The day of preparation shall be counted as Day 1.','Original container: properly labeled, date marking, consumer advisory','',2);


INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('Y','03B-05-4','High Priority: (A) Except during preparation, cooking, or cooling, or when time is used as the public health control as specified under Section 3-501.19, and except as specified under Paragraph (B) and in Paragraph (C ) of this section, potentially hazardous food (time/temperature control for safety food) shall be maintained:(1) At 135 degrees Fahrenheit or above, except that roasts cooked to a temperature and for a time specified in Paragraph 3-401.11(B) or reheated as specified in Paragraph 3-403.11(E) may be held at a temperature of 130 degrees Fahrenheit or above;','Time and Temperature Control - potentially hazardous/time/temperature control for safety foods (PH/TCS)','',3);


INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('Z','04-01-4','Intermediate: Equipment for cooling and heating food, and holding cold and hot food, shall be sufficient in number and capacity to provide food temperatures as specified under Chapter 3.','Facilities to maintain PH/TCS at the proper temperature','',2);



INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AA','05-08-4','Intermediate: (A) Food temperature measuring devices shall be provided and readily accessible for use in ensuring attainment and maintenance of food temperatures as specified under Chapter 3.','Food and food equipment thermometers provided and accurate','',2);


INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AB','06-01-1','Thawing. Except as specified in Paragraph (D) of this section, potentially hazardous food shall be thawed: (A) Under refrigeration that maintains the food temperature at 41 degrees Fahrenheit or less, or (B) Completely submerged under running water: (1) At a water temperature of 70 degrees Fahrenheit or below, (2) With sufficient water velocity to agitate and float off loose particles in an overflow, and (3) For a period of time that does not allow thawed portions of ready-to-eat food to rise above 41 degrees Fahrenheit or (4) For a period of time that does not allow thawed portions of a raw animal food requiring cooking as specified under Paragraph 3-401.11(A) or (B) to be above 41degrees Fahrenheit for more than 4 hours including: (a) The time the food is exposed to the running water and the time needed for preparation for cooking, or (b) The time it takes under refrigeration to lower the food temperature to 41 degrees Fahrenheit; (C) As part of a cooking process if the food that is frozen is: (1) Cooked as specified under Paragraph 3-401.11(A) or (B) or Section 3-401.12, or (2) Thawed in a microwave oven and immediately transferred to conventional cooking equipment, with no interruption in the process; or (D) Using any procedure if a portion of frozen ready-to-eat food is thawed and prepared for immediate service in response to an individual consumer''s order.','PH/TCS foods properly thawed','',3);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AD','08B-12-4','Basic: (A) Food shall be protected from cross contamination by: (5) Except as specified under Subparagraph 3-501.15(B)(2) and in Paragraph (B) of this section, storing the food in packages, covered containers, or wrappings;','Food protection, cross-contamination','',1);




INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AE','09-01-4','High Priority: (B) Except when washing fruits and vegetables as specified under Section 3-302.15 or as specified in Paragraphs (D) and (E) of this section, food employees may not contact exposed, ready-to-eat food with their bare hands and shall use suitable utensils such as deli tissue, spatulas, tongs, single-use gloves, or dispensing equipment.','Bare hand contact with RTE food; Alternative Operating Procedure (AOP)','',3);


INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AF','10-07-4','Basic: During pauses in food preparation or dispensing, food preparation and dispensing utensils shall be stored: (F) In a container of water if the water is maintained at a temperature of at least 135 degrees Fahrenheit and the container is cleaned at a frequency specified under Subparagraph 4-602.11(D)(7).','In use food dispensing utensils properly stored','',1);




INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AG','11-07-4','Intermediate: The person in charge shall demonstrate to the regulatory authority knowledge of foodborne disease prevention . The person in charge shall demonstrate this knowledge by: Responding correctly to the inspector''s questions as they relate to the specific food operation. Knowledge areas include: Describing the relationship between prevention of foodborne disease and personal hygiene of food employees; Explaining the responsibility of the person in charge for preventing foodborne disease by a food employee who has a medical condition that may cause foodborne disease; Describing the symptoms of foodborne illness; Explaining the responsibilities, rights, and authorities assigned by this Code to the: (a) Food employee, (b) Conditional employee, (c) Person in charge, (d) Regulatory authority; and (17) Explaining how the person in charge, food employees comply with reporting responsibilities and exclusion or restriction of food employees.','Employee health knowledge; ill/symptomatic employee present','',2);



INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AH','12B-12-4','Basic: (B) A food employee may drink from a closed beverage container if the container is handled to prevent contamination of: (1) The employee''s hands; (2) The container; and (3) Exposed food; clean equipment, utensils, and linens; and unwrapped single-service and single-use articles.','Hands washed and clean, good hygienic practices, eating / drinking /smoking','',1);


INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AH','12A-07-4','High Priority: Food employees shall clean their hands and exposed portions of their arms as specified under Section 2-301.12 immediately before engaging in food preparation including working with exposed food, clean equipment and utensils, and unwrapped single-service and single-use articles and: (H) Before donning gloves for working with food;','Hands washed and clean, good hygienic practices, eating / drinking /smoking','',3);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AI','13-03-4','Basic: (A) Except as provided in Paragrpah (B) of this section, food employees shall wear hair restraints such as hats, hair coverings or nets, beard restraints, and clothing that covers body hair, that are designed and worn to effectively keep their hair from contacting exposed food; clean equipment, utensils, and linens; and unwrapped single-service and single-use articles. (B) This section does not apply to food employees such as counter staff who only serve beverages and wrapped or packaged foods, hostesses, and wait staff if they present a minimal risk of contaminating exposed food; clean equipment, utensils, and linens; and unwrapped single-service and single-use articles.','Clean clothes; hair restraints; jewelry; painted/artificial fingernails','',1);


INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AJ','14-12-4','Basic: (A) Utensils shall be maintained in a state of repair or condition that complies with the requirements specified under Parts 4-1 and 4-2 or shall be discarded.','Food-contact and nonfood-contact surfaces designed, constructed, maintained, installed, located','',1);



INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AK','15-17-1','Fixed EQUIPMENT, Spacing or Sealing. (A) EQUIPMENT that is fixed because it is not EASILY MOVABLE shall be installed so that it is: (1) Spaced to allow access for cleaning along the sides, behind, and above the equipment; (2) Spaced from adjoining EQUIPMENT, walls, and ceilings a distance of not more than 1 millimeter or one thirty-second inch; or (3) SEALED to adjoining EQUIPMENT or walls, if the EQUIPMENT is exposed to spillage or seepage. (B) TABLE-MOUNTED EQUIPMENT that is not EASILY MOVABLE shall be installed to allow cleaning of the EQUIPMENT and areas underneath and around the EQUIPMENT by being: (1) SEALED to the table; or (2) Elevated on legs as specified under Paragraph 4-402.12(D).','(No longer used)','',1);


INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AL','16-35-4','Intermediate: A test kit or other device that accurately measures the concentration in mg/L of sanitizing solutions shall be provided.','Dishwashing facilities; chemical test kit(s); gauges','',2);




INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AQ','21-12-4','Basic: (B) Cloths in-use for wiping counters and other equipment surfaces shall be: (1) Held between uses in a chemical sanitizer solution at a concentration specified under Section 4-501.114;','Wiping cloths; clean and soiled linens; laundry facilities','',1);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AR','22-24-4','Intermediate: (E) Except when dry cleaning methods are used as specified under Section 4-603.11, surfaces of utensils and equipment contacting food that is not potentially hazardous (time/temperature control for safety food) shall be cleaned: (1) At any time when contamination may have occurred; (2) At least every 24 hours for iced tea dispensers and consumer self-service utensils such as tongs, scoops, or ladles; (3) Before restocking consumer self-service equipment and utensils such as condiment dispensers and display containers; and (4) In equipment such as ice bins and beverage dispensing nozzles and enclosed components of equipment such as ice makers, cooking oil storage tanks and distribution lines, beverage and syrup dispensing lines or tubes, coffee bean grinders, and water vending equipment: (a) At a frequency specified by the manufacturer, or (b) Absent manufacturer specifications, at a frequency necessary to preclude accumulation of soil or mold.','Food-contact surfaces clean and sanitized','',2);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AS','23-20-4','Basic: Nonfood-contact surfaces of equipment shall be cleaned at a frequency necessary to preclude accumulation of soil residues.','Non-food contact surfaces clean','',1);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AT','24-05-4','Basic: (B) Clean equipment and utensils shall be stored as specified under Paragraph (A) of this section and shall be stored: (1) In a self-draining position that allows air drying; and (2) Covered or inverted.','Storage/handling of clean equipment, utensils; air drying','',1);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AU','25-02-4','Basic: (A) Single-service and single-use articles and cleaned and sanitized utensils shall be handled, displayed, and dispensed so that contamination of food- and lip-contact surfaces is prevented. (B) Knives, forks, and spoons that are not prewrapped shall be presented so that only the handles are touched by employees and by consumers if consumer self-service is provided. (C) Except as specified under Paragraph (B) of this section, single-service articles that are intended for food- or lip-contact shall be furnished for consumer self-service with the original individual wrapper intact or from an approved dispenser.','Single-service and single-use items','',1);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('AY','29-08-4','Basic: (A) Repaired according to law; and (B) Maintained in good repair.','Plumbing installed and maintained; mop sink; water filters; backflow prevention','',1);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('BA','31A-09-4','Intermediate: (A) A handwashing sink shall be maintained so that it is accessible at all times for employee use.','Handwash sinks, handwashing supplies and handwash sign','',2);


INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('BB','32-02-4','Basic: 6-501.19 Except during cleaning and maintenance operations, toilet room doors as specified under Section 6-202.14 shall be kept closed. 6-202.14 FC: Except where a toilet room is located outside a food establishment and does not open directly into the food establishment such as a toilet room that is provided by the management of a shopping mall, a toilet room located on the premises shall be completely enclosed and provided with a tight-fitting and self-closing door. (2)(b) Bathroom facilities shall be completely enclosed and shall have tight-fitting, self-closing doors. Such doors shall not be left open except during cleaning or maintenance. Bathroom facilities located or, in public lodging establishments or located outside a public food service establishment, may have entrances and exits constructed in such a manner as to ensure privacy of occupants.','Bathrooms','',1);


INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('BC','33-16-4','Basic: Receptacles and waste handling units for refuse, recyclables, and returnables shall be kept covered: (A) Inside the food establishment if the receptacles and units: (1) Contain food residue and are not in continuous use; or (2) After they are filled; and (B) With tight-fitting lids or doors if kept outside the food establishment.','Garbage and refuse; premises maintained','',1);


INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('BC','33-11-4','Basic: Drains in receptacles and waste handling units for refuse, recyclables, and returnables shall have drain plugs in place.','Garbage and refuse; premises maintained','',1);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('BE','35A-03-4','High Priority: The operator of any establishment licensed under this chapter shall take effective measures to protect the establishment against the entrance and the breeding on the premises of all vermin. Any room in such an establishment infested with such vermin shall be fumigated, disinfected, renovated, or other corrective action taken until the vermin are exterminated.','No presence or breeding of insects/rodents/pests; no live animals, outer openings protected from insects/pests, rodent proof.','',3);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('BF','36-47-4','Basic: (5) All building structural components, attachments and fixtures shall be kept in good repair, clean and free of obstructions.','Floors, walls, ceilings and attached equipment properly constructed and clean; rooms and equipment properly vented','',1);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('BF','36-24-4','Basic: Physical facilities shall be maintained in good repair.','Floors, walls, ceilings and attached equipment properly constructed and clean; rooms and equipment properly vented','',1);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('BH','38-07-4','Basic: (A) Except as specified in Paragraph (B) of this section, light bulbs shall be shielded, coated, or otherwise shatter-resistant in areas where there is exposed food; clean equipment, utensils, and linens; or unwrapped single-service and single-use articles. (B) Shielded, coated, or otherwise shatter-resistant bulbs need not be used in areas used only for storing food in unopened packages, if: (1) The integrity of the packages cannot be affected by broken glass falling onto them; and (2) The packages are capable of being cleaned of debris from broken bulbs before the packages are opened. (C) An infrared or other heat lamp shall be protected against breakage by a shield surrounding and extending beyond the bulb so that only the face of the bulb is exposed.','Lighting provided as required; fixtures shielded or bulbs protected','',1);


INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('BJ','40-06-4','Basic: (A) Dressing rooms shall be used by employees if the employees regularly change their clothes in the establishment. (B) Lockers or other suitable facilities shall be used for the orderly storage of employee clothing and other possessions.','','',1);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('BK','41-07-4','High Priority: (A) Except for medicines that are stored or displayed for retail sale, only those medicines that are necessary for the health of employees shall be allowed in a food establishment; and 7-207.12 FC: Medicines belonging to employees or to children in a day care center that require refrigeration and are stored in a food refrigerator shall be: (A) Stored in a package or container and kept inside a covered, leakproof container that is identified as a container for the storage of medicines; and (B) Located so they are inaccessible to children.','Chemicals/toxic substances','',3);


INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('BL','42-01-4','Basic: After use, mops shall be placed in a position that allows them to air-dry without soiling walls, equipment, or supplies.','Cleaning and maintenance equip','',1);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('BP','46-03-4','Reporting: (8) Means of access, including entrances, halls, and stairways, must permit unobstructed travel at all times and shall be clean, ventilated and well-lighted day and night. Hall and stair runners shall be kept in good condition. Railways, as defined in 61C-1.001(23), F.A.C., shall be installed on all stairways and around all porches and steps. For reporting purposes only.','Exits not blocked or locked (FOR REPORTING PURPOSES ONLY)','',3);



INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('BU','51-13-4','Basic: (1) Every public food service establishment shall post a sign which illustrates and describes the Heimlich Maneuver procedure for rendering emergency first aid to a choking victim in a conspicuous place in the establishment accessible to employees.','Other conditions sanitary and safe operation','',1);


INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('BW','53B-05-4','Intermediate: It shall be the duty of each public food service establishment to provide training in accordance with the described rule to all food service employees of the public food service establishment. The public food service establishment may designate any certified food service manager to perform this function. Food service employees must receive certification within 60 days after employment. Certification pursuant to this section shall remain valid for 3 years. All public food service establishments must provide the division with proof of employee training upon request, including, but not limited to, at the time of any division inspection of the establishment. Proof of training for each food service employee shall include the name of the trained employee, the date of birth of the trained employee, the date the training occurred, and the approved food safety training program used.','Food management certification valid / Employee training verification','',2);













INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('','','','','',3);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('','','','','',3);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('','','','','',3);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('','','','','',3);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('','','','','',3);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('','','','','',3);

INSERT INTO violationdescriptions (spreadsheet_column,violation_code,violation_code_description,violation_summary,violation_description_rewrite,violation_severity) VALUES ('','','','','',3);
