--4.1

/* cannot delete Virginia from table because it refers to the other tables. 
FIPS/name are forgein keys on other tables. 
This is a 1 to M relationship
*/

--4.2
/* we cannot paste the line of code "insert into income(fips,income,year) values('80',6000,2025)"
because there is no state with fips 80
*/

--4.3
/* just fine */

--4.4
/* it works perfect */

--4.6
/* it works perfect */


