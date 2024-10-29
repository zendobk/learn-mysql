create table customers (
  customer_id int auto_increment primary key,
  first_name varchar(50),
  last_name varchar(50),
  email varchar(100),
  created_at timestamp default current_timestamp
);

create table products (
  product_id int auto_increment primary key,
  name varchar(100),
  description text,
  price decimal(10, 2),
  created_at timestamp default current_timestamp
);

create table orders (
  order_id int auto_increment primary key,
  customer_id int,
  order_date timestamp default current_timestamp,
  total decimal(10, 2),
  foreign key (customer_id) references customers (customer_id)
);

create table order_items (
  order_item_id int auto_increment primary key,
  order_id int,
  product_id int,
  quantity int,
  price decimal(10, 2),
  foreign key (order_id) references orders (order_id),
  foreign key (product_id) references products (product_id)
);
