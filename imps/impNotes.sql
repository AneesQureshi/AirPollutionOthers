DELIMITER $$

USE `airpollutionH_db`$$

DROP PROCEDURE IF EXISTS `sp_stationData`$$

CREATE DEFINER=`admin`@`%` PROCEDURE `sp_stationData`(  
  IN val_stationId INT
  
  )
BEGIN

SELECT s.aqi,s.station,s.created_date  FROM tbl_station s WHERE s.id=val_stationId;

SELECT p.pollutant_name,p.pollutant_value,p.created_date,s.id AS stationId
FROM tbl_station s 
JOIN tbl_pollutant p
ON s.id	=p.station_id
WHERE s.`id`=val_stationId AND p.created_date>DATE_SUB(NOW(),INTERVAL 1 HOUR)
ORDER BY p.pollutant_value DESC;



SELECT MAX(tbl.aqi_value),tbl.created_date FROM (
SELECT a.id,a.aqi_value,a.station_id,a.active,DATE(created_date) AS created_date FROM tbl_aqi a WHERE a.station_id=4 
AND a.created_date> DATE_SUB(NOW(),INTERVAL 7 DAY) ORDER BY a.created_date ASC  ) tbl GROUP BY tbl.created_date;


    END$$
    
    
DELIMITER ;

CALL sp_stationData(4);

************************************************************

DELIMITER $$

USE `airpollutionH_db`$$

DROP PROCEDURE IF EXISTS `sp_pollutantHistory`$$

CREATE DEFINER=`admin`@`%` PROCEDURE `sp_pollutantHistory`(  
  IN val_stationId INT,
  IN val_pollutantName VARCHAR(45)
  
  )
BEGIN
SELECT MAX(tbl.pollutant_value),tbl.created_date FROM (
SELECT a.pollutant_value,DATE(created_date) 
AS created_date 
FROM tbl_pollutant a 
WHERE a.station_id=val_stationId 
AND pollutant_name=val_pollutantName
AND a.created_date> DATE_SUB(NOW(),INTERVAL 7 DAY) 
ORDER BY a.created_date ASC  ) tbl 
GROUP BY tbl.created_date;

    END$$

DELIMITER ;

CALL sp_pollutantHistory(4,'NO2')
*******************************************************


**********************************************

INSERT  INTO `tbl_pollutant`(`pollutant_name`,`pollutant_value`,`station_id`,`active`,`created_date`) 
VALUES ('NO2',102,4,'',DATE_SUB(NOW(),INTERVAL 0 DAY));
INSERT  INTO `tbl_pollutant`(`pollutant_name`,`pollutant_value`,`station_id`,`active`,`created_date`) 
VALUES ('NO2',103,4,'',DATE_SUB(NOW(),INTERVAL 1 DAY));

INSERT  INTO `tbl_pollutant`(`pollutant_name`,`pollutant_value`,`station_id`,`active`,`created_date`) 
VALUES ('NO2',104,4,'',DATE_SUB(NOW(),INTERVAL 2 DAY));
INSERT  INTO `tbl_pollutant`(`pollutant_name`,`pollutant_value`,`station_id`,`active`,`created_date`) 
VALUES ('NO2',105,4,'',DATE_SUB(NOW(),INTERVAL 3 DAY));
INSERT  INTO `tbl_pollutant`(`pollutant_name`,`pollutant_value`,`station_id`,`active`,`created_date`) 
VALUES ('NO2',106,4,'',DATE_SUB(NOW(),INTERVAL 4 DAY));
INSERT  INTO `tbl_pollutant`(`pollutant_name`,`pollutant_value`,`station_id`,`active`,`created_date`) 
VALUES ('NO2',107,4,'',DATE_SUB(NOW(),INTERVAL 5 DAY));
INSERT  INTO `tbl_pollutant`(`pollutant_name`,`pollutant_value`,`station_id`,`active`,`created_date`) 
VALUES ('NO2',108,4,'',DATE_SUB(NOW(),INTERVAL 6 DAY));
INSERT  INTO `tbl_pollutant`(`pollutant_name`,`pollutant_value`,`station_id`,`active`,`created_date`) 
VALUES ('NO2',109,4,'',DATE_SUB(NOW(),INTERVAL 7 DAY));


INSERT INTO tbl_aqi(aqi_value,station_id,active,created_date)
VALUES (345,4,'',DATE_SUB(NOW(),INTERVAL 0 DAY));
INSERT INTO tbl_aqi(aqi_value,station_id,active,created_date)
VALUES (485,4,'',DATE_SUB(NOW(),INTERVAL 1 DAY));
INSERT INTO tbl_aqi(aqi_value,station_id,active,created_date)
VALUES (535,4,'',DATE_SUB(NOW(),INTERVAL 2 DAY));
INSERT INTO tbl_aqi(aqi_value,station_id,active,created_date)
VALUES (654,4,'',DATE_SUB(NOW(),INTERVAL 3 DAY));
INSERT INTO tbl_aqi(aqi_value,station_id,active,created_date)
VALUES (439,4,'',DATE_SUB(NOW(),INTERVAL 4 DAY));
INSERT INTO tbl_aqi(aqi_value,station_id,active,created_date)
VALUES (645,4,'',DATE_SUB(NOW(),INTERVAL 5 DAY));
INSERT INTO tbl_aqi(aqi_value,station_id,active,created_date)
VALUES (455,4,'',DATE_SUB(NOW(),INTERVAL 6 DAY));
INSERT INTO tbl_aqi(aqi_value,station_id,active,created_date)
VALUES (695,4,'',DATE_SUB(NOW(),INTERVAL 7 DAY));


