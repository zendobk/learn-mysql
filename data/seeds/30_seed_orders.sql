-- generate 100k records for orders
delimiter $$
create procedure populate_orders ()
begin
  declare batch_size int default 5000;
  declare total_records int default 10000000;
  declare i int default 1;

  set foreign_key_checks = 0;

  while i <= total_records do
    set @sql = 'insert into orders (customer_id, total) values ';
    set @values = '';
    set @j = 1;

    while @j <= batch_size do
      set @customer_id = floor(1 + rand() * total_records);
      set @total = round(rand() * 1000, 2);

      set @values = concat(@values, '(',
        @customer_id, ', ',
        @total, ')'
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

call populate_orders ();
drop procedure populate_orders;

-- generate 100k records for order items
delimiter $$
create procedure populate_order_items ()
begin
  declare batch_size int default 5000;
  declare total_records int default 10000000;
  declare i int default 1;

  set foreign_key_checks = 0;

  while i <= total_records do
    set @sql = 'insert into order_items (order_id, product_id, quantity, price) values ';
    set @values = '';
    set @j = 1;

    while @j <= batch_size do
      set @order_id = floor(1 + rand() * total_records);
      set @product_id = floor(1 + rand() * total_records);
      set @quantity = floor(1 + rand() * 10);
      set @price = round(rand() * 100, 2);

      set @values = concat(@values, '(',
        @order_id, ', ',
        @product_id, ', ',
        @quantity, ', ',
        @price, ')'
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

call populate_order_items ();
drop procedure populate_order_items;
