#koji hoteli ostvaruju najveci prihod
SELECT h.hotel_name, cn.country_name,
	SUM(f.total_price) AS total_revenue
FROM dw_fact_reservation f
JOIN dw_dim_hotel h ON f.hotel_id = h.hotel_id
JOIN dw_dim_city c ON h.city_id = c.city_id
JOIN dw_dim_country cn ON c.country_id = cn.country_id
GROUP BY h.hotel_name, cn.country_name
ORDER BY total_revenue DESC;

# koja vrsta sobe donosi najvise prihoda po godini
SELECT r.room_type, t.year,
	SUM(f.payment_amount) AS revenue
FROM dw_fact_reservation f 
JOIN dw_dim_room r ON f.room_id = r.room_id
JOIN dw_dim_time t ON f.time_id = t.time_id
GROUP BY t.year, r.room_type
ORDER BY t.year ASC, revenue DESC;

# koliko nocenja biraju gosti iz razlicitih zemalja
SELECT ctry.country_name,
	SUM(f.num_nights) AS total_nights
FROM dw_fact_reservation f
JOIN dw_dim_customer cust ON f.customer_id = cust.customer_id
JOIN dw_dim_city city ON cust.city_id = city.city_id
JOIN dw_dim_country ctry ON city.country_id = ctry.country_id
GROUP BY ctry.country_name
ORDER BY total_nights DESC;

#najcesci posjetioci
select
	c.customer_id,
    c.full_name,
    count(*) as total_res,
    CASE
		WHEN COUNT(*) > 1 THEN 'ponovni gost'
		ELSE 'jedna posjeta'
	END AS guest_type
FROM dw_fact_reservation f
JOIN dw_dim_customer c ON f.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_res DESC;

#prihodi zaposlenog u poredjenju sa brojem ostvarenih rezervacija
SELECT
	e.full_name AS employee,
    COUNT(*) AS completed_res,
    SUM(f.total_price) AS total_revenue
FROM dw_fact_reservation f
JOIN dw_dim_employee e ON f.employee_id = e.employee_id
where f.status = "completed"
GROUP BY f.employee_id
ORDER BY total_revenue DESC;

#analiza rezervacija soba po mjesecu
WITH monthly_counts AS (
	SELECT 
		t.year,
        t.month,
        r.room_type,
        COUNT(*) AS num_reservations
	FROM dw_fact_reservation f
    JOIN dw_dim_time t ON f.time_id = t.time_id
    JOIN dw_dim_room r ON f.room_id = r.room_id
    GROUP BY t.year, t.month, r.room_type
),
ranked AS (
	SELECT 
		year,
        month,
        room_type,
        num_reservations,
        ROW_NUMBER() OVER (PARTITION BY year, month ORDER BY num_reservations DESC) AS rn
	FROM monthly_counts
)
SELECT 
	year,
    month,
    room_type,
    num_reservations AS total_reservations
FROM ranked;

#kako ocjene gostiju uticu na popunjenost hotela
SELECT 
	h.hotel_id, h.hotel_name,
    AVG(r.rating) AS avg_rating,
    COUNT(DISTINCT r.customer_id) AS total_reservations
FROM dw_fact_review r
JOIN dw_dim_hotel h
	ON r.hotel_id = h.hotel_id
LEFT JOIN dw_fact_reservation f
	ON f.hotel_id = h.hotel_id
GROUP BY h.hotel_id
ORDER BY total_reservations DESC, avg_rating DESC;

#ukupna zarada za sve hotele koji su ostvarili rezervaciju u 2022.
select h.hotel_name, c.city_name, r.num_nights, r.payment_amount
from dw_fact_reservation r
join dw_dim_hotel h
	on r.hotel_id = h.hotel_id
join dw_dim_city c on
	h.city_id = c.city_id
join dw_dim_time t on 
	r.time_id = t.time_id
where r.status = "completed" and t.year = 2022
order by r.num_nights desc;