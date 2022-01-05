/* Using the _shapes.txt_ file from GTFS bus feed, find the **two** routes with the longest trips. 
In the final query, give the `trip_headsign` that corresponds to the `shape_id` of this route and the length of the trip. 

  **Structure:**
  ```sql
  (
      trip_headsign text,  -- Headsign of the trip
      trip_length double precision  -- Length of the trip in meters
  )
  ```

*/

alter table shapes
    add column if not exists trip_length geometry(Point, 4326);

update shapes
  set trip_length = ????;

select
    t.trip_headsign,
    trip_length
from shapes as s
join trips as t on shape_id
order by trip_length asc
limit 2


--thought process: group by shape_id and detemine trip_length.  how do you calculate trip lenght?
--Next, join shapes with trips, select desired info and order by trip length-limit 2.