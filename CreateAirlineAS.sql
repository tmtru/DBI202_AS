CREATE TABLE Airport
(
  Airport_ID VARCHAR(5) NOT NULL,
  Airport_Name NVARCHAR(100) NOT NULL,
  City NVARCHAR(50) NOT NULL,
  Country NVARCHAR(50) NOT NULL,
  PRIMARY KEY (Airport_ID)
);

CREATE TABLE Seat_Class
(
  Seat_Class_ID VARCHAR(5) NOT NULL,
  Class_Name NVARCHAR(100) NOT NULL,
  PRIMARY KEY (Seat_Class_ID)
);

CREATE TABLE Customer
(
  First_Name NVARCHAR(50) NOT NULL,
  Last_Name NVARCHAR(50) NOT NULL,
  Passport_Number VARCHAR(9) NOT NULL,
  Email_Address VARCHAR(225) NOT NULL,
  Phone_Number VARCHAR(15) NOT NULL,
  Country NVARCHAR(50) NOT NULL,
  Customer_ID VARCHAR(5) NOT NULL,
  PRIMARY KEY (Customer_ID)
);

CREATE TABLE Airline
(
  Airline_ID VARCHAR(5) NOT NULL UNIQUE,
  Airline_Name NVARCHAR(100) NOT NULL,
  PRIMARY KEY (Airline_ID)
);

CREATE TABLE Flight
(
  Flight_Code VARCHAR(10) NOT NULL,
  Airline_ID VARCHAR(5) NOT NULL,
  PRIMARY KEY (Flight_Code),
  FOREIGN KEY (Airline_ID) REFERENCES Airline(Airline_ID),

);

CREATE TABLE Aircraft
(
  Model VARCHAR(100) NOT NULL,
  Manufacturer VARCHAR(100) NOT NULL,
  Aircraft_ID VARCHAR(5) NOT NULL,
  Airline_ID VARCHAR(5) NOT NULL,
  PRIMARY KEY (Aircraft_ID),
  FOREIGN KEY (Airline_ID) REFERENCES Airline(Airline_ID)
);

CREATE TABLE Booking
(
  Booking_ID VARCHAR(5) NOT NULL,
  Date DATE NOT NULL,
  Customer_ID VARCHAR(5) NOT NULL,
  Airline_ID VARCHAR(5) NOT NULL,
  PRIMARY KEY (Booking_ID),
  FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
  FOREIGN KEY (Airline_ID) REFERENCES Airline(Airline_ID)
);

CREATE TABLE Leg
(
  Arrival_Time DATETIME NOT NULL,
  Departure_Time DATETIME NOT NULL,
  Leg_ID VARCHAR(10) NOT NULL,
  Price FLOAT NOT NULL,
  Flight_Code VARCHAR(10) NOT NULL,
  Aircraft_ID VARCHAR(5) NOT NULL,
  DepartureAirport_ID VARCHAR(5) NOT NULL,
  ArriveAirport_ID VARCHAR(5) NOT NULL,
  PRIMARY KEY (Leg_ID),
  FOREIGN KEY (Flight_Code) REFERENCES Flight(Flight_Code),
  FOREIGN KEY (Aircraft_ID) REFERENCES Aircraft(Aircraft_ID),
  FOREIGN KEY (DepartureAirport_ID) REFERENCES Airport(Airport_ID),
  FOREIGN KEY (ArriveAirport_ID) REFERENCES Airport(Airport_ID)
);
CREATE TABLE Seat
(
  Seat_ID VARCHAR(5) NOT NULL,
  Aircraft_ID VARCHAR(5) NOT NULL,
  Seat_Class_ID VARCHAR(5) NOT NULL,
  PRIMARY KEY (Seat_ID),
  FOREIGN KEY (Aircraft_ID) REFERENCES Aircraft(Aircraft_ID),
  FOREIGN KEY (Seat_Class_ID) REFERENCES Seat_Class(Seat_Class_ID)
);
CREATE TABLE Booking_Leg
(
  Booking_Leg_ID VARCHAR(5) NOT NULL,
  Price FLOAT NOT NULL,
  Leg_ID VARCHAR(10) NOT NULL,
  Booking_ID VARCHAR(5) NOT NULL,
  Seat_ID VARCHAR(5) NOT NULL,
  PRIMARY KEY (Booking_Leg_ID),
 FOREIGN KEY (Seat_ID) REFERENCES Seat(Seat_ID),
  FOREIGN KEY (Leg_ID) REFERENCES Leg(Leg_ID),
  FOREIGN KEY (Booking_ID) REFERENCES Booking(Booking_ID)
);



