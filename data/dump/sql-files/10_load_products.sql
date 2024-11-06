load data infile '/docker-entrypoint-initdb.d/csv-files/products.csv'
  into table products
  fields terminated by ','
  enclosed by '"'
  lines terminated by '\n'
  ignore 1 rows;
