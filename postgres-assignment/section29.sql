CREATE TABLE airports (
	id int NOT NULL,
	ident varchar(10),
	type text,
	name text,
	latitude_deg float,
	longitude_deg float,
	elevation_ft int,
	continent text,
	iso_country varchar(10),
	iso_region varchar(10),
	municipality text,
	scheduled_service text,
	gps_code varchar(10),
	iata_code varchar(20),
	local_code varchar(20),
	home_link text,
	wikipedia_link text,
	keywords text
);
-- this won't work in pgAdmin
COPY airports (	id,ident,type,name,latitude_deg,longitude_deg,elevation_ft,
						continent,iso_country,iso_region,municipality,scheduled_service,
						gps_code,iata_code,local_code,home_link,wikipedia_link,keywords)
FROM 'Downloads/airports.csv' DELIMITER ',' CSV HEADER;

SELECT COUNT (*) FROM airports;
select * from airports

CREATE TABLE airport_frequencies (
	id int,
	airport_ref int,
	airport_ident varchar(10),
	type varchar(20),
	description text,
	frequency_mhz float
)

SELECT COUNT (*) FROM airport_frequencies;

CREATE TABLE navaids (
	id int,
	filename text,
	ident varchar(10),
	name text,
	type varchar(10),
	frequency_khz float,
	latitude_deg float,
	longitude_deg float,
	elevation_ft int,
	iso_country varchar(10),
	dme_frequency_khz float,
	dme_channel varchar(10),
	dme_latitude_deg float,
	dme_longitude_deg float,
	dme_elevation_ft int,
	slaved_variation_deg float,
	magnetic_variation_deg float,
	usageType char(10),
	power char(10),
	associated_airport varchar(10)
)
\copy navaids (		id,filename, ident, name, type, frequency_khz, latitude_deg, longitude_deg, elevation_ft, iso_country, dme_frequency_khz, dme_channel, dme_latitude_deg, dme_longitude_deg, dme_elevation_ft, slaved_variation_deg,magnetic_variation_deg, usageType, power, associated_airport) FROM '/D:/trainingnov21/week07/navaids.csv' DELIMITER ',' CSV HEADER;

SELECT COUNT (*) FROM navaids ;

CREATE TABLE regions (
	id int,
	code varchar(10),
	local_code varchar(10),
	name text,
	continent char(2),
	iso_country varchar(10),
	wikipedia_link text,
	keywords text
)
\copy regions (		id,code, local_code, name, continent, iso_country, wikipedia_link, keywords) FROM 'D:/trainingnov21/week07/regions.csv' DELIMITER ',' CSV HEADER;

SELECT COUNT (*) FROM regions ;

CREATE TABLE countries (
	id int,
	code varchar(10),
	name text,
	continent char(2),
	wikipedia_link text,
	keywords text
)
\copy countries ( id,code, name, continent, wikipedia_link, keywords) FROM 'D:/trainingnov21/week07/countries.csv' DELIMITER ',' CSV HEADER;
SELECT COUNT (*) FROM countries ;

CREATE TABLE runways (
	id int,
	airport_ref int,
	airport_ident varchar(10),
	length_ft int,
	width_ft int,
	surface text,
	lighted boolean,
	closed boolean,
	le_ident varchar(10),
	le_latitude_deg float,
	le_longitude_deg float,
	le_elevation_ft int,
	le_heading_degT float,
	le_displaced_threshold_ft int,
	he_ident varchar(10),
	he_latitude_deg float,
	he_longitude_deg float,
	he_elevation_ft int,
	he_heading_degT float,
	he_displaced_threshold_ft int
)

\copy runways ( id,airport_ref, airport_ident, length_ft, width_ft, surface, lighted, closed ,le_ident, le_latitude_deg, le_longitude_deg, le_elevation_ft, le_heading_degT, le_displaced_threshold_ft, he_ident, he_latitude_deg, he_longitude_deg, he_elevation_ft, he_heading_degT, he_displaced_threshold_ft)  FROM 'D:/trainingnov21/week07/runways.csv' DELIMITER ',' CSV HEADER;
SELECT COUNT (*) FROM runways ;






















