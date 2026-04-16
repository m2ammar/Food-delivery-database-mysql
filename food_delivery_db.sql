-- =================================
-- Creating Database food_delivery_db;
-- =================================
Create Database food_delivery_db;
Use food_delivery_db;

-- =================================
-- Creating Table Customers
-- =================================
create table customers(
customer_id int auto_increment primary key,
full_name varchar(50) not null,
email varchar(100)  unique not null,
phone varchar(15) unique not null,
address varchar(150),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =================================
-- Creating Table Restaurants
-- =================================
create table restaurants(
restaurant_id int auto_increment primary key,
name varchar(100) not null,
address varchar(150) not null,
city varchar(50) not null,
cuisine_type varchar(20),
phone varchar(15) unique not null,
rating decimal(2,1),
is_open TINYINT default 1,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ===============================
-- Creating Table menu_categories
-- ===============================
create table menu_categories(
category_id int auto_increment primary key,
restaurant_id int not null,
category_name VARCHAR(50) not null,
foreign key (restaurant_id) references restaurants(restaurant_id)
);
 
-- ===============================
-- Creating Table menu_items
-- ===============================
create table menu_items(
item_id int auto_increment primary key,
restaurant_id int not null, 
category_id int not null,
item_name varchar(40) not null,
description  text,
price decimal(8,2) not null,
is_available TINYINT default 1,
foreign key (restaurant_id) references restaurants(restaurant_id),
foreign key (category_id) references menu_categories(category_id)
);

-- ===============================
-- Creating Table riders
-- ===============================
create table riders(
rider_id int auto_increment primary key,
full_name varchar(30) not null,
phone varchar(30) unique not null,
vehicle_type ENUM ( 'Bike', 'Bicycle', 'Car'),
status ENUM ('Available', 'On Delivery', 'Offline')  default 'Available',
created_at  datetime default  current_timestamp
);

-- ===============================
-- Creating Table orders
-- ===============================
create table orders(
order_id int auto_increment primary key,
customer_id  int not null,
restaurant_id int not null, 
rider_id int,
status ENUM ('Pending', 'Confirmed', 'Preparing', 'Out for Delivery', 'Delivered')  default 'Pending',
delivery_address varchar(100) not null,
total_amount decimal(8,2) not null,
created_at datetime default current_timestamp,
foreign key (customer_id) references customers(customer_id),
foreign key (restaurant_id) references restaurants(restaurant_id),
foreign key (rider_id) references riders(rider_id)
);

-- ===============================
-- Creating Table order_items
-- ===============================
create table order_items(
order_item_id int auto_increment primary key,
order_id int not null,
item_id int not null,
quantity int default 1,
unit_price decimal(8,2) not null,
foreign key (order_id) references orders(order_id),
foreign key (item_id) references menu_items(item_id)
);

-- ===============================
-- Creating Table payments
-- ===============================
create table payments(
payment_id int auto_increment primary key,
order_id int unique not null,
amount decimal(8,2) not null,
payment_method ENUM  ('Cash', 'Card', 'Easypaisa', 'JazzCash')  not null,
payment_status ENUM ('Pending', 'Completed', 'Failed') default 'Pending',
paid_at  datetime default current_timestamp,
foreign key (order_id ) references orders(order_id )
);

-- ===============================
-- Creating Table reviews
-- ===============================
create table reviews(
review_id int auto_increment primary key,
order_id int unique not null,
customer_id integer not null,
restaurant_id int not null,
rider_id int,
restaurant_rating TINYINT,
rider_rating TINYINT,
comment TEXT, 
created_at datetime default current_timestamp,
foreign key (order_id) references orders(order_id),
foreign key (customer_id) references customers(customer_id),
foreign key (restaurant_id) references restaurants(restaurant_id),
foreign key (rider_id) references riders(rider_id),
CHECK (restaurant_rating BETWEEN 1 AND 5),
CHECK (rider_rating BETWEEN 1 AND 5)
);

Show Tables;

-- =================================
-- Inserting data into Customers
-- =================================
INSERT INTO customers (full_name, email, phone, address) VALUES
('Ahmed Raza', 'ahmed.raza@gmail.com', '0301-1234567', 'House 5, Block 3, Gulshan-e-Iqbal'),
('Fatima Khan', 'fatima.khan@gmail.com', '0302-2345678', 'Flat 12, Clifton Block 4'),
('Usman Ali', 'usman.ali@gmail.com', '0303-3456789', 'House 22, DHA Phase 6'),
('Ayesha Siddiqui', 'ayesha.s@gmail.com', '0304-4567890', 'House 7, North Nazimabad'),
('Bilal Malik', 'bilal.malik@gmail.com', '0305-5678901', 'Flat 3, Saddar Town');

-- ================================
-- Inserting data into Restaurant
-- ================================
INSERT INTO restaurants (name, address, city, cuisine_type, phone, rating) VALUES
('Student Biryani', 'Block 2, PECHS', 'Karachi', 'Desi', '0213-4567890', 4.5),
('Kolachi Restaurant', 'Do Darya, Phase 8 DHA', 'Karachi', 'BBQ', '0213-5678901', 4.7),
('Lahooti Lassi', 'Gulshan-e-Iqbal Block 6', 'Karachi', 'Desi', '0213-6789012', 4.2),
('Pizza Point', 'Clifton Block 5', 'Karachi', 'Fast Food', '0213-7890123', 4.0),
('Chaiwaala', 'Saddar Karachi', 'Karachi', 'Beverages', '0213-8901234', 4.3);

-- ================================
-- Inserting data into menu_categories 
-- ================================
INSERT INTO menu_categories (restaurant_id, category_name) VALUES
(1, 'Biryani'),
(1, 'Drinks'),
(2, 'BBQ'),
(2, 'Deals'),
(3, 'Lassi'),
(4, 'Pizza'),
(4, 'Burgers'),
(5, 'Tea'),
(5, 'Snacks');

-- ================================
-- Inserting data into menu_items
-- ================================
INSERT INTO menu_items (restaurant_id, category_id, item_name, description, price) VALUES
(1, 1, 'Chicken Biryani', 'Spicy Karachi style chicken biryani', 350.00),
(1, 1, 'Mutton Biryani', 'Slow cooked mutton biryani', 550.00),
(1, 2, 'Soft Drink', 'Chilled 500ml bottle', 80.00),
(2, 3, 'Seekh Kebab', 'Charcoal grilled seekh kebab 6 pieces', 650.00),
(2, 3, 'Chicken Tikka', 'Marinated grilled chicken half portion', 850.00),
(2, 4, 'Family Deal', 'Tikka + Kebab + Naan + Drink', 1800.00),
(3, 5, 'Sweet Lassi', 'Chilled sweet lassi large glass', 150.00),
(3, 5, 'Salted Lassi', 'Chilled salted lassi large glass', 150.00),
(4, 6, 'Margherita Pizza', 'Classic cheese pizza medium', 950.00),
(4, 7, 'Zinger Burger', 'Crispy chicken zinger with fries', 550.00),
(5, 8, 'Doodh Patti', 'Classic Pakistani milk tea', 60.00),
(5, 9, 'Samosa', 'Crispy fried samosa 2 pieces', 40.00);


-- ================================
-- Inserting data into Riders
-- ================================
INSERT INTO riders (full_name, phone, vehicle_type) VALUES
('Kamran Ahmed', '0311-1111111', 'Bike'),
('Sajid Hussain', '0322-2222222', 'Bike'),
('Tariq Mehmood', '0333-3333333', 'Bike'),
('Imran Shah', '0344-4444444', 'Bicycle'),
('Zubair Khan', '0355-5555555', 'Car');

-- ================================
-- Inserting data into Orders
-- ================================
INSERT INTO orders (customer_id, restaurant_id, rider_id, status, delivery_address, total_amount) VALUES
(1, 1, 1, 'Delivered', 'House 5, Block 3, Gulshan-e-Iqbal', 430.00),
(2, 2, 2, 'Delivered', 'Flat 12, Clifton Block 4', 1500.00),
(3, 4, 3, 'Delivered', 'House 22, DHA Phase 6', 1100.00),
(4, 3, 4, 'Out for Delivery', 'House 7, North Nazimabad', 300.00),
(5, 5, NULL, 'Preparing', 'Flat 3, Saddar Town', 100.00),
(1, 2, 1, 'Delivered', 'House 5, Block 3, Gulshan-e-Iqbal', 850.00),
(2, 4, 2, 'Confirmed', 'Flat 12, Clifton Block 4', 950.00);

-- ================================
-- Inserting data into Order_items
-- ================================
INSERT INTO order_items (order_id, item_id, quantity, unit_price) VALUES
(1, 1, 1, 350.00),
(1, 3, 1, 80.00),
(2, 4, 1, 650.00),
(2, 5, 1, 850.00),
(3, 10, 1, 550.00),
(3, 9, 1, 950.00),
(4, 7, 1, 150.00),
(4, 8, 1, 150.00),
(5, 11, 1, 60.00),
(5, 12, 1, 40.00),
(6, 5, 1, 850.00),
(7, 9, 1, 950.00);

-- ================================
-- Inserting data into payments
-- ================================
INSERT INTO payments (order_id, amount, payment_method, payment_status, paid_at) VALUES
(1, 430.00, 'Cash', 'Completed', '2026-04-10 13:25:00'),
(2, 1500.00, 'Easypaisa', 'Completed', '2026-04-10 14:10:00'),
(3, 1100.00, 'Card', 'Completed', '2026-04-11 19:45:00'),
(4, 300.00, 'Cash', 'Pending', NULL),
(5, 100.00, 'JazzCash', 'Pending', NULL),
(6, 850.00, 'Card', 'Completed', '2026-04-12 21:30:00'),
(7, 950.00, 'Easypaisa', 'Pending', NULL);

-- ================================
-- Inserting data into reviews
-- ================================
INSERT INTO reviews (order_id, customer_id, restaurant_id, rider_id, restaurant_rating, rider_rating, comment) VALUES
(1, 1, 1, 1, 5, 4, 'Best biryani in Karachi, delivery was quick!'),
(2, 2, 2, 2, 5, 5, 'Kolachi never disappoints, amazing BBQ!'),
(3, 3, 4, 3, 4, 4, 'Good pizza and fast delivery to DHA'),
(6, 1, 2, 1, 5, 5, 'Chicken tikka was perfect, rider was on time');

-- ================================
-- Writing Queries
-- ================================

Select *
from restaurants;
-- ================================

Select *
from restaurants
where is_open= 1;
-- ================================

select ord.order_id, cus.full_name, ord.delivery_address, ord.total_amount, ord.status
from customers as cus
join orders ord on cus.customer_id = ord.customer_id;
-- ================================

select cus.full_name, sum(ord.total_amount) as total_spent 
from customers as cus
join orders ord on cus.customer_id = ord.customer_id
group by cus.customer_id, cus.full_name;
-- ================================

Select r.name, count(ord.order_id) as total_orders
from restaurants r
join orders ord on r.restaurant_id = ord.restaurant_id
group by r.name 
order by total_orders desc limit 3;
-- ================================

select rest.name, round(avg(rev.restaurant_rating),1) as avg_rating
from restaurants rest
join reviews rev on rest.restaurant_id = rev.restaurant_id
group by rest.name
order by avg_rating desc 
limit 3;
-- ================================

select ord.order_id, cust.full_name as customer_name, rest.name as restaurant_name,
rid.full_name as rider_name, ord.status
from orders ord
join customers cust on cust.customer_id = ord.customer_id
join restaurants rest on rest.restaurant_id = ord.restaurant_id
left join riders rid on rid.rider_id = ord.rider_id;
-- ================================

Select full_name
from customers
where customer_id in(
Select customer_id
from orders
group by customer_id
having count(order_id)>1);
-- ================================

Select rest.name, sum(ord.total_amount) as total_revenue
from restaurants rest
join orders ord on rest.restaurant_id = ord.restaurant_id
group by rest.name
order by total_revenue desc;
-- ================================

select ord.order_id, cust.full_name, rest.name, ord.status
from orders ord
join restaurants rest on rest.restaurant_id= ord.restaurant_id
join customers cust on cust.customer_id = ord.customer_id
where ord.status !='Delivered';
-- ================================

