--section 30

---json and jsonb data type

CREATE TABLE books (
	id serial,
	bookinfo jsonb
)

INSERT INTO books (bookinfo)
VALUES
('{"title": "Introduction To Data Mining",
  "author": ["Pang-ning Tan", "Michael Steinbach", "Vipin Kumar"],
  "publisher":"Addison Wesley", "date": 2006}'),
('{"title": "Deep Learning with Python", "author": "Francois Chollet", "publisher":"Manning", "date": 2018}'),
('{"title": "Neural Networks - A Visual Intro for Beginners", "author": "Michael Taylor", "publisher":"self", "date": 2017}'),
('{"title": "Big Data In Practice", "author": "Bernard Marr", "publisher":"Wiley", "date": 2016}');


 SELECT bookinfo->'author' FROM books;

 INSERT INTO books (bookinfo) VALUES
 ('{"title": "Artificial Intelligence With Uncertainty");


 SELECT bookinfo->'title' FROM books;




--create json from tables 

SELECT jsonb_build_object(
	'id', air.id,
	'ident', air.ident,
	'name', air.name,
	'latitude_deg', air.latitude_deg,
	'elevation_ft', air.elevation_ft,
	'continent', air.continent,
	'iso_country', air.iso_country,
	'iso_region', air.iso_region,
	'airport_home_link', air.home_link,
	'airport_wikipedia_link', air.wikipedia_link,
	'municipality', air.municipality,
	'scheduled_service', air.scheduled_service,
	'gps_code', air.gps_code,
	'iata_code', air.iata_code,
	'airport_local_code', air.local_code
)
FROM airports AS air;

SELECT jsonb_build_object(
	'id', air.id,
	'ident', air.ident,
	'name', air.name,
	'latitude_deg', air.latitude_deg,
	'elevation_ft', air.elevation_ft,
	'continent', air.continent,
	'iso_country', air.iso_country,
	'iso_region', air.iso_region,
	'airport_home_link', air.home_link,
	'airport_wikipedia_link', air.wikipedia_link,
	'municipality', air.municipality,
	'scheduled_service', air.scheduled_service,
	'gps_code', air.gps_code,
	'iata_code', air.iata_code,
	'airport_local_code', air.local_code,
	'airport_keywords', to_jsonb(string_to_array(air.keywords, ','))
)
FROM airports AS air;


SELECT jsonb_build_object(
	'id', air.id,
	'ident', air.ident,
	'name', air.name,
	'latitude_deg', air.latitude_deg,
	'elevation_ft', air.elevation_ft,
	'continent', air.continent,
	'iso_country', air.iso_country,
	'iso_region', air.iso_region,
	'airport_home_link', air.home_link,
	'airport_wikipedia_link', air.wikipedia_link,
	'municipality', air.municipality,
	'scheduled_service', air.scheduled_service,
	'gps_code', air.gps_code,
	'iata_code', air.iata_code,
	'airport_local_code', air.local_code,
	'airport_keywords', to_jsonb(string_to_array(air.keywords, ',')),
	'country_name', countries.name,
	'country_wikipedia_link', countries.wikipedia_link,
	'country_keywords', to_jsonb(string_to_array(countries.keywords, ',')),
	'region_name', regions.name,
	'region_wikipedia_link', regions.wikipedia_link,
	'regions_keywords', to_jsonb(string_to_array(regions.keywords, ','))
)
FROM airports AS air
INNER JOIN regions ON air.iso_region=regions.code
INNER JOIN countries ON air.iso_country = countries.code;

SELECT JSONB_STRIP_NULLS (
	 jsonb_build_object(
	'id', air.id,
	'ident', air.ident,
	'name', air.name,
	'latitude_deg', air.latitude_deg,
	'elevation_ft', air.elevation_ft,
	'continent', air.continent,
	'iso_country', air.iso_country,
	'iso_region', air.iso_region,
	'airport_home_link', air.home_link,
	'airport_wikipedia_link', air.wikipedia_link,
	'municipality', air.municipality,
	'scheduled_service', air.scheduled_service,
	'gps_code', air.gps_code,
	'iata_code', air.iata_code,
	'airport_local_code', air.local_code,
	'airport_keywords', to_jsonb(string_to_array(air.keywords, ',')),
	'country_name', countries.name,
	'country_wikipedia_link', countries.wikipedia_link,
	'country_keywords', to_jsonb(string_to_array(countries.keywords, ',')),
	'region_name', regions.name,
	'region_wikipedia_link', regions.wikipedia_link,
	'regions_keywords', to_jsonb(string_to_array(regions.keywords, ','))
))
FROM airports AS air
INNER JOIN regions ON air.iso_region=regions.code
INNER JOIN countries ON air.iso_country = countries.code;


--aggrigrating json files

SELECT to_jsonb(runway_json) FROM
(SELECT le_ident, he_ident, length_ft, width_ft, surface, lighted AS is_lighted,
closed AS is_closed,
le_latitude_deg, le_longitude_deg,le_elevation_ft,le_displaced_threshold_ft,
he_latitude_deg,he_longitude_deg,he_elevation_ft, he_heading_degt,he_displaced_threshold_ft
FROM runways
WHERE airport_ident = 'JRA') as runway_json;


SELECT JSONB_AGG(to_jsonb(runway_json)) FROM
(SELECT le_ident, he_ident, length_ft, width_ft, surface, lighted AS is_lighted,
closed AS is_closed,
le_latitude_deg, le_longitude_deg,le_elevation_ft,le_displaced_threshold_ft,
he_latitude_deg,he_longitude_deg,he_elevation_ft, he_heading_degt,he_displaced_threshold_ft
FROM runways
WHERE airport_ident = 'JRA') as runway_json;

SELECT JSONB_AGG(to_jsonb(nav)) FROM
(SELECT name, filename, ident, type, frequency_khz,
latitude_deg, longitude_deg, elevation_ft, dme_frequency_khz,
dme_channel, dme_latitude_deg, dme_latitude_deg,dme_elevation_ft,
slaved_variation_deg, magnetic_variation_deg,usagetype, power
FROM navaids
WHERE associated_airport = 'CYYZ') AS nav


--building airports json table
-- this took 9 minutes on my computer to run

CREATE TABLE airports_json AS (
SELECT JSONB_STRIP_NULLS (
	 jsonb_build_object(
	'id', air.id,
	'ident', air.ident,
	'name', air.name,
	'latitude_deg', air.latitude_deg,
	'elevation_ft', air.elevation_ft,
	'continent', air.continent,
	'iso_country', air.iso_country,
	'iso_region', air.iso_region,
	'airport_home_link', air.home_link,
	'airport_wikipedia_link', air.wikipedia_link,
	'municipality', air.municipality,
	'scheduled_service', air.scheduled_service,
	'gps_code', air.gps_code,
	'iata_code', air.iata_code,
	'airport_local_code', air.local_code,
	'airport_keywords', to_jsonb(string_to_array(air.keywords, ',')),
	'country_name', countries.name,
	'country_wikipedia_link', countries.wikipedia_link,
	'country_keywords', to_jsonb(string_to_array(countries.keywords, ',')),
	'region_name', regions.name,
	'region_wikipedia_link', regions.wikipedia_link,
	'regions_keywords', to_jsonb(string_to_array(regions.keywords, ',')),
	'runways', (SELECT JSONB_AGG(to_jsonb(runway_json)) FROM
		(SELECT le_ident, he_ident, length_ft, width_ft, surface,
		 	lighted AS is_lighted,closed AS is_closed,
			le_latitude_deg, le_longitude_deg,le_elevation_ft,le_displaced_threshold_ft,
			he_latitude_deg,he_longitude_deg,he_elevation_ft, he_heading_degt,he_displaced_threshold_ft
		FROM runways
		WHERE airport_ident = air.ident) as runway_json
		),
	'navaids', (SELECT JSONB_AGG(to_jsonb(nav)) FROM
				(SELECT name, filename, ident, type, frequency_khz,
					latitude_deg, longitude_deg, elevation_ft, dme_frequency_khz,
					dme_channel, dme_latitude_deg, dme_latitude_deg,dme_elevation_ft,
					slaved_variation_deg, magnetic_variation_deg,usagetype, power
				FROM navaids
				WHERE associated_airport = air.ident) AS nav
		),
	'frequencies', (SELECT JSONB_AGG(to_jsonb(nav)) FROM
				(SELECT type, description, frequency_mhz
				FROM airport_frequencies
				WHERE airport_ident = air.ident) AS nav
		)
)) AS airports

FROM airports AS air
INNER JOIN regions ON air.iso_region=regions.code
INNER JOIN countries ON air.iso_country = countries.code
);


--selecting information out od json feilds
SELECT airports->'runways'->0, airports->'country_name'
FROM airports_json;

SELECT airports->'runways'->>0, airports->>'country_name'
FROM airports_json;

SELECT '{"a": {"b": [3, 2, 1]}}'::jsonb #> '{a,b}';

SELECT '{"a": {"b": [3, 2, 1], "c": {"d": 5}}}'::jsonb #> '{a, c, d}';

SELECT airports->'frequencies'->1, airports->>'region_name'
FROM airports_json
ORDER BY  airports->'frequencies'->1 ASC;


--searching json data

SELECT * FROM airports_json
WHERE airports @> '{"iso_country": "BR"}';

SELECT COUNT(*) FROM airports_json
WHERE airports->>'iso_country' = 'BR';


SELECT COUNT(*) FROM airports_json
WHERE airports->>'iso_region' = 'US-AR';

SELECT COUNT(*) FROM airports_json
WHERE airports @> '{"iso_region": "US-AR"}';

SELECT COUNT(*) FROM airports_json
WHERE airports->'runways'-> 0 @> '{"length_ft": 2000}';

SELECT COUNT(*) FROM airports_json
WHERE airports->'navaids'-> 1 @> '{"frequency_khz": 400}';


--updating and deleting json feild

UPDATE airports_json
SET airports = airports || '{"nearby_lakes": ["Lake Chicot"]}'::jsonb
WHERE airports->>'iso_region' = 'US-AR'
		AND airports->>'municipality' = 'Lake Village';


SELECT airports->'nearby_lakes'
FROM airports_json
WHERE airports->>'iso_region' = 'US-AR'
		AND airports->>'municipality' = 'Lake Village';

UPDATE airports_json
SET airports = airports || '{"nearby_lakes": ["Lake Providence"]}'::jsonb
WHERE airports->>'iso_region' = 'US-AR'
		AND airports->>'municipality' = 'Lake Village';

SELECT airports->'nearby_lakes'
FROM airports_json
WHERE airports->>'iso_region' = 'US-AR'
		AND airports->>'municipality' = 'Lake Village';

UPDATE airports_json
SET airports = airports - 'nearby_lakes'
WHERE airports->>'iso_region' = 'US-AR'
		AND airports->>'municipality' = 'Lake Village';

SELECT airports->'nearby_lakes'
FROM airports_json
WHERE airports->>'iso_region' = 'US-AR'
		AND airports->>'municipality' = 'Lake Village';

--put it back in so we can delete with other syntax
UPDATE airports_json
SET airports = airports || '{"nearby_lakes": ["Lake Chicot","Lake Providence"]}'::jsonb
WHERE airports->>'iso_region' = 'US-AR'
		AND airports->>'municipality' = 'Lake Village';

SELECT airports->'nearby_lakes'
FROM airports_json
WHERE airports->>'iso_region' = 'US-AR'
		AND airports->>'municipality' = 'Lake Village';

UPDATE airports_json
SET airports = airports #- '{"nearby_lakes", 1}'
WHERE airports->>'iso_region' = 'US-AR'
		AND airports->>'municipality' = 'Lake Village';

SELECT airports->'nearby_lakes'
FROM airports_json
WHERE airports->>'iso_region' = 'US-AR'
		AND airports->>'municipality' = 'Lake Village';

UPDATE airports_json
SET airports = airports || '{"good_restaurants": ["La Terraza", "McDonalds"]}'
WHERE airports->>'id' = '20426';

SELECT airports->'good_restaurants'
FROM airports_json
WHERE airports->>'id' = '20426';

UPDATE airports_json
SET airports = airports #- '{"good_restaurants", 1}'
WHERE airports->>'id' = '20426';

SELECT airports->'good_restaurants'
FROM airports_json
WHERE airports->>'id' = '20426';