INSERT INTO Customer (Customer_ID, First_Name, Last_Name, Passport_Number, Email_Address, Phone_Number, Country)
VALUES 
    ('C001', 'John', 'Smith', 'JS123456', 'john.smith@example.com', '123-456-7890', 'USA'),
    ('C002', 'Alice', 'Johnson', 'AJ789012', 'alice.johnson@example.com', '987-654-3210', 'Canada'),
    ('C003', 'Michael', 'Brown', 'MB456789', 'michael.brown@example.com', '456-789-0123', 'UK'),
    ('C004', 'Emma', 'Wilson', 'EW789123', 'emma.wilson@example.com', '789-012-3456', 'Australia'),
    ('C005', 'James', 'Miller', 'JM654321', 'james.miller@example.com', '345-678-9012', 'USA'),
    ('C006', 'Olivia', 'Garcia', 'OG321987', 'olivia.garcia@example.com', '567-890-1234', 'Spain'),
    ('C007', 'Ethan', 'Martinez', 'EM789654', 'ethan.martinez@example.com', '890-123-4567', 'Canada'),
    ('C008', 'Sophia', 'Lee', 'SL987456', 'sophia.lee@example.com', '234-567-8901', 'USA'),
    ('C009', 'William', 'Rodriguez', 'WR123789', 'william.rodriguez@example.com', '678-901-2345', 'Mexico'),
    ('C010', 'Mia', 'Hernandez', 'MH789456', 'mia.hernandez@example.com', '901-234-5678', 'USA'),
    ('C011', 'Noah', 'Nguyen', 'NN456789', 'noah.nguyen@example.com', '345-678-9012', 'Vietnam'),
    ('C012', 'Isabella', 'Perez', 'IP987654', 'isabella.perez@example.com', '678-901-2345', 'Mexico'),
    ('C013', 'Liam', 'Rivera', 'LR321987', 'liam.rivera@example.com', '901-234-5678', 'USA'),
    ('C014', 'Ava', 'Kim', 'AK987321', 'ava.kim@example.com', '234-567-8901', 'South Korea'),
    ('C015', 'Alexander', 'Lewis', 'AL654987', 'alexander.lewis@example.com', '567-890-1234', 'UK'),
    ('C016', 'Mia', 'Wang', 'MW987456', 'mia.wang@example.com', '890-123-4567', 'China'),
    ('C017', 'Daniel', 'Martinez', 'DM123789', 'daniel.martinez@example.com', '123-456-7890', 'Mexico'),
    ('C018', 'Sophia', 'Kim', 'SK789123', 'sophia.kim@example.com', '456-789-0123', 'USA'),
    ('C019', 'Elijah', 'Gonzalez', 'EG456321', 'elijah.gonzalez@example.com', '789-012-3456', 'Canada'),
    ('C020', 'Charlotte', 'Walker', 'CW123987', 'charlotte.walker@example.com', '012-345-6789', 'USA');

INSERT INTO Airline (Airline_ID, Airline_Name)
VALUES 
    ('AL001', 'VietJet Air'),
    ('AL002', 'Air Canada'),
    ('AL003', 'British Airways'),
    ('AL004', 'Qantas Airways'),
    ('AL005', 'American Airlines');

