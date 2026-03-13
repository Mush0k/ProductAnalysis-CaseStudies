#количество заказов по статусу
select
order_status,
count(*) as total_orders
from olist_orders_dataset
group by order_status
order by total_orders desc;

#самый популярный способ оплаты в Бразилии
select payment_type,
count(*) as payment_type_counts
from olist_order_payments_dataset oopd 
group by payment_type 
order by payment_type_counts desc;

#какая средняя сумма чека у заказов со статусом 'delivered' (доставлено)
select
order_status, avg(oopd.payment_value ) as avg_sum from olist_orders_dataset ood 
join 
olist_order_payments_dataset oopd 
on ood.order_id = oopd.order_id 
where ood.order_status = 'delivered'
group by ood.order_status 
order by avg_sum desc;

#нужно узнать не просто количество оплат, 
#а на какую общую сумму накупили товаров в зависимости 
#от их статуса (например, сколько денег зависло в статусе processing)

#для этого объединяю таблицу заказов (orders) и таблицу платежей (payments)

select
o.order_status,
sum(p.payment_value) as total_sum
from olist_orders_dataset o
join olist_order_payments_dataset p
on o.order_id = p.order_id
group by o.order_status 
order by total_sum desc;