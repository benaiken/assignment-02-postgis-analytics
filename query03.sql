/* Using the Philadelphia Water Department Stormwater Billing Parcels dataset, pair each parcel with its closest bus stop. 
The final result should give the parcel address, bus stop name, and distance apart in meters. Order by distance (largest on top).

  **Structure:**
  ```sql
  (
      address text,  -- The address of the parcel
      stop_name text,  -- The name of the bus stop
      distance_m double precision  -- The distance apart in meters
  )
  ```

*/ 

alter table septa_bus_stops
    add column if not exists the_geom geometry(Point, 4326);


with PWD_bus as (
    select
        (s.the_geom <-> par.?????) as distance_m
    from septa_bus_stops as s
    join PWD_PARCELS as par
        on ST_DWithin(
            ST_Transform(s.the_geom, 32129),
            ST_Transform(bg.the_geom, 32129),
            800
        )
)
select
    address,
    stop_name,
    distance_m
from PWD_bus
order by distance_m desc

--thought process: determine the closest stop to each parcel, measure distance, select desired info.  But how do I convert the Parcels into points?