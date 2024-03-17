--Truy vấn thông tin khách hàng đến từ đất nước USA

SELECT Customer.*
FROM Customer
WHERE Customer.Country='USA';

--Truy vấn thông tin về các chuyến bay xuất phát vào ngày 25/2/2024(bao gồm cả điểm đến điểm đi chi tiết)
SELECT Leg.Flight_Code, Leg.Leg_ID, Leg.Arrival_Time, Leg.Departure_Time, a1.Airport_Name AS Departure_Aiport, a2.Airport_Name AS Arrival_Airport
FROM Leg
INNER JOIN Airport a1 ON Leg.DepartureAirport_ID=a1.Airport_ID
INNER JOIN Airport a2 ON Leg.ArriveAirport_ID=a2.Airport_ID
WHERE YEAR(Leg.Departure_Time)='2024' AND MONTH(Leg.Departure_Time)='02' AND DAY(Leg.Departure_Time)='25';

--Truy vấn thông tin về những ghế chưa được đặt trên chặng bay VN1256
SELECT Seat.Seat_ID, Seat_Class.Class_Name
FROM Seat
INNER JOIN Aircraft ON Seat.Aircraft_ID=Aircraft.Aircraft_ID
LEFT JOIN Seat_Class ON Seat.Seat_Class_ID=Seat_Class.Seat_Class_ID
LEFT JOIN Booking_Leg ON Seat.Seat_ID=Booking_Leg.Seat_ID
WHERE Aircraft.Aircraft_ID= (SELECT Aircraft.Aircraft_ID
                             FROM Aircraft
							 INNER JOIN Leg ON Aircraft.Aircraft_ID=Leg.Aircraft_ID
							 WHERE Leg.Leg_ID='VN1260')
			AND Seat.Seat_ID NOT IN ( SELECT Seat.Seat_ID
                                      FROM Seat
                                      INNER JOIN Booking_Leg ON Seat.Seat_ID=Booking_Leg.Seat_ID
                                      WHERE Booking_Leg.Leg_ID='VN1260');

--Chặng bay nào khởi hành gần đây nhất
SELECT Leg.Leg_ID, Leg.Flight_Code, Leg.Arrival_Time, Leg.Departure_Time, a1.Airport_Name AS Departure_Aiport, a2.Airport_Name AS Arrival_Airport
FROM Leg
INNER JOIN Airport a1 ON Leg.DepartureAirport_ID=a1.Airport_ID
INNER JOIN Airport a2 ON Leg.ArriveAirport_ID=a2.Airport_ID
WHERE Leg.Departure_Time = (SELECT MAX(Leg.Departure_Time)
                            FROM Leg);

--CHo biết số lượng khách hàng đã đặt trên từng chặng bay
SELECT Leg.Leg_ID, Leg.Flight_Code, COUNT(Booking_Leg.Booking_Leg_ID) AS NumberOfCustomers
FROM Leg
INNER JOIN Booking_Leg ON Booking_Leg.Leg_ID=Leg.Leg_ID
GROUP BY Leg.Leg_ID, Leg.Flight_Code

--Tạo một cột Number ghi số lượng của máy bay theo từng loại model máy bay của một hãng bay( giá trị khởi tạo là 2)
ALTER TABLE Aircraft
ADD Number INT
UPDATE Aircraft 
SET Number=2



