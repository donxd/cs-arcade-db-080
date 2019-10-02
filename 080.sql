/*Please add ; after each select statement*/
CREATE PROCEDURE driversInfo()
BEGIN 
    SET @n = 0;
    SET @nn = 0;
    
    SELECT 
    r.summary
    -- r.*
    FROM (
        -- /*
        (
        SELECT 
        CONCAT(' Total miles driven by all drivers combined: ', SUM(miles_logged)) summary
        , 0 id1
        -- , 0 id2
        -- , 0 id3
        , '' id2
        , '' id3
        , 0 id4
        FROM inspections
        ) UNION (
        SELECT 
        CONCAT(' Name: ', d.driver_name,'; number of inspections: ', d.number_inspections_driver ,'; miles driven: ', d.total_miles_driver) summary
        , 1 id1
        -- , d.id
        -- , d.number_inspections_driver id2
        -- , d.total_miles_driver id3
        -- , d.total_miles_driver id3
        , d.driver_name id2
        , d.driver_name id3
        -- , 0 id3
        , 0 id4
        FROM (
            SELECT 
            ddd.*
            , (@n := @n +1) id
            FROM (
                SELECT 
                driver_name
                , SUM(miles_logged) total_miles_driver
                , COUNT(*) number_inspections_driver
                FROM inspections
                GROUP BY driver_name
                ORDER BY driver_name ASC
            ) ddd
        ) d
        -- / *
        ) UNION 
        -- */
        (
        SELECT
        CONCAT('  date: ', i.date ,'; miles covered: ', i.miles_logged) summary
        , 1 id1
        -- , dd.number_inspections_driver id2
        , dd.driver_name id2
        , dd.driver_name id3
        -- , dd.total_miles_driver id3
        -- , (@nn := @nn +1) id3
        , ((YEAR(i.date)*10000)+(MONTH(i.date)*100)+DAY(i.date)) id4
        FROM (
            SELECT 
            dddd.*
            -- , (@nn := @nn +1) id
            FROM (
                SELECT 
                driver_name
                -- , SUM(miles_logged) total_miles_driver
                -- , COUNT(*) number_inspections_driver
                -- , (@nn := @nn +1) id
                FROM inspections
                GROUP BY driver_name
                ORDER BY driver_name ASC
            ) dddd
        ) dd INNER JOIN inspections i ON i.driver_name = dd.driver_name
        -- ORDER BY i.driver_name, i.date ASC
        -- ORDER BY dd.number_inspections_driver DESC, i.date ASC
        -- ORDER BY dd.id ASC, i.date ASC
        -- */
        )
    ) r
    ORDER BY r.id1 ASC, r.id2 ASC, r.id3 ASC, r.id4 ASC
    ;
END