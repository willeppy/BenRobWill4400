/* 
----- CITY LIST -----
*/
SELECT * from
(select CityEID, CityName, ave, coun, attr from (select CityName, avg(Rating) as ave, count(Rating) as coun, CityEID  from (
                (select * from rateacity.city join rateacity.reviewable_entity where IsPending=0 AND CityEID=EntityID) as filter) join
                RATEACITY.review where ReviewableEID=CityEID group by CityEid) as c natural left join
                (select CityEid, count(attractionEID) as attr from rateacity.attraction group by CityEID) as final) AS Result
ORDER BY CityName;

SELECT * from
(select CityEID, CityName, ave, coun, attr from (select CityName, avg(Rating) as ave, count(Rating) as coun, CityEID  from (
                (select * from rateacity.city join rateacity.reviewable_entity where IsPending=0 AND CityEID=EntityID) as filter) join
                RATEACITY.review where ReviewableEID=CityEID group by CityEid) as c natural left join
                (select CityEid, count(attractionEID) as attr from rateacity.attraction group by CityEID) as final) AS Result
ORDER BY CityEID;
SELECT * from
(select CityEID, CityName, ave, coun, attr from (select CityName, avg(Rating) as ave, count(Rating) as coun, CityEID  from (
                (select * from rateacity.city join rateacity.reviewable_entity where IsPending=0 AND CityEID=EntityID) as filter) join
                RATEACITY.review where ReviewableEID=CityEID group by CityEid) as c natural left join
                (select CityEid, count(attractionEID) as attr from rateacity.attraction group by CityEID) as final) AS Result
ORDER BY ave;
SELECT * from
(select CityEID, CityName, ave, coun, attr from (select CityName, avg(Rating) as ave, count(Rating) as coun, CityEID  from (
                (select * from rateacity.city join rateacity.reviewable_entity where IsPending=0 AND CityEID=EntityID) as filter) join
                RATEACITY.review where ReviewableEID=CityEID group by CityEid) as c natural left join
                (select CityEid, count(attractionEID) as attr from rateacity.attraction group by CityEID) as final) AS Result
ORDER BY coun;
SELECT * from
(select CityEID, CityName, ave, coun, attr from (select CityName, avg(Rating) as ave, count(Rating) as coun, CityEID  from (
                (select * from rateacity.city join rateacity.reviewable_entity where IsPending=0 AND CityEID=EntityID) as filter) join
                RATEACITY.review where ReviewableEID=CityEID group by CityEid) as c natural left join
                (select CityEid, count(attractionEID) as attr from rateacity.attraction group by CityEID) as final) AS Result
ORDER BY attr;


/* 
----- NEW CITY FORM -----
*/

/*
----- SAMPLE CITY PAGE -----
*/
/**Pulls data for specific city for City Page */
/*TO DO: Get specific city's information*/

(SELECT CityName, AttractionName, StreetAddress, Country, State, CName, AvgRating, NumRatings FROM
(Select CityName, AttractionEID, AttractionName, StreetAddress, Country, State, CName
FROM RateACity.Attraction NATURAL JOIN RateACity.City 
	NATURAL JOIN RateACity.FALLS_UNDER 
	NATURAL JOIN RateACity.Category
)AS U JOIN 

(SELECT EntityID, Avg(Rating) AS AvgRating, Count(Rating) AS NumRatings
FROM RateACity.REVIEWABLE_ENTITY AS R 
	JOIN RateACity.Review AS Rev ON Rev.ReviewableEID = R.EntityID
	WHERE IsPending = 0
    GROUP BY EntityID
) AS V 
ON U.AttractionEID = V.EntityID)
;
/*
----- CITY REVIEW / UPDATE REVIEW FORM-----
*/
#insert new review
INSERT INTO RateACity.REVIEW (UserEmail, ReviewableEID, Rating, Comment, CreateDate) 
	VALUES 
    (/*get current user email,*/
    /*get current city EID,*/ 
    /*get rating input,*/ 
    /*get comment input,*/ 
    /*get current date*/);
    
#update old review
UPDATE RateACity.REVIEW
	SET Rating = 0/*get rating input*/, Comment = ''/*get comment input*/
    WHERE (UserEmail = ''/*get current user email*/ 
    AND ReviewableEID = 0/*get current cities' EID*/);