INSERT INTO Booking (Booking_ID, Date, Customer_ID, Airline_ID)
VALUES 
    ('B001', '2024-02-24 10:00:00',  'C001', 'AL001'),
    ('B002', '2024-02-25 11:30:00', 'C002', 'AL002'),
    ('B003', '2024-02-26 14:45:00', 'C003', 'AL003'),
    ('B004', '2024-02-27 16:20:00', 'C004', 'AL004'),
    ('B005', '2024-02-28 09:00:00', 'C005', 'AL005'),
    ('B006', '2024-02-29 10:30:00',  'C006', 'AL001'),
    ('B007', '2024-03-01 12:15:00', 'C007', 'AL002'),
    ('B008', '2024-03-02 15:00:00', 'C008', 'AL003'),
    ('B009', '2024-03-03 17:30:00', 'C009', 'AL004'),
    ('B010', '2024-03-04 08:45:00',  'C010', 'AL005'),
    ('B011', '2024-03-05 09:30:00',  'C011', 'AL001'),
    ('B012', '2024-03-06 11:00:00',  'C012', 'AL002'),
    ('B013', '2024-03-07 13:45:00', 'C013', 'AL003'),
    ('B014', '2024-03-08 15:20:00', 'C014', 'AL004'),
    ('B015', '2024-03-09 07:00:00',  'C015', 'AL005'),
    ('B016', '2024-03-10 08:30:00', 'C016', 'AL001'),
    ('B017', '2024-03-11 10:15:00',  'C017', 'AL002'),
    ('B018', '2024-03-12 13:00:00',  'C018', 'AL003'),
    ('B019', '2024-03-13 15:30:00',  'C019', 'AL004'),
    ('B020', '2024-03-14 08:15:00',  'C020', 'AL005'),
    ('B021', '2024-02-10 10:00:00', 'C001', 'AL001');

INSERT INTO Aircraft (Aircraft_ID, Model, Manufacturer, Airline_ID)
VALUES 
    ('AC001', 'Airbus A380', 'Airbus', 'AL001'),
    ('AC002', 'Boeing 747', 'Boeing', 'AL002'),
    ('AC003', 'Boeing 777', 'Boeing', 'AL003'),
    ('AC004', 'Airbus A320', 'Airbus', 'AL004'),
    ('AC005', 'Boeing 737', 'Boeing', 'AL005'),
    ('AC006', 'Airbus A350', 'Airbus', 'AL001'),
    ('AC007', 'Boeing 787', 'Boeing', 'AL002'),
    ('AC008', 'Embraer E190', 'Embraer', 'AL003'),
    ('AC009', 'Bombardier CRJ900', 'Bombardier', 'AL004'),
    ('AC010', 'Airbus A330', 'Airbus', 'AL005'),
    ('AC011', 'Boeing 767', 'Boeing', 'AL001'),
    ('AC012', 'Airbus A319', 'Airbus', 'AL002'),
    ('AC013', 'Boeing 777X', 'Boeing', 'AL003'),
    ('AC014', 'Embraer E195', 'Embraer', 'AL004'),
    ('AC015', 'Bombardier Q400', 'Bombardier', 'AL005');

INSERT INTO Airport (Airport_ID, Airport_Name, City, Country)
VALUES 
    ('AP001', N'Sân bay Quốc tế Tân Sơn Nhất', N'Hồ Chí Minh', N'Việt Nam'),
    ('AP002', N'Sân bay Quốc tế Đà Nẵng', N'Đà Nẵng', N'Việt Nam'),
    ('AP003', N'Sân bay Quốc tế Nội Bài', N'Hà Nội', N'Việt Nam'),
    ('AP004', N'Sân bay Quốc tế Cam Ranh', N'Nha Trang', N'Việt Nam'),
    ('AP005', N'Sân bay Quốc tế Phú Quốc', N'Phú Quốc', N'Việt Nam'),
    ('AP006', N'Sân bay Quốc tế Hong Kong', N'Hong Kong', N'Trung Quốc'),
    ('AP007', N'Sân bay Quốc tế Changi', 'Singapore', N'Singapore'),
    ('AP008', N'Sân bay Quốc tế Suvarnabhumi', 'Bangkok', N'Thái Lan'),
    ('AP009', N'Sân bay Quốc tế Kuala Lumpur', 'Kuala Lumpur', 'Malaysia'),
    ('AP010', N'Sân bay Quốc tế Sydney', 'Sydney', 'Australia'),
    ('AP011', N'Sân bay Quốc tế Incheon', 'Seoul', N'Hàn Quốc'),
    ('AP012', N'Sân bay Quốc tế Narita', 'Tokyo', N'Nhật Bản'),
    ('AP013', N'Sân bay Quốc tế Dubai', 'Dubai', N'Các Tiểu vương quốc Arab Thống nhất'),
    ('AP014', N'Sân bay Quốc tế Heathrow', 'London', 'Anh'),
    ('AP015', N'Sân bay Quốc tế Los Angeles', 'Los Angeles', N'Hoa Kỳ');
	DELETE TOP(4) FROM Seat_Class
