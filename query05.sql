/* Rate neighborhoods by their bus stop accessibility for wheelchairs. 
Use Azavea's neighborhood dataset from OpenDataPhilly along with an appropriate dataset from the Septa GTFS bus feed. 
Use the [GTFS documentation](https://gtfs.org/reference/static/) for help. 
Use some creativity in the metric you devise in rating neighborhoods. 

**Description:**
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
    sum(wheelchair_boarding)/count(stop_id) as wheelchair_rating
from septa_bus_stop_hoods

--thought process: Join neighborhoods with stops.
--Next, count the stops in each neighborhood with wheelchair boarding and the stops without.  Make rating:
--Rating = number of stops with wheelchair_boarding / total stops in neighborhood