load data infile '/docker-entrypoint-initdb.d/csv-files/orders.csv'
  into table orders
  fields terminated by ','
  enclosed by '"'
  lines terminated by '\n'
  ignore 1 rows;
