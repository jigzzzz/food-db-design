CREATE DATABASE food_oms;
USE food_oms;

CREATE TABLE Customers (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL
);

CREATE TABLE Orders (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_date DATETIME NOT NULL,
    total_order INT NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(id)
);

CREATE TABLE Items (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price INT NOT NULL
);

CREATE TABLE OrderDetails (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,	
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    item_id INT NOT NULL,
    FOREIGN KEY (item_id) REFERENCES Items(id),
    qty INT NOT NULL
);


INSERT INTO Customers (name, phone_number) VALUES('Ariana', '021635287');
INSERT INTO Customers (name, phone_number) VALUES('Jack', '021982317');
INSERT INTO Customers (name, phone_number) VALUES('Johnson', '021746426');
INSERT INTO Customers (name, phone_number) VALUES('Veronica', '021853481');
INSERT INTO Customers (name, phone_number) VALUES('Adam', '021972351');

INSERT INTO Orders (order_date, total_order, customer_id) VALUES (NOW(), 35, 1);
INSERT INTO Orders (order_date, total_order, customer_id) VALUES (NOW(), 50, 2);
INSERT INTO Orders (order_date, total_order, customer_id) VALUES (NOW(), 15, 3);
INSERT INTO Orders (order_date, total_order, customer_id) VALUES (NOW(), 20, 4);
INSERT INTO Orders (order_date, total_order, customer_id) VALUES (NOW(), 10, 5);

INSERT INTO Items (name, price) VALUES ('Pudding', 10);
INSERT INTO Items (name, price) VALUES ('Ice Cream', 5);
INSERT INTO Items (name, price) VALUES ('Pasta', 20);
INSERT INTO Items (name, price) VALUES ('Kebab', 15);
INSERT INTO Items (name, price) VALUES ('Chicken Steak', 30);

-- Ariani $35
INSERT INTO OrderDetails (order_id, item_id, qty) VALUES (1, 1, 1);
INSERT INTO OrderDetails (order_id, item_id, qty) VALUES (1, 2, 1);
INSERT INTO OrderDetails (order_id, item_id, qty) VALUES (1, 3, 1);

-- Jack $50
INSERT INTO OrderDetails (order_id, item_id, qty) VALUES (2, 2, 1);
INSERT INTO OrderDetails (order_id, item_id, qty) VALUES (2, 4, 1);
INSERT INTO OrderDetails (order_id, item_id, qty) VALUES (2, 5, 1);

-- Johnson $15
INSERT INTO OrderDetails (order_id, item_id, qty) VALUES (3, 4, 1);

-- Veronica $20
INSERT INTO OrderDetails (order_id, item_id, qty) VALUES (4, 3, 1);

-- Adam $10
INSERT INTO OrderDetails (order_id, item_id, qty) VALUES (5, 2, 2);

SELECT 
	B.id AS `Order ID`,
	DATE_FORMAT(B.order_date, "%W, %M %e %Y %T") AS `Order Date`,
	A.name AS `Customer Name`,
    A.phone_number AS `Customer Phone`,
    CONCAT('$', B.total_order) AS `Total`,
    GROUP_CONCAT(D.name) AS `Items Bought`
FROM
	Customers A
JOIN
	Orders B
ON
	A.id = B.customer_id
JOIN
	OrderDetails C
ON
	B.id = C.order_id
JOIN
	Items D
ON
	C.item_id = D.id
GROUP BY
	A.id