#delete old review
DELETE FROM RateACity.REVIEW   
	WHERE UserEmail = ''/*get current user email*/ AND ReviewableEID = 0/*get current cities' EID*/;


/*
----- CITY REVIEWS PAGE -----
*/
#populate tables
SELECT Email, Rating, Comment FROM
	(SELECT * FROM RateACity.USER
	NATURAL LEFT JOIN RateACity.REVIEW) AS RESULT
    order by Email;
SELECT Email, Rating, Comment FROM
	(SELECT * FROM RateACity.USER
	NATURAL LEFT JOIN RateACity.REVIEW) AS RESULT
    order by Rating;
SELECT Email, Rating, Comment FROM
	(SELECT * FROM RateACity.USER
	NATURAL LEFT JOIN RateACity.REVIEW) AS RESULT
    order by Comment;

#manager option to delete review
DELETE FROM RateACity.REVIEW   
	WHERE UserEmail = ''/*get selected user email in table*/ 
	AND ReviewableEID = 0/*get current cities' EID*/;

/*
----- USER'S REVIEW PAGE -----
*/
#populates table with both user's city and attraction reviews
SELECT * FROM
	(SELECT CityName AS EntityName, Rating, Comment, ReviewableEID
		FROM
		(SELECT * FROM RateACity.CITY AS C JOIN RateACity.REVIEW AS R
		ON C.CityEID=R.ReviewableEID )
		AS UserCityReviews
		WHERE UserEmail = CurrentState.getEmail()
		UNION
		SELECT AttractionName, Rating, Comment, AttractionEID
		FROM (SELECT * FROM RateACity.ATTRACTION AS A
		JOIN RateACity.REVIEW AS R ON A.AttractionEID=R.ReviewableEID)
		AS UserAttractionReviews
		WHERE UserEmail = CurrentState.getEmail()) AS Result
	ORDER BY EntityName;
SELECT * FROM
	(SELECT CityName AS EntityName, Rating, Comment, ReviewableEID
		FROM
		(SELECT * FROM RateACity.CITY AS C JOIN RateACity.REVIEW AS R
		ON C.CityEID=R.ReviewableEID )
		AS UserCityReviews
		WHERE UserEmail = CurrentState.getEmail()
		UNION
		SELECT AttractionName, Rating, Comment, AttractionEID
		FROM (SELECT * FROM RateACity.ATTRACTION AS A
		JOIN RateACity.REVIEW AS R ON A.AttractionEID=R.ReviewableEID)
		AS UserAttractionReviews
		WHERE UserEmail = CurrentState.getEmail()) AS Result
	ORDER BY Rating;
SELECT * FROM
	(SELECT CityName AS EntityName, Rating, Comment, ReviewableEID
		FROM
		(SELECT * FROM RateACity.CITY AS C JOIN RateACity.REVIEW AS R
		ON C.CityEID=R.ReviewableEID )
		AS UserCityReviews
		WHERE UserEmail = CurrentState.getEmail()
		UNION
		SELECT AttractionName, Rating, Comment, AttractionEID
		FROM (SELECT * FROM RateACity.ATTRACTION AS A
		JOIN RateACity.REVIEW AS R ON A.AttractionEID=R.ReviewableEID)
		AS UserAttractionReviews
		WHERE UserEmail = CurrentState.getEmail()) AS Result
	ORDER BY ReviewableEID;


/*
----- ATTRACTION LIST -----
*/
SELECT * FROM (
select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
                    from (select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
                    natural left join rateacity.contact_info natural left join rateacity.falls_under
                    natural left join rateacity.city inner join rateacity.reviewable_entity
                    where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0)
                    as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
                    from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID) AS B
	ORDER BY CityName;

SELECT * FROM (
select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
                    from (select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
                    natural left join rateacity.contact_info natural left join rateacity.falls_under
                    natural left join rateacity.city inner join rateacity.reviewable_entity
                    where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0)
                    as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
                    from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID) AS B
	ORDER BY StreetAddress;
SELECT * FROM (
select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
                    from (select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
                    natural left join rateacity.contact_info natural left join rateacity.falls_under
                    natural left join rateacity.city inner join rateacity.reviewable_entity
                    where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0)
                    as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
                    from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID) AS B
	ORDER BY Description;
