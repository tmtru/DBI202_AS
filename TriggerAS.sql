--Tạo trigger để xử lí tình huống khi khách hàng muốn thay đổi chỗ ngồi, chỗ ngồi đấy phải còn trống 
--và chỉ được thay đổi chỗ ngồi có cùng hạng ghế, nếu không sẽ thông báo là không thể thực hiện
CREATE TRIGGER ChangeSeat
ON Booking_Leg
INSTEAD OF UPDATE
AS
BEGIN
    DECLARE @seatclass varchar(10)
    DECLARE @seatclassold varchar(10)
    DECLARE @newleg varchar(10)
    DECLARE @oldleg varchar(10)
    DECLARE @seatid varchar(10)

    SELECT @seatclass = Seat_Class.Seat_Class_ID
    FROM inserted i 
    INNER JOIN Seat ON i.Seat_ID = Seat.Seat_ID
    INNER JOIN Seat_Class ON Seat.Seat_Class_ID = Seat_Class.Seat_Class_ID;

    SELECT @seatclassold = Seat_Class.Seat_Class_ID
    FROM deleted d 
    INNER JOIN Seat ON d.Seat_ID = Seat.Seat_ID
    INNER JOIN Seat_Class ON Seat.Seat_Class_ID = Seat_Class.Seat_Class_ID;

    SELECT @newleg = i.Leg_ID 
    FROM inserted i;

    SELECT @oldleg = d.Leg_ID 
    FROM deleted d;

    SELECT @seatid = i.Seat_ID
    FROM inserted i;

    IF (@seatid IN (
            SELECT Seat.Seat_ID
            FROM Seat
            INNER JOIN Aircraft ON Seat.Aircraft_ID = Aircraft.Aircraft_ID
            INNER JOIN Seat_Class ON Seat.Seat_Class_ID = Seat_Class.Seat_Class_ID
            LEFT JOIN Booking_Leg ON Seat.Seat_ID = Booking_Leg.Seat_ID
            WHERE Aircraft.Aircraft_ID = (
                SELECT Aircraft.Aircraft_ID
                FROM Aircraft
                LEFT JOIN Leg ON Aircraft.Aircraft_ID = Leg.Aircraft_ID
                WHERE Leg.Leg_ID = @oldleg
            )
            AND Seat.Seat_ID NOT IN (
                SELECT Seat.Seat_ID
                FROM Seat
                INNER JOIN Booking_Leg ON Seat.Seat_ID = Booking_Leg.Seat_ID
                WHERE Booking_Leg.Leg_ID = @oldleg
            )
        )
        AND @seatclass = @seatclassold 
        AND @newleg = @oldleg
    )
    BEGIN
        UPDATE Booking_Leg
        SET Seat_ID = @seatid
        FROM inserted i
        WHERE Booking_Leg.Booking_Leg_ID = i.Booking_Leg_ID;
        PRINT 'Successfully Changed!';
    END
    ELSE
    BEGIN
        PRINT 'Cannot change!';
    END
END

DROP TRIGGER ChangeSeat
UPDATE Booking_Leg
SET Seat_ID='S101'
WHERE Booking_Leg_ID='BL020'

-- Tạo Trigger mỗi khi insert giá trị mới vào bảng aircraft thì nếu trùng Airline_ID, Manufacturer, Model 
--thì Number của hàng có giá trị giống được tăng thêm 1
--nếu không thì tạo hàng mới như bình thường

CREATE TRIGGER ChangeAircraft
ON Aircraft
INSTEAD OF INSERT
AS 
BEGIN
    IF EXISTS (SELECT *
	           FROM Aircraft a, inserted i
			   WHERE a.Airline_ID=i.Airline_ID AND a.Manufacturer=i.Manufacturer AND a.Model=i.Model)
	BEGIN
	    UPDATE Aircraft 
		SET Number=Number+1
		WHERE Aircraft.Aircraft_ID=(SELECT a.Aircraft_ID 
	           FROM Aircraft a, inserted i
			   WHERE a.Airline_ID=i.Airline_ID AND a.Manufacturer=i.Manufacturer AND a.Model=i.Model)
	END
	ELSE
	BEGIN
	    INSERT INTO Aircraft (Aircraft_ID, Airline_ID, Model, Manufacturer, Number)
        SELECT Aircraft_ID, Airline_ID, Model, Manufacturer, 1
        FROM inserted;
	END
END

INSERT INTO Aircraft(Aircraft_ID, Airline_ID, Model, Manufacturer)
VALUES ('AC016','AL001','Airbus A356', 'Airbus')
	