INSERT INTO Seat_Class (Seat_Class_ID, Class_Name)
VALUES 
    ('SL0', N'First Class - Ghế hạng nhất'),
    ('SL1', N'Business – Hạng Thương gia'),
    ('SL2', N'Premium Economy – Hạng Phổ thông cao cấp'),
    ('SL3', N'Economy – Hạng Phổ thông tiêu chuẩn'),
    ('SL4', N'Basic Economy – Hạng Phổ thông giá rẻ');

INSERT INTO Flight (Flight_Code, Airline_ID)
VALUES 
    ('F1256', 'AL001'),
    ('F1257', 'AL002'),
    ('F1258', 'AL003'),
    ('F1259', 'AL004'),
    ('F1260', 'AL005'),
    ('F1261', 'AL001'),
    ('F1262', 'AL002'),
    ('F1263', 'AL003'),
    ('F1264', 'AL004'),
    ('F1265', 'AL005'),
    ('F1266', 'AL001'),
    ('F1267', 'AL002'),
    ('F1268', 'AL003');


INSERT INTO Leg (Leg_ID, Arrival_Time, Departure_Time, Price, DepartureAirport_ID, ArriveAirport_ID, Aircraft_ID, Flight_Code)
VALUES 
    ('VN1256', '2024-02-24 12:30:00', '2024-02-24 10:00:00', 1500000.510, 'AP001', 'AP002', 'AC001', 'F1256'),
    ('VN1257', '2024-02-25 14:00:00', '2024-02-25 11:30:00', 1550000.510, 'AP002', 'AP003', 'AC001', 'F1257'),
    ('VN1258', '2024-02-26 17:15:00', '2024-02-26 14:45:00', 1600000.510, 'AP003', 'AP004', 'AC001', 'F1258'),
    ('VN1259', '2024-02-27 18:50:00', '2024-02-27 16:20:00', 1650000.510, 'AP004', 'AP005', 'AC001', 'F1259'),
    ('VN1260', '2024-02-28 11:30:00', '2024-02-28 09:00:00', 1700000.510, 'AP005', 'AP001', 'AC002', 'F1260'),
    ('VN1261', '2024-02-29 13:00:00', '2024-02-29 10:30:00', 1750000.510, 'AP001', 'AP003', 'AC002', 'F1261'),
    ('VN1262', '2024-03-01 14:45:00', '2024-03-01 12:15:00', 1800000.510, 'AP002', 'AP004', 'AC009', 'F1262'),
    ('VN1263', '2024-03-02 17:30:00', '2024-03-02 15:00:00', 1850000.510, 'AP003', 'AP005', 'AC010', 'F1263'),
    ('VN1264', '2024-03-03 20:00:00', '2024-03-03 17:30:00', 1900000.510, 'AP004', 'AP001', 'AC011', 'F1264'),
    ('VN1265', '2024-03-04 11:15:00', '2024-03-04 08:45:00', 1950000.510, 'AP005', 'AP002', 'AC012', 'F1265'),
    ('VN1266', '2024-03-05 12:00:00', '2024-03-05 09:30:00', 2000000.510, 'AP001', 'AP004', 'AC013', 'F1266'),
    ('VN1267', '2024-03-06 13:30:00', '2024-03-06 11:00:00', 2050000.510, 'AP002', 'AP005', 'AC014', 'F1267'),
    ('VN1268', '2024-03-07 16:00:00', '2024-03-07 13:30:00', 2100000.510, 'AP003', 'AP001', 'AC015', 'F1268'),
    ('VN1269', '2024-02-25 12:30:00', '2024-02-25 10:00:00', 1500000.010, 'AP002', 'AP003', 'AC002', 'F1256');
	--

-- Cho Aircraft AC001
INSERT INTO Seat (Seat_ID, Aircraft_ID, Seat_Class_ID)
VALUES 
    ('S001', 'AC001', 'SL3'),
