-- generate 1 million records for products
delimiter $$
create procedure populate_products ()
begin
  declare batch_size int default 5000;
  declare total_records int default 10000000;
  declare i int default 1;

  set foreign_key_checks = 0;

  while i <= total_records do
    set @sql = 'insert into products (name, description, price) values ';
    set @values = '';
    set @j = 1;

    while @j <= batch_size do
      set @name = concat('product', i);
      set @description = 'description of product';
      set @price = round(rand() * 100, 2);
      set @values = concat(@values, '(',
      '"', @name, '", ',
      '"', @description, '", ',
      @price, ')');

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

call populate_products ();
drop procedure populate_products;
