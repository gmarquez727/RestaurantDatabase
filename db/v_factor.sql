use Food;

select restaurant_name, veggie_count/total_count as v_factor from
    ((select restaurant_name, count(item_name) as veggie_count
    from
        (Serves
        natural join
        (select name as item_name, veggie from Item) d)
    where veggie = 'Y'
    group by restaurant_name) e
    natural join
    (select restaurant_name, count(item_name) as total_count
    from Serves
    group by restaurant_name) c)
order by v_factor desc
into outfile '/tmp/v_factor.csv'
fields terminated by ','
lines terminated by '\n';