SELECT * FROM (
select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
                    from (select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
                    natural left join rateacity.contact_info natural left join rateacity.falls_under
                    natural left join rateacity.city inner join rateacity.reviewable_entity
                    where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0)
                    as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
                    from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID) AS B
	ORDER BY attractionEID;
SELECT * FROM (
select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
                    from (select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
                    natural left join rateacity.contact_info natural left join rateacity.falls_under
                    natural left join rateacity.city inner join rateacity.reviewable_entity
                    where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0)
                    as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
                    from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID) AS B
	ORDER BY AttractionName;
SELECT * FROM (
select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
                    from (select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
                    natural left join rateacity.contact_info natural left join rateacity.falls_under
                    natural left join rateacity.city inner join rateacity.reviewable_entity
                    where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0)
                    as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
                    from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID) AS B
	ORDER BY CName;
SELECT * FROM (
select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
                    from (select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
                    natural left join rateacity.contact_info natural left join rateacity.falls_under
                    natural left join rateacity.city inner join rateacity.reviewable_entity
                    where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0)
                    as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
                    from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID) AS B
	ORDER BY AveRating;
SELECT * FROM (
select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
                    from (select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
                    natural left join rateacity.contact_info natural left join rateacity.falls_under
                    natural left join rateacity.city inner join rateacity.reviewable_entity
                    where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0)
                    as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
                    from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID) AS B
	ORDER BY CountRating;
SELECT * FROM (
select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
                    from (select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
                    natural left join rateacity.contact_info natural left join rateacity.falls_under
                    natural left join rateacity.city inner join rateacity.reviewable_entity
                    where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0)
                    as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
                    from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID) AS B
	ORDER BY ContactInfo;
SELECT * FROM (
select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
                    from (select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
                    natural left join rateacity.contact_info natural left join rateacity.falls_under
                    natural left join rateacity.city inner join rateacity.reviewable_entity
                    where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0)
                    as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
                    from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID) AS B
	ORDER BY Hours;

/*
----- ATTRACTION PAGE -----
*/
select AttractionName, CName, CityName, AveRating, CountRating
	from ((select * from rateacity.attraction 
	natural left join rateacity.falls_under 
	natural left join rateacity.city
	inner join rateacity.reviewable_entity 
		where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0) as A join
	(select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating 
		from rateacity.review group by ReviewableEID) as R 
			on A.AttractionEID=R.ReviewableEID);
/*
----- ATTRACTIONS REVIEW PAGE -----
*/
SELECT * FROM (
	SELECT R.UserEmail, R.Rating, R.Comment

		FROM RateACity.REVIEW AS R 
		JOIN RATEACITY.REVIEWABLE_ENTITY AS E 
		ON (R.ReviewableEID = E.EntityID)
		JOIN RATEACITY.ATTRACTION AS A ON (A.AttractionEID = E.EntityID)
		WHERE E.IsPending = 0 
        #the following lines are commenteed out b/c they rely on javafx
        #AND A.AttractionName = CurrentState.getCurrentAttraction().getAttractionName();
        ) AS Result
	ORDER BY R.Rating DESC;

SELECT * FROM (
	SELECT R.UserEmail, R.Rating, R.Comment

		FROM RateACity.REVIEW AS R 
		JOIN RATEACITY.REVIEWABLE_ENTITY AS E 
		ON (R.ReviewableEID = E.EntityID)
		JOIN RATEACITY.ATTRACTION AS A ON (A.AttractionEID = E.EntityID)
		WHERE E.IsPending = 0 
        #the following lines are commenteed out b/c they rely on javafx
        #AND A.AttractionName = CurrentState.getCurrentAttraction().getAttractionName();
        ) AS Result
	ORDER BY UserEmail;
SELECT * FROM (
	SELECT R.UserEmail, R.Rating, R.Comment

		FROM RateACity.REVIEW AS R 
		JOIN RATEACITY.REVIEWABLE_ENTITY AS E 
		ON (R.ReviewableEID = E.EntityID)
		JOIN RATEACITY.ATTRACTION AS A ON (A.AttractionEID = E.EntityID)
		WHERE E.IsPending = 0 
        #the following lines are commenteed out b/c they rely on javafx
        #AND A.AttractionName = CurrentState.getCurrentAttraction().getAttractionName();
        ) AS Result
	ORDER BY Comment;

        
