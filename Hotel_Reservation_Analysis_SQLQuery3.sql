SELECT TOP (3) [Booking_ID]
      ,[no_of_adults]
      ,[no_of_children]
      ,[no_of_weekend_nights]
      ,[no_of_week_nights]
      ,[type_of_meal_plan]
      ,[room_type_reserved]
      ,[lead_time]
      ,[arrival_date]
      ,[market_segment_type]
      ,[avg_price_per_room]
      ,[booking_status]
  FROM [Mentorness_SQL].[dbo].[Hotel Reservation Dataset]



               --QUESTION 1
               -- What is the total number of reservations in the dataset?   700

SELECT COUNT(Booking_ID)
FROM   dbo.[Hotel Reservation Dataset]

  

		--QUESTION 2
		-- Which meal plan is the most popular among guests?   Meal Plan 1

SELECT type_of_meal_plan,
	COUNT(Booking_ID) AS most_popular_meal
FROM  dbo.[Hotel Reservation Dataset]
GROUP BY type_of_meal_plan
ORDER BY COUNT(Booking_ID) Desc



		--QUESTION 3
		--What is the average price per room for reservations involving children?

SELECT no_of_children,
	ROUND( AVG(avg_price_per_room),2) AS avg_price_per_room
FROM dbo.[Hotel Reservation Dataset]
WHERE no_of_children > 0
GROUP BY no_of_children

		--OR

SELECT ROUND(AVG(avg_price_per_room),2) AS average_price_per_room
FROM dbo.[Hotel Reservation Dataset]
WHERE no_of_children > 0;



		--QUESTION 4

		--How many reservations were made for the year 20XX (replace XX with the desired year)?
 
		 --2017(123) , 2018(577)


SELECT DISTINCT YEAR(arrival_date) AS arrival_year
FROM dbo.[Hotel Reservation Dataset]

SELECT COUNT(Booking_ID) AS reservations2017
FROM  dbo.[Hotel Reservation Dataset]
WHERE arrival_date like '%2017%'

SELECT COUNT(Booking_ID) AS reservations2018
FROM dbo.[Hotel Reservation Dataset]
WHERE arrival_date like '%2018%'

		--OR

WITH YearlyReservations AS (
SELECT YEAR(arrival_date) AS reservation_year
FROM dbo.[Hotel Reservation Dataset]
)
SELECT reservation_year,
	COUNT(*) AS num_reservations
FROM  YearlyReservations
WHERE reservation_year = 2018
GROUP BY reservation_year



		--QUESTION 5

		--What is the most commonly booked room type?   Room_Type 1

SELECT room_type_reserved,
	COUNT(Booking_ID) AS total_rooms_booked
FROM dbo.[Hotel Reservation Dataset]
GROUP BY room_type_reserved
ORDER BY COUNT(Booking_ID) DESC


		-- QUESTION 6

		--How many reservations fall on a weekend (no_of_weekend_nights > 0)?   383

SELECT COUNT(no_of_weekend_nights ) AS total_weekend_nights
FROM dbo.[Hotel Reservation Dataset]
WHERE no_of_weekend_nights > 0


		-- QUESTION 7

		--What is the highest and lowest lead time for reservations?

		--Highest lead time.  443

SELECT  TOP 5
	Booking_ID,
	arrival_date,
	market_segment_type,
	avg_price_per_room,
	lead_time
FROM  dbo.[Hotel Reservation Dataset]
ORDER BY lead_time DESC

--OR

SELECT  MAX(lead_time) AS max_lead_time
FROM  dbo.[Hotel Reservation Dataset]

--Lowest lead time   0

SELECT  TOP 3
	Booking_ID,
	arrival_date,
	market_segment_type,
	avg_price_per_room,
	lead_time
FROM  dbo.[Hotel Reservation Dataset]
ORDER BY lead_time 

--OR
SELECT  MIN (lead_time) AS min_lead_time
FROM  dbo.[Hotel Reservation Dataset]


		-- QUESTION 8

		--What is the most common market segment type for reservations?   ONLINE

SELECT  COUNT(Booking_ID) AS total_number_market_segment_type,market_segment_type
FROM	dbo.[Hotel Reservation Dataset]
GROUP BY market_segment_type
ORDER BY COUNT(Booking_ID) DESC


		-- QUESTION 9

		--How many reservations have a booking status of "Confirmed"?   493



SELECT booking_status, 
	COUNT(*) AS num_confirmed_booking
FROM  dbo.[Hotel Reservation Dataset]
WHERE booking_status = 'Not_Canceled'
GROUP BY booking_status

		-- QUESTION 10

		--What is the total number of adults and children across all reservations?   1385


SELECT 
    SUM(no_of_adults) AS total_adults,
    SUM(no_of_children) AS total_children,
    SUM(no_of_adults + no_of_children) AS total_guests
FROM dbo.[Hotel Reservation Dataset]
	

		--QUESTION 11

		--What is the average number of weekend nights for reservations involving children?  1

SELECT AVG(no_of_weekend_nights) AS average_weekend_nights_with_children
FROM   dbo.[Hotel Reservation Dataset]
WHERE no_of_children > 0;



		--QUESTION 12
		--How many reservations were made in each month of the year?


SELECT 
    DATEPART(YEAR, arrival_date) AS year,
    DATENAME(MONTH, arrival_date) AS month,
    COUNT(*) AS num_reservations
FROM 
    dbo.[Hotel Reservation Dataset]
GROUP BY 
    DATEPART(YEAR, arrival_date),
    DATENAME(MONTH, arrival_date)
ORDER BY 
    DATEPART(YEAR, arrival_date),
    DATENAME(MONTH, arrival_date)	


		--QUESTION 13
		--What is the average number of nights (both weekend and weekday) spent by guests for each room
		--type?  2 TO 3

SELECT room_type_reserved,
    AVG(no_of_weekend_nights + no_of_week_nights) AS avg_nights
FROM DBO.[Hotel Reservation Dataset]
GROUP BY room_type_reserved


		--QUESTION 14
		--For reservations involving children, what is the most common room type, and what is the average
		--price for that room type? ROOM TYPE 1 (123.12)

WITH Children_Reservations AS (
    SELECT *
    FROM DBO.[Hotel Reservation Dataset]
    WHERE no_of_children > 0
)

SELECT TOP 1 room_type_reserved,
    COUNT(*) AS num_reservations,
    ROUND(AVG(avg_price_per_room),2) AS avg_price
FROM Children_Reservations
GROUP BY room_type_reserved
ORDER BY num_reservations DESC

	--QUESTION 15
	--Find the market segment type that generates the highest average price per room. ONLINE



SELECT TOP 1 market_segment_type,
    ROUND(AVG(avg_price_per_room),2) AS avg_price
FROM dbo.[Hotel Reservation Dataset]
GROUP BY market_segment_type
ORDER BY avg_price DESC

