CREATE DATABASE QuanLyTour;
USE QuanLyTour;

CREATE TABLE City(
    city_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
    city_name VARCHAR(50)
);
INSERT INTO City (city_id, city_name) VALUES
(1,'Ha Noi'),
(2,'TP HCM'),
(3,'Thai Binh'),
(4,'Da Nang'),
(5,'Hue');

CREATE TABLE Destinations(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
    name VARCHAR(50) NOT NULL ,
    description VARCHAR(50) NOT NULL ,
    avgPrice FLOAT,
    cityID INT NOT NULL,
    FOREIGN KEY (cityID) REFERENCES City (city_id)
);
INSERT INTO Destinations (id, name, description, avgPrice, cityID) VALUES
(1,'Pho co','Mon an ngon',500000,1),
(2,'LandMark81','Toa nha cao nhat viet nam',1500000,2),
(3,'Bien Con Vanh','Bai bien dep',300000,3),
(4,'Ba Na Hills','Canh dep',2000000,4),
(5,'Co do Hue','Di tich lich su',1000000,5);

CREATE TABLE Customer(
    customerID INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
    customerName VARCHAR(50) NOT NULL ,
    CCCD INT DEFAULT 0,
    dateOfBirth DATETIME,
    cityId INT,
    FOREIGN KEY (cityId) REFERENCES City (city_id)
);
INSERT INTO Customer (customerID, customerName, CCCD, dateOfBirth, cityId) VALUES
(1,'Tran Duy Tung',0,'1999-11-09',2),
(2,'Nguyen Van A',0,'1998-11-17',1),
(3,'Nguyen VAn B',0,'1994-01-09',2),
(4,'Tran Van C',0,'1995-01-19',2),
(5,'Tran Van D',0,'1998-06-09',2),
(6,'Le Thi A',0,'1995-11-15',2),
(7,'Tran Van Q',0,'1999-11-26',3),
(8,'Dang Van C',0,'1999-11-30',5),
(9,'Tran Van K',0,'1999-11-20',2),
(10,'Nguyen Thi G',0,'1999-12-09',2);

CREATE TABLE tourType(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
    code VARCHAR(20),
    type VARCHAR(50)
);
INSERT INTO tourType (id, code, type) VALUES
(1,'DL1','Du lich tham quan'),
(2,'DL2','Du lich am thuc');

CREATE TABLE Tour(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
    codeTour VARCHAR(20),
    typeID INT NOT NULL ,
    price FLOAT,
    startDate DATE,
    endDate DATE,
    FOREIGN KEY (typeID) REFERENCES tourType (id)
);
INSERT INTO Tour (id, codeTour, typeID, price, startDate, endDate) VALUES
 (1,'a1',1,2000000,'2021-3-12','2021-3-19'),
 (2,'b1',2,2500000,'2020-3-1','2020-3-15'),
 (3,'c1',1,3000000,'2021-3-16','2021-3-21'),
 (4,'a11',1,1000000,'2020-2-12','2020-3-1'),
 (5,'a12',1,2000000,'2020-3-2','2020-3-7'),
 (6,'a13',1,3000000,'2021-3-12','2020-4-1'),
 (7,'b1',2,2000000,'2020-3-5','2020-3-19'),
 (8,'bc1',2,2000000,'2021-3-11','2021-3-19'),
 (9,'a111',1,3000000,'2021-3-21','2021-3-27'),
 (10,'ac1',2,3000000,'2021-3-2','2021-3-9'),
 (11,'avc1',1,1000000,'2021-3-3','2021-3-9'),
 (12,'a113',2,2000000,'2021-3-4','2021-3-12'),
 (13,'a34',2,1000000,'2021-3-5','2021-3-15'),
 (14,'a2341',2,2000000,'2021-3-6','2021-3-19'),
 (15,'a12314x',1,3000000,'2021-3-7','2021-3-19');

CREATE TABLE Bill(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
    tourID INT NOT NULL ,
    customerId INT NOT NULL ,
    status BIT,
    FOREIGN KEY (tourID) REFERENCES Tour(id),
    FOREIGN KEY (customerId) REFERENCES Customer(customerID)
);
INSERT INTO Bill (id, tourID, customerId, status) VALUES
(1,13,10,1),
(2,1,9,1),
(3,13,8,0),
(4,13,7,1),
(5,13,6,1),
(6,12,5,1),
(7,15,4,0),
(8,13,3,1),
(9,13,2,1),
(10,13,1,1);

# Thống kê số lượng tour của các thành phố
SELECT city_name, city_id, COUNT(city_id) AS 'So luong' FROM City
    JOIN Customer C on City.city_id = C.cityId JOIN Bill B on C.customerID = B.customerId GROUP BY city_id;

# Tính số tour có ngày bắt đầu trong tháng 3 năm 2020
SELECT codeTour, COUNT(startDate) AS 'So luong' FROM Tour
WHERE MONTH(startDate) = 3 AND YEAR(startDate) = 2020 GROUP BY codeTour;

# Tính số tour có ngày kết thúc trong tháng 4 năm 2020
SELECT codeTour, COUNT(endDate) AS 'So luong' FROM Tour
WHERE MONTH(endDate) = 4 AND YEAR(endDate) = 2020 GROUP BY codeTour;
