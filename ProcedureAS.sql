--Tao procedure tính số ghế ngồi còn lại trong một chặng bay

CREATE PROCEDURE NumberOfEmptySeats
( @legid varchar(10), @numbers int output)
AS
BEGIN
    SELECT @numbers=COUNT(Seat.Seat_ID)
    FROM Seat
    INNER JOIN Aircraft ON Seat.Aircraft_ID=Aircraft.Aircraft_ID
    LEFT JOIN Booking_Leg ON Seat.Seat_ID=Booking_Leg.Seat_ID
    WHERE Aircraft.Aircraft_ID= (SELECT Aircraft.Aircraft_ID
                                 FROM Aircraft
							     INNER JOIN Leg ON Aircraft.Aircraft_ID=Leg.Aircraft_ID
							     WHERE Leg.Leg_ID=@legid) 
	AND Seat.Seat_ID NOT IN ( SELECT Seat.Seat_ID
                              FROM Seat
                              INNER JOIN Booking_Leg ON Seat.Seat_ID=Booking_Leg.Seat_ID
                              WHERE Booking_Leg.Leg_ID=@legid)
END

--DROP PROCEDURE NumberOfEmptySeats

DECLARE @t int
EXEC NumberOfEmptySeats 'VN1260', @t output
print @t

--Tạo Procedure tính số lượng chuyến bay xuất phát trong ngày @date
CREATE PROCEDURE NumberOfFlight
( @date DATE, @numbers int output)
AS
BEGIN
    SELECT @numbers=COUNT(Leg.Flight_Code)
	FROM Leg
    WHERE CONVERT(DATE, Leg.Departure_Time) = @date;
END;

DROP PROCEDURE NumberOfFlight

DECLARE @t int
EXEC NumberOfFlight '2024-02-24', @t output 
print @t

--Tao function return table bao gồm tất cả người trên một chặng bay

CREATE FUNCTION NumberOfCustomers
( @leg_id varchar(10) )
RETURNS @table TABLE(Customer_ID varchar(10))
AS
BEGIN
   INSERT INTO @table
   SELECT b.Customer_ID
   FROM Booking b
   INNER JOIN Booking_Leg bl ON b.Booking_ID=bl.Booking_ID
   WHERE bl.Leg_ID=@leg_id
RETURN
END
DROP FUNCTION NumberOfCustomers
SELECT * FROM NumberOfCustomers('VN1256')