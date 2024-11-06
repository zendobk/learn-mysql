load data infile '/docker-entrypoint-initdb.d/csv-files/customers.csv'
  into table customers
  fields terminated by ','
  enclosed by '"'
  lines terminated by '\n'
  ignore 1 rows;