SELECT MAX(tbl.aqi_value),tbl.created_date FROM (
SELECT a.id,a.aqi_value,a.station_id,a.active,DATE(created_date) AS created_date FROM tbl_aqi a WHERE a.station_id=4 
AND a.created_date> DATE_SUB(NOW(),INTERVAL 7 DAY) ORDER BY a.created_date ASC  ) tbl GROUP BY tbl.created_date;


SELECT MAX(tbl.pollutant_value),tbl.created_date FROM (
SELECT a.pollutant_value,DATE(created_date) AS created_date FROM tbl_pollutant a WHERE a.station_id=4 AND pollutant_name='NO2'
AND a.created_date> DATE_SUB(NOW(),INTERVAL 7 DAY) ORDER BY a.created_date ASC  ) tbl GROUP BY tbl.created_date;

****************************

SELECT * FROM tbl_pollutant
SELECT * FROM tbl_pollutant GROUP BY station_id 
SELECT pollutant_name FROM tbl_pollutant WHERE station_id=60;
******************

DELIMITER $$

USE `airpollutionH_db`$$

DROP PROCEDURE IF EXISTS `sp_addPollutants`$$

CREATE DEFINER=`admin`@`%` PROCEDURE `sp_addPollutants`(IN val_PollutantName VARCHAR(45),
IN val_PollutantValue VARCHAR(45),IN val_lat VARCHAR(45),IN val_long VARCHAR(45))
BEGIN


SELECT @stationId := id FROM tbl_station WHERE latitude=val_lat AND longitude=val_long;

	
		
			INSERT INTO `tbl_pollutant`(
			`pollutant_name`,
			`pollutant_value`,
			`station_id`,
			`created_date`)
			VALUES
			(
			val_PollutantName,
			val_PollutantValue,
			@stationId,
			CURRENT_TIMESTAMP()
			);
		
	
	
	
    END$$

DELIMITER ;



***************************************
SELECT * FROM `airpollutionH_db`.`tbl_city`
WHERE city NOT IN (SELECT city FROM `airpollutionService_db`.tbl_city)

SELECT * FROM tbl_city WHERE city="kanpur"

`airpollutionService_db`
SELECT NOW()

SELECT * FROM tbl_station WHERE aqi="" OR aqi="-";

INSERT  INTO `tbl_aqi`(`id`,`aqi_value`,`station_id`,`active`,`created_date`) 
VALUES 
(1,'110',4,'','2018-04-26 11:03:00'),
(2,'110',4,'','2018-05-02 11:05:51'),
(3,'220',4,'','2018-05-01 11:05:51'),
(4,'330',4,'','2018-04-30 11:05:51'),
(5,'440',4,'','2018-04-29 11:05:51'),
(6,'550',4,'','2018-04-28 11:05:51'),
(7,'660',4,'','2018-04-27 11:05:51'),
(8,'770',4,'','2018-04-26 11:05:51'),
(9,'100',4,'','2018-05-03 11:07:22'),
(10,'110',4,'','2018-05-02 11:07:22'),
(11,'220',4,'','2018-05-01 11:07:22'),
(12,'330',4,'','2018-04-30 11:07:22'),
(13,'440',4,'','2018-04-29 11:07:22'),
(14,'550',4,'','2018-04-28 11:07:22'),
(15,'660',4,'','2018-04-27 11:07:22'),
(16,'770',4,'','2018-04-26 11:07:22'),
(17,'345',4,'','2018-05-03 11:31:15'),
(18,'485',4,'','2018-05-02 11:31:15'),
(19,'535',4,'','2018-05-01 11:31:15'),
(20,'654',4,'','2018-04-30 11:31:15'),
(21,'439',4,'','2018-04-29 11:31:15'),
(22,'645',4,'','2018-04-28 11:31:15'),
(23,'455',4,'','2018-04-27 11:31:15'),
(24,'695',4,'','2018-04-26 11:31:16');

SET FOREIGN_KEY_CHECKS=1

SELECT * FROM tbl_pollutant WHERE pollutant_name="Aqi" AND pollutant_value=-1
****************************************


SELECT * FROM tbl_pollutant WHERE station_id=30

DATE_SUB(NOW(),INTERVAL 5 DAY)

CALL sp_addPollutants('Aqi','143','13.672986','79.351217')
********************************

public SearchModel SearchList(string loc)
        {

            List<StationModel> stationNames = new List<StationModel>();
            
            List<LocationModel> cityNames = new List<LocationModel>();
            SearchModel objSearchList = new SearchModel();
           

            try
            {


                con = db.OpenConnection();
                cmd = new MySqlCommand("sp_locationStation", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("val_loc", loc);
                MySqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    StationModel station = new StationModel();
                    station.stationId = sdr["id"].ToString();
                    station.stationName = sdr["station"].ToString();
                    station.aqi = sdr["aqi"].ToString();
                    station.latitude = sdr["latitude"].ToString();
                    station.longitude = sdr["longitude"].ToString();
                    station.lastUpdatedDate = sdr["updated_date"].ToString();
                   
                    stationNames.Add(station);

                }

                sdr.Close();

             
                cmd = new MySqlCommand("sp_locationCity", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("val_loc", loc);
                MySqlDataReader sdr1 = cmd.ExecuteReader();

                while (sdr1.Read())
                {
                    LocationModel city = new LocationModel();
                    city.cityId = sdr1["id"].ToString();
                    city.city = sdr1["city"].ToString();
                    city.state = sdr1["state"].ToString();
                    city.country = sdr1["country"].ToString();

                    
                    cityNames.Add(city);
                 
                }

                sdr1.Close();


                objSearchList.stationList = stationNames;
                objSearchList.cityList = cityNames;
               
            }
            catch (Exception ex)
            {
                string message = ex.Message;
            }
            finally
            {
                db.CloseConnection();
            }
            return objSearchList;
        }
		
		
		
		