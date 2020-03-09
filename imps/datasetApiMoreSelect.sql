
*****************************************************************
last two api function to get station and polllutant
**********************************************************

 //we get the station id and give back the 
        //aqi value of that station, station name
        //pollutant name ,pollutant value
        //date, aqi max value
        public StationHomePageModel stationHomePage(string id)
        {
            int cityId = Int16.Parse(id);

            string[] pollutantNames =new string[] { "PM2.5","CO", "NO2", "OZONE", "NH3", "SO2", "PM10", "H" };

            StationModel sm = new StationModel();
            

            StationHomePageModel StationHomePage = new StationHomePageModel();

            try
            {
                string dd = "1";
                sm.aqi = "256";
                sm.stationName = "Muzaffarpur Collectorate, Muzaffarpur, India";
                sm.lastUpdatedDate = "2018-04-27 18:26:08";
                List<PollutantModel> pmList = new List<PollutantModel>();
                List<AqiHistoryModel> amList = new List<AqiHistoryModel>();
                for (int i = 0; i < 7; i++)
                {
                   
                    PollutantModel pm = new PollutantModel();
                    AqiHistoryModel am = new AqiHistoryModel();

                    pm.pollutantName = pollutantNames[i] ;
                    pm.pollutantValue = "25"+i;

                    am.aqiMaxValue = "36"+i;
                    am.Date = "2018-04-"+dd;

                    //date increment logic
                    int ddd = Int16.Parse(dd);
                    ddd = ddd + 1;
                    dd = Convert.ToString(ddd);

                    amList.Add(am);
                    pmList.Add(pm);
                }
                StationHomePage.AqiMaxValueList = amList;
                StationHomePage.PollutantValueList = pmList;

                StationHomePage.StationData = sm;
            }
            catch (Exception ex)
            {
                string message = ex.Message;
            }
            finally
            {
                db.CloseConnection();
            }
            return StationHomePage;
        }



        //we get the station id and pollutant name  then give back the 
        //max polllutant value upto 7 days for that station id each day
        public List<PollutantModel> PollutantHistory(string stationId, string pollutantName)
        {
            

            string[] pollutantValue = new string[] { "205", "256", "456", "365", "458", "65", "12", "45" };
            string[] lastUpdatedDate = new string[] { "2018-04-01", "2018-04-02", "2018-04-03", "2018-04-04", "2018-04-05", "2018-04-06", "2018-04-07" };




            List<PollutantModel> pollutantHistoryList = new List<PollutantModel>();

            try
            {
                          
               
                for (int i = 0; i < 7; i++)
                {

                    PollutantModel pm = new PollutantModel();
                  
                    pm.pollutantValue = pollutantValue[i];
                    pm.lastUpdatedDate = lastUpdatedDate[i];



                    pollutantHistoryList.Add(pm);
                }
               
            }
            catch (Exception ex)
            {
                string message = ex.Message;
            }
            finally
            {
                db.CloseConnection();
            }
            return pollutantHistoryList;
        }
		*****************************************************************