/*
----- NEW ATTRACTION FORM -----
*/
INSERT INTO RateACity.ATTRACTION(AttractionEID, CityEID, StreetAddress, AttractionName, Description)
    VALUES
        (11
        ,1	/*Get selected city from dropdown input, second row*/
        ,'Ponce de Leon Avenue' /*Get address input, third row*/
        ,'Ponce City Market'	/*Get attraction name input, first row*/
        ,'Pay too much for not enough');	/*Get attraction description input, 4th row*/
        
INSERT INTO RateACity.REVIEW (UserEmail, ReviewableEID, Rating, Comment, CreateDate) 
	VALUES 
    (/*get current user email,*/
    /*get selected city EID,*/ 
    /*get rating input,*/ 
    /*get comment input,*/ 
    /*get current date*/);
 
SELECT CityEID 
	FROM RateACity.CITY
    WHERE CityName = ''/*city name from dropdown menu, second row*/; 
    
/*
----- MANAGER WELCOME PAGE -----
*/
#Add new category
INSERT INTO RateACity.CATEGORY (CNAME) VALUES('myCategory');

/*
----- CATEGORIES -----
*/

SELECT * FROM 
	(SELECT CName as Category, COUNT(FALLS_UNDER.AttractionEID) AS NumAttractions
		FROM RateACity.CATEGORY 
		NATURAL LEFT JOIN RateACity.FALLS_UNDER
		GROUP BY Category) AS Result
	ORDER BY Category;

SELECT * FROM 
	(SELECT CName as Category, COUNT(FALLS_UNDER.AttractionEID) AS NumAttractions
		FROM RateACity.CATEGORY 
		NATURAL LEFT JOIN RateACity.FALLS_UNDER
		GROUP BY Category) AS Result
	ORDER BY Category DESC;
SELECT * FROM 
	(SELECT CName as Category, COUNT(FALLS_UNDER.AttractionEID) AS NumAttractions
		FROM RateACity.CATEGORY 
		NATURAL LEFT JOIN RateACity.FALLS_UNDER
		GROUP BY Category) AS Result
	ORDER BY NumAttractions ASC;
SELECT * FROM 
	(SELECT CName as Category, COUNT(FALLS_UNDER.AttractionEID) AS NumAttractions
		FROM RateACity.CATEGORY 
		NATURAL LEFT JOIN RateACity.FALLS_UNDER
		GROUP BY Category) AS Result
	ORDER BY Category DESC;


/*
----- USERS LIST -----
*/
SELECT Email, DateJoined, isManager, isSuspended
	FROM RateACity.User
ORDER BY Email;
SELECT Email, DateJoined, isManager, isSuspended
	FROM RateACity.User
ORDER BY DateJoined;
SELECT Email, DateJoined, isManager, isSuspended
	FROM RateACity.User
ORDER BY isManager;
SELECT Email, DateJoined, isManager, isSuspended
	FROM RateACity.User
ORDER BY isSuspended;

delete from rateacity.user where Email = CurrentState.getEmail()


/*
----- PENDING CITIES -----
*/
(SELECT CityEID, City, Country, UserEmail, Rating, Comment FROM
                (SELECT CityEID, CityName AS City, Country, Rating, Comment
                    FROM RateACity.Review AS E JOIN RateACity.City AS S ON E.ReviewableEID=S.CityEID) AS T
                    JOIN RateACity.Reviewable_Entity AS R
                WHERE IsPending = 1 AND R.EntityID = CityEID
                ORDER BY City ASC);
(SELECT CityEID, City, Country, UserEmail, Rating, Comment FROM
                (SELECT CityEID, CityName AS City, Country, Rating, Comment
                    FROM RateACity.Review AS E JOIN RateACity.City AS S ON E.ReviewableEID=S.CityEID) AS T
                    JOIN RateACity.Reviewable_Entity AS R
                WHERE IsPending = 1 AND R.EntityID = CityEID
                ORDER BY CityEID);
