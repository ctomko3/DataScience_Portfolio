# List Companies By Sociocultural Attribute
SELECT Company.CO_ID, Company.CO_NAME, SoCulAttrib.SCA_ID, SoCulAttrib.SCA_NAME, SoCulAttrib.SCA_DESC
FROM Company, SoCulAttrib, CoSCALookup
WHERE Company.CO_ID = CoSCALookup.CO_ID AND SoCulAttrib.SCA_ID = CoSCALookup.SCA_ID
GROUP BY SoCulAttrib.SCA_ID;

# List Companies By Location
SELECT Company.CO_ID, Company.CO_NAME, Location.LOC_ID, Location.LOC_NAME, Location.LOC_DESC
FROM Company, Location, CoLocLookup
WHERE Company.CO_ID = CoLocLookup.CO_ID AND Location.loc_ID = CoLocLookup.Loc_ID
GROUP BY Location.LOC.ID;

# List Candidates By Sociocultural Attribute
SELECT Candidate.CAN_ID, Candidate.CAN_NAME, SoCulAttrib.SCA_ID, SoCulAttrib.SCA_NAME, SoCulAttrib.SCA_DESC
FROM Candidate, SoCulAttrib, CanSCALookup
WHERE Candidate.CAN_ID = CanSCALookup.CAN_ID AND SoCulAttrib.SCA_ID = CanSCALookup.SCA_ID
GROUP BY SoCulAttrib.SCA.ID;

# List Candidates By Location
SELECT Candidate.CAN_ID, Candidate.CAN_NAME, Location.LOC_ID, Location.LOC_NAME, Location.LOC_DESC
FROM Candidate, Location, CanLocLookup
WHERE Candidate.CAN_ID = CanLocLookup.CAN_ID AND CanLocLookup.loc_id = Location.loc_id
GROUP BY Location.LOC.ID;

# List Positions And Their Monetary Compensation At A Company That Has A Sociocultural Attribute
SELECT company.co_id, Company.co_name, SoCulAttrib.sca_id, 	SoCulAttrib.sca_name, 	SoCulAttrib.sca_desc, Position.pos_name, MoneyComp.mcomp_item_min
FROM Company, SoCulAttrib, Position, MoneyComp, CoSCALookup
WHERE
	Company.CO_ID = CoSCALookup.co_id
	AND SoCulAttrib.SCA_ID = CoSCALookup.SCA_ID
	AND Company.co_id = Position.co_id
	AND SoCulAttrib.sca_id = '001' 
GROUP BY
	Company.co_id;



# List Sociocultural Attributes By Average Rating by Candidates
SELECT SoCulAttrib.SCA_ID, SoCulAttrib.SCA_NAME, SoCulAttrib.SCA_DESC, AVG(RATING.Rating_level) AS ‘AverageRating’
FROM SoCulAttrib, Rating, CanSCALookup
WHERE Rating.RATING_ID = CanSCALookup.RATING_ID AND SoCulAttrib.SCA_ID = CanSCALookup.SCA ID
GROUP BY SoCulAttrib.SCA_ID;

# List Position By Ascending Monetary Compensation
SELECT Position.POS_NAME, Company.co_id
FROM Position, Benefits, Company, CoBenLookup
WHERE Company.co_id = CoBenLookup.co_id AND Benefits.ben_id = CoBenLookup.ben_id AND Position.co_id = Company.co_id;

# List The Count Of The Sociocultural Attribute By Company
SELECT Company.CO_NAME, SoCulAttrib.sca_name, COUNT(SCA_ID) AS “Count of Sociocultural Attributes”
FROM SoCulAttrib, Company, CoSCALookup
WHERE Company.CO_ID = CoSCALookup.CO_ID AND CoSCALookup.sca_id = SoCulAttrib.sca_id
GROUP BY Company.CO_ID;

# List The Max Monetary Compensation By Candidate's Position
SELECT Candidate.CAN_MAJOR, MAX(MoneyComp.mcomp_item_max ) AS ‘Average Monetary Compensation
FROM Candidate, CoLocLookup, MoneyComp, Position, CanLocLookup
WHERE Candidate.CAN_ID = CanLocLookup.CAN_ID AND CoLocLookup.CO_ID = Position.CO_ID AND MoneyComp.pos_id = Position.pos_id
GROUP BY candidate.CAN_MAJOR;

# List The Traditional Benefit That Has The Max Count By Company
SELECT subquery.CO_NAME, MAX(count_benefit) AS “Max Count of Attribute”
FROM (
	SELECT Company.CO_NAME, COUNT(TBEN_ID) AS “count_benefit”
FROM Company, Benefits, CoBenLookup
WHERE Company.CO_ID = CoBenLookup.CO_ID AND CoBenLookup.ben_id = benefits.ben_id
GROUP BY Company.CO_ID
) AS subquery
GROUP BY subquery.co_name;