('S002', 'AC001', 'SL3'),
('S003', 'AC001', 'SL3'),
('S004', 'AC001', 'SL3'),
('S005', 'AC001', 'SL3'),
('S006', 'AC001', 'SL3'),
('S007', 'AC001', 'SL3'),
('S008', 'AC001', 'SL3'),
('S009', 'AC001', 'SL3'),
('S010', 'AC001', 'SL3'),
('S011', 'AC001', 'SL3'),
('S012', 'AC001', 'SL3'),
('S013', 'AC001', 'SL3'),
('S014', 'AC001', 'SL3'),
('S015', 'AC001', 'SL2'),
('S016', 'AC001', 'SL2'),
('S017', 'AC001', 'SL2'),
('S018', 'AC001', 'SL2'),
('S019', 'AC001', 'SL2'),
('S020', 'AC001', 'SL2'),
('S021', 'AC001', 'SL1'),
('S022', 'AC001', 'SL1'),
('S023', 'AC001', 'SL0')
-- Cho Aircraft AC002
INSERT INTO Seat (Seat_ID, Aircraft_ID, Seat_Class_ID)
VALUES 
    ('S101', 'AC002', 'SL3'),
('S102', 'AC002', 'SL3'),
('S103', 'AC002', 'SL3'),
('S104', 'AC002', 'SL3'),
('S105', 'AC002', 'SL3'),
('S106', 'AC002', 'SL3'),
('S107', 'AC002', 'SL3'),
('S108', 'AC002', 'SL3'),
('S109', 'AC002', 'SL3'),
('S110', 'AC002', 'SL3'),
('S111', 'AC002', 'SL3'),
('S112', 'AC002', 'SL3'),
('S113', 'AC002', 'SL3'),
('S114', 'AC002', 'SL3'),
('S115', 'AC002', 'SL2'),
('S116', 'AC002', 'SL2'),
('S117', 'AC002', 'SL2'),
('S118', 'AC002', 'SL2'),
('S119', 'AC002', 'SL2'),
('S120', 'AC002', 'SL2'),
('S121', 'AC002', 'SL1'),
('S122', 'AC002', 'SL1'),
('S123', 'AC002', 'SL0')
INSERT INTO Booking_Leg (Booking_Leg_ID, Price, Leg_ID, Booking_ID, Seat_ID)
VALUES 
    ('BL001', 1700000.00, 'VN1256', 'B001','S001'),--1
    ('BL002', 1750000.00, 'VN1257', 'B002','S002'),--1
    ('BL003', 1700000.00, 'VN1258', 'B003','S003'),--1
    ('BL004', 1800000.00, 'VN1259', 'B004','S009'),--3
    ('BL005', 2900000.00, 'VN1260', 'B005','S115'),--1
    ('BL006', 2500000.00, 'VN1256', 'B006','S016'),--1
    ('BL007', 1600000.00, 'VN1257', 'B007','S006'),--1
    ('BL008', 1700000.00, 'VN1258', 'B008','S007'),--2
    ('BL009', 3800000.00, 'VN1259', 'B009','S021'),--1
    ('BL010', 4900000.00, 'VN1260', 'B010','S123'),--1
    ('BL011', 1500000.00, 'VN1256', 'B011','S008'),--1
    ('BL012', 1600000.00, 'VN1257', 'B012','S010'),--1
    ('BL013', 1700000.00, 'VN1258', 'B013','S011'),--1
    ('BL014', 1800000.00, 'VN1259', 'B014','S004'),--2
    ('BL015', 2900000.00, 'VN1260', 'B015','S116'),--1
    ('BL016', 1500000.00, 'VN1256', 'B016','S005'),--2
    ('BL017', 4400000.00, 'VN1260', 'B017','S122'),--1
    ('BL018', 1700000.00, 'VN1260', 'B018','S103'),--2
    ('BL019', 1800000.00, 'VN1261', 'B019','S104'),--1
    ('BL020', 1900000.00, 'VN1260', 'B020','S105'),--1
    ('BL021', 1500000.00, 'VN1261', 'B021','S106'),--2
    ('BL022', 1500000.00, 'VN1269', 'B021','S113');--2
