-- generate 100k records for customers
delimiter $$
create procedure populate_customers ()
begin
  declare batch_size int default 5000;
  declare total_records int default 10000000;
  declare i int default 1;

  set foreign_key_checks = 0;

  while i <= total_records do
    set @sql = 'insert into customers (first_name, last_name, email) values ';
    set @values = '';
    set @j = 1;

    while @j <= batch_size do
      set @first_name = concat('first', @j);
      set @last_name = concat('last', @j);
      set @email = concat('email', @j, '@example.com');
      set @values = concat(@values, '(',
        '"', @first_name,'", ',
        '"', @last_name, '", ',
        '"', @email, '")'
      );

      if @j < batch_size then
        set @values = concat(@values, ', ');
      end if;

      set @j = @j + 1;
    end while;

    set @sql = concat(@sql, @values);

    prepare stmt from @sql;
    execute stmt;
    deallocate prepare stmt;

    set i = i + batch_size;
  end while;

  set foreign_key_checks = 1;

end $$
delimiter ;

call populate_customers ();
drop procedure populate_customers;
