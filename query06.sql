/* What are the _top five_ neighborhoods according to your accessibility metric?

  **Both #6 and #7 should have the structure:**
  ```sql
  (
    neighborhood_name text,  -- The name of the neighborhood
    accessibility_metric ...,  -- Your accessibility metric value
    num_bus_stops_accessible integer,
    num_bus_stops_inaccessible integer
  )
  ```
 */

with septa_bus_stop_hoods as (
    select
        s.stop_id,
        s.wheelchair_boarding
    from septa_bus_stops as s
    join hoods as h
        on ST_DWithin(
            ST_Transform(s.the_geom, 32129),
            ST_Transform(h.the_geom, 32129)
        )
),
select
    neighborhood_name
    sum(wheelchair_boarding)/count(stop_id) as wheelchair_rating
    sum(wheelchair_boarding) as num_bus_stops_accessible
    count(stop_id) - sum(wheelchair_boarding) as num_bus_stops_inaccessible
from septa_bus_stop_hoods
order by wheelchair_rating desc
limit 5

--thought process: same as query05, just order by rating in desc order - limit 5