(SELECT CityEID, City, Country, UserEmail, Rating, Comment FROM
                (SELECT CityEID, CityName AS City, Country, Rating, Comment
                    FROM RateACity.Review AS E JOIN RateACity.City AS S ON E.ReviewableEID=S.CityEID) AS T
                    JOIN RateACity.Reviewable_Entity AS R
                WHERE IsPending = 1 AND R.EntityID = CityEID
                ORDER BY Country);
(SELECT CityEID, City, Country, UserEmail, Rating, Comment FROM
                (SELECT CityEID, CityName AS City, Country, Rating, Comment
                    FROM RateACity.Review AS E JOIN RateACity.City AS S ON E.ReviewableEID=S.CityEID) AS T
                    JOIN RateACity.Reviewable_Entity AS R
                WHERE IsPending = 1 AND R.EntityID = CityEID
                ORDER BY UserEmail);
(SELECT CityEID, City, Country, UserEmail, Rating, Comment FROM
                (SELECT CityEID, CityName AS City, Country, Rating, Comment
                    FROM RateACity.Review AS E JOIN RateACity.City AS S ON E.ReviewableEID=S.CityEID) AS T
                    JOIN RateACity.Reviewable_Entity AS R
                WHERE IsPending = 1 AND R.EntityID = CityEID
                ORDER BY Rating);
(SELECT CityEID, City, Country, UserEmail, Rating, Comment FROM
                (SELECT CityEID, CityName AS City, Country, Rating, Comment
                    FROM RateACity.Review AS E JOIN RateACity.City AS S ON E.ReviewableEID=S.CityEID) AS T
                    JOIN RateACity.Reviewable_Entity AS R
                WHERE IsPending = 1 AND R.EntityID = CityEID
                ORDER BY Comment);


/*
----- PENDING ATTRACTIONS -----
*/
SELECT AttractionEID, AttractionName, CityName, StreetAddress, Country, CName AS Category, Description, Hours, ContactInfo, T.UserEmail, Rating, Comment 
FROM 
	(SELECT *
	FROM RateACity.ATTRACTION AS ATTR JOIN RateACity.REVIEWABLE_ENTITY AS E ON ATTR.AttractionEID = E.EntityID
	WHERE IsPending = 1) AS T
JOIN RateACity.REVIEW ON REVIEW.UserEmail = T.UserEmail AND REVIEW.ReviewableEID = T.AttractionEID
NATURAL JOIN RATEACITY.CITY
NATURAL LEFT JOIN RATEACITY.CONTACT_INFO
NATURAL JOIN RATEACITY.FALLS_UNDER
NATURAL LEFT JOIN RATEACITY.HOURS_OF_OPERATION
ORDER BY AttractionName;

SELECT AttractionEID, AttractionName, CityName, StreetAddress, Country, CName AS Category, Description, Hours, ContactInfo, T.UserEmail, Rating, Comment 
FROM 
	(SELECT *
	FROM RateACity.ATTRACTION AS ATTR JOIN RateACity.REVIEWABLE_ENTITY AS E ON ATTR.AttractionEID = E.EntityID
	WHERE IsPending = 1) AS T
JOIN RateACity.REVIEW ON REVIEW.UserEmail = T.UserEmail AND REVIEW.ReviewableEID = T.AttractionEID
NATURAL JOIN RATEACITY.CITY
NATURAL LEFT JOIN RATEACITY.CONTACT_INFO
NATURAL JOIN RATEACITY.FALLS_UNDER
NATURAL LEFT JOIN RATEACITY.HOURS_OF_OPERATION
ORDER BY AttractionEID;
SELECT AttractionEID, AttractionName, CityName, StreetAddress, Country, CName AS Category, Description, Hours, ContactInfo, T.UserEmail, Rating, Comment 
FROM 
	(SELECT *
	FROM RateACity.ATTRACTION AS ATTR JOIN RateACity.REVIEWABLE_ENTITY AS E ON ATTR.AttractionEID = E.EntityID
	WHERE IsPending = 1) AS T
