Problem 1 : Game Play Analysis II

# Write your MySQL query statement below
with cte as (
    select player_id, device_id, row_number() over(partition by player_id 
    order by event_date) as rnk from Activity
)

select player_id, device_id from cte 
where rnk = 1

Problem 2 : Game Play Analysis III

# Write your MySQL query statement below
select player_id, event_date, sum(games_played) over(partition by player_id
order by event_date) as games_played_so_far from Activity

Problem 3 : Shortest Distance in a Plane

# Write your MySQL query statement below
with cte as (
    select p1.x as x1 , p1.y as y1, p2.x as x2, p2.y as y2, 
    sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2)) as distance
    from Point2D p1 join Point2D p2 on p1.x != p2.x or p1.y != p2.y
)

select round(min(distinct distance),2) as shortest from cte

Problem 4 : Combine Two Tables

# Write your MySQL query statement below
select p.firstName, p.lastName, ifnull(a.city, Null) as city, 
ifnull(a.state, Null) as state
from Person p left join Address a on p.personId = a.personId

Problem 5 : Customers with Strictly Increasing Purchases

with yearly as
(select customer_id, year(order_date) as year, sum(price) as price
from orders
group by year(order_date),customer_id)

select y1.customer_id from
yearly y1 left join yearly y2 on y1.customer_id = y2.customer_id 
and y1.year + 1 = y2.year and y1.price < y2.price
group by y1.customer_id
having count(y1.customer_id) - count(y2.customer_id) = 1