JOIN RateACity.REVIEW ON REVIEW.UserEmail = T.UserEmail AND REVIEW.ReviewableEID = T.AttractionEID
NATURAL JOIN RATEACITY.CITY
NATURAL LEFT JOIN RATEACITY.CONTACT_INFO
NATURAL JOIN RATEACITY.FALLS_UNDER
NATURAL LEFT JOIN RATEACITY.HOURS_OF_OPERATION
ORDER BY CityName;
SELECT AttractionEID, AttractionName, CityName, StreetAddress, Country, CName AS Category, Description, Hours, ContactInfo, T.UserEmail, Rating, Comment 
FROM 
	(SELECT *
	FROM RateACity.ATTRACTION AS ATTR JOIN RateACity.REVIEWABLE_ENTITY AS E ON ATTR.AttractionEID = E.EntityID
	WHERE IsPending = 1) AS T
JOIN RateACity.REVIEW ON REVIEW.UserEmail = T.UserEmail AND REVIEW.ReviewableEID = T.AttractionEID
NATURAL JOIN RATEACITY.CITY
NATURAL LEFT JOIN RATEACITY.CONTACT_INFO
NATURAL JOIN RATEACITY.FALLS_UNDER
NATURAL LEFT JOIN RATEACITY.HOURS_OF_OPERATION
ORDER BY StreetAddress;
SELECT AttractionEID, AttractionName, CityName, StreetAddress, Country, CName AS Category, Description, Hours, ContactInfo, T.UserEmail, Rating, Comment 
FROM 
	(SELECT *
	FROM RateACity.ATTRACTION AS ATTR JOIN RateACity.REVIEWABLE_ENTITY AS E ON ATTR.AttractionEID = E.EntityID
	WHERE IsPending = 1) AS T
JOIN RateACity.REVIEW ON REVIEW.UserEmail = T.UserEmail AND REVIEW.ReviewableEID = T.AttractionEID
NATURAL JOIN RATEACITY.CITY
NATURAL LEFT JOIN RATEACITY.CONTACT_INFO
NATURAL JOIN RATEACITY.FALLS_UNDER
NATURAL LEFT JOIN RATEACITY.HOURS_OF_OPERATION
ORDER BY Country;
SELECT AttractionEID, AttractionName, CityName, StreetAddress, Country, CName AS Category, Description, Hours, ContactInfo, T.UserEmail, Rating, Comment 
FROM 
	(SELECT *
	FROM RateACity.ATTRACTION AS ATTR JOIN RateACity.REVIEWABLE_ENTITY AS E ON ATTR.AttractionEID = E.EntityID
	WHERE IsPending = 1) AS T
JOIN RateACity.REVIEW ON REVIEW.UserEmail = T.UserEmail AND REVIEW.ReviewableEID = T.AttractionEID
NATURAL JOIN RATEACITY.CITY
NATURAL LEFT JOIN RATEACITY.CONTACT_INFO
NATURAL JOIN RATEACITY.FALLS_UNDER
NATURAL LEFT JOIN RATEACITY.HOURS_OF_OPERATION
ORDER BY Category;
SELECT AttractionEID, AttractionName, CityName, StreetAddress, Country, CName AS Category, Description, Hours, ContactInfo, T.UserEmail, Rating, Comment 
FROM 
	(SELECT *
	FROM RateACity.ATTRACTION AS ATTR JOIN RateACity.REVIEWABLE_ENTITY AS E ON ATTR.AttractionEID = E.EntityID
	WHERE IsPending = 1) AS T
JOIN RateACity.REVIEW ON REVIEW.UserEmail = T.UserEmail AND REVIEW.ReviewableEID = T.AttractionEID
NATURAL JOIN RATEACITY.CITY
NATURAL LEFT JOIN RATEACITY.CONTACT_INFO
NATURAL JOIN RATEACITY.FALLS_UNDER
NATURAL LEFT JOIN RATEACITY.HOURS_OF_OPERATION
ORDER BY Description;
SELECT AttractionEID, AttractionName, CityName, StreetAddress, Country, CName AS Category, Description, Hours, ContactInfo, T.UserEmail, Rating, Comment 
FROM 
	(SELECT *
	FROM RateACity.ATTRACTION AS ATTR JOIN RateACity.REVIEWABLE_ENTITY AS E ON ATTR.AttractionEID = E.EntityID
	WHERE IsPending = 1) AS T
JOIN RateACity.REVIEW ON REVIEW.UserEmail = T.UserEmail AND REVIEW.ReviewableEID = T.AttractionEID
NATURAL JOIN RATEACITY.CITY
NATURAL LEFT JOIN RATEACITY.CONTACT_INFO
NATURAL JOIN RATEACITY.FALLS_UNDER
NATURAL LEFT JOIN RATEACITY.HOURS_OF_OPERATION
ORDER BY Hours;
SELECT AttractionEID, AttractionName, CityName, StreetAddress, Country, CName AS Category, Description, Hours, ContactInfo, T.UserEmail, Rating, Comment 
FROM 
	(SELECT *
	FROM RateACity.ATTRACTION AS ATTR JOIN RateACity.REVIEWABLE_ENTITY AS E ON ATTR.AttractionEID = E.EntityID
	WHERE IsPending = 1) AS T
JOIN RateACity.REVIEW ON REVIEW.UserEmail = T.UserEmail AND REVIEW.ReviewableEID = T.AttractionEID
NATURAL JOIN RATEACITY.CITY
NATURAL LEFT JOIN RATEACITY.CONTACT_INFO
NATURAL JOIN RATEACITY.FALLS_UNDER
NATURAL LEFT JOIN RATEACITY.HOURS_OF_OPERATION
ORDER BY ContactInfo;
SELECT AttractionEID, AttractionName, CityName, StreetAddress, Country, CName AS Category, Description, Hours, ContactInfo, T.UserEmail, Rating, Comment 
FROM 
	(SELECT *
	FROM RateACity.ATTRACTION AS ATTR JOIN RateACity.REVIEWABLE_ENTITY AS E ON ATTR.AttractionEID = E.EntityID
	WHERE IsPending = 1) AS T
JOIN RateACity.REVIEW ON REVIEW.UserEmail = T.UserEmail AND REVIEW.ReviewableEID = T.AttractionEID
NATURAL JOIN RATEACITY.CITY
NATURAL LEFT JOIN RATEACITY.CONTACT_INFO
NATURAL JOIN RATEACITY.FALLS_UNDER
NATURAL LEFT JOIN RATEACITY.HOURS_OF_OPERATION
ORDER BY UserEmail;
SELECT AttractionEID, AttractionName, CityName, StreetAddress, Country, CName AS Category, Description, Hours, ContactInfo, T.UserEmail, Rating, Comment 
FROM 
	(SELECT *
	FROM RateACity.ATTRACTION AS ATTR JOIN RateACity.REVIEWABLE_ENTITY AS E ON ATTR.AttractionEID = E.EntityID
	WHERE IsPending = 1) AS T
JOIN RateACity.REVIEW ON REVIEW.UserEmail = T.UserEmail AND REVIEW.ReviewableEID = T.AttractionEID
NATURAL JOIN RATEACITY.CITY
NATURAL LEFT JOIN RATEACITY.CONTACT_INFO
NATURAL JOIN RATEACITY.FALLS_UNDER
NATURAL LEFT JOIN RATEACITY.HOURS_OF_OPERATION
ORDER BY Rating;
SELECT AttractionEID, AttractionName, CityName, StreetAddress, Country, CName AS Category, Description, Hours, ContactInfo, T.UserEmail, Rating, Comment 
FROM 
	(SELECT *
	FROM RateACity.ATTRACTION AS ATTR JOIN RateACity.REVIEWABLE_ENTITY AS E ON ATTR.AttractionEID = E.EntityID
	WHERE IsPending = 1) AS T
JOIN RateACity.REVIEW ON REVIEW.UserEmail = T.UserEmail AND REVIEW.ReviewableEID = T.AttractionEID
NATURAL JOIN RATEACITY.CITY
NATURAL LEFT JOIN RATEACITY.CONTACT_INFO
NATURAL JOIN RATEACITY.FALLS_UNDER
NATURAL LEFT JOIN RATEACITY.HOURS_OF_OPERATION
ORDER BY Comment;

/*
----- search-----
*/
select StreetAddress, Description, attractionEID, 
AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours 
from ((select * from rateacity.attraction natural left join RATEACITY.hours_of_operation 
natural left join rateacity.contact_info natural left join rateacity.falls_under 
natural left join rateacity.city join rateacity.reviewable_entity 
where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0) 
as A join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating 
from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID)
where AttractionName="Arc de Triomf"  and CityName="Barcelona" and CName="Monument";

/*
----- City View Controller Review Table
*/
select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
from ((select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
natural left join rateacity.contact_info natural left join rateacity.falls_under
natural left join rateacity.city inner join rateacity.reviewable_entity
where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0
AND city.CityEID=
+ CurrentState.getCurrentCity().getCityEID() + (currentCategory.equals("") ? " " : " AND CName=\'" + currentCategory + "\'") +
) as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID)
ORDER BY StreetAddress;

select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
from ((select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
natural left join rateacity.contact_info natural left join rateacity.falls_under
natural left join rateacity.city inner join rateacity.reviewable_entity
where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0
AND city.CityEID=
+ CurrentState.getCurrentCity().getCityEID() + (currentCategory.equals("") ? " " : " AND CName=\'" + currentCategory + "\'") +
) as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID)
ORDER BY Description;

select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
from ((select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
natural left join rateacity.contact_info natural left join rateacity.falls_under
natural left join rateacity.city inner join rateacity.reviewable_entity
where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0
AND city.CityEID=
+ CurrentState.getCurrentCity().getCityEID() + (currentCategory.equals("") ? " " : " AND CName=\'" + currentCategory + "\'") +
) as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID)
ORDER BY AttractionName;

select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
from ((select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
natural left join rateacity.contact_info natural left join rateacity.falls_under
natural left join rateacity.city inner join rateacity.reviewable_entity
where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0
AND city.CityEID=
+ CurrentState.getCurrentCity().getCityEID() + (currentCategory.equals("") ? " " : " AND CName=\'" + currentCategory + "\'") +
) as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID)
ORDER BY CName;

select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
from ((select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
natural left join rateacity.contact_info natural left join rateacity.falls_under
natural left join rateacity.city inner join rateacity.reviewable_entity
where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0
AND city.CityEID=
+ CurrentState.getCurrentCity().getCityEID() + (currentCategory.equals("") ? " " : " AND CName=\'" + currentCategory + "\'") +
) as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID)
ORDER BY CityName;

select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
from ((select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
natural left join rateacity.contact_info natural left join rateacity.falls_under
natural left join rateacity.city inner join rateacity.reviewable_entity
where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0
AND city.CityEID=
+ CurrentState.getCurrentCity().getCityEID() + (currentCategory.equals("") ? " " : " AND CName=\'" + currentCategory + "\'") +
) as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID)
ORDER BY AveRating;

select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
from ((select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
natural left join rateacity.contact_info natural left join rateacity.falls_under
natural left join rateacity.city inner join rateacity.reviewable_entity
where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0
AND city.CityEID=
+ CurrentState.getCurrentCity().getCityEID() + (currentCategory.equals("") ? " " : " AND CName=\'" + currentCategory + "\'") +
) as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID)
ORDER BY CountRating;

select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
from ((select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
natural left join rateacity.contact_info natural left join rateacity.falls_under
natural left join rateacity.city inner join rateacity.reviewable_entity
where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0
AND city.CityEID=
+ CurrentState.getCurrentCity().getCityEID() + (currentCategory.equals("") ? " " : " AND CName=\'" + currentCategory + "\'") +
) as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID)
ORDER BY ContactInfo;

select StreetAddress, Description, attractionEID, AttractionName, CName, CityName, AveRating, CountRating, ContactInfo, Hours
from ((select * from rateacity.attraction natural left join RATEACITY.hours_of_operation
natural left join rateacity.contact_info natural left join rateacity.falls_under
natural left join rateacity.city inner join rateacity.reviewable_entity
where reviewable_entity.EntityID=attraction.AttractionEID AND reviewable_entity.IsPending=0
AND city.CityEID=
+ CurrentState.getCurrentCity().getCityEID() + (currentCategory.equals("") ? " " : " AND CName=\'" + currentCategory + "\'") +
) as A inner join (select ReviewableEID, avg(rating) as AveRating, count(rating) as CountRating
from rateacity.review group by ReviewableEID) as R on A.AttractionEID=R.ReviewableEID)
ORDER BY Hours;


/*
----- delete-----
*/
DELETE FROM RateACity.REVIEWABLE_ENTITY WHERE EntityID=17 ;

DELETE FROM RateACity.REVIEW WHERE UserEmail='anthony@vr.com' and ReviewableEID=21;
