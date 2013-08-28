<%--
  Created by IntelliJ IDEA.
  User: Nitin Wadhwan
  Date: 8/12/13
  Time: 12:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="hkperf.DataAccessClass"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>First View</title>
    <%@ page import="java.sql.Connection,
java.sql.DriverManager,
java.sql.ResultSet,
java.sql.SQLException,
java.sql.Statement,
hkperf.LoadParam,
hkperf.DataAccessClass,
java.sql.DriverManager,
java.sql.ResultSet,
java.sql.SQLException,
java.util.ArrayList,
java.util.LinkedList,
java.util.List
"
            %>
    <script type='text/javascript' src='http://www.google.com/jsapi'></script>
    <script type='text/javascript'>
        google.load('visualization', '1', {'packages':['annotatedtimeline']});
        google.setOnLoadCallback(drawVisualization);

        function drawVisualization() {
            var data = new google.visualization.DataTable();

            <%
              String getHkAvgTimeByDate="select Avg(load_time) as load_time, create_dt from page_load_performance.response_details a,page_load_performance.response b where a.request_id= b.request_id and a.response_view_type=4 and b.website_id=1 group by Date(create_dt)";
              String getSdAvgTimeByDate="select Avg(load_time) as load_time, create_dt from page_load_performance.response_details a,page_load_performance.response b where a.request_id= b.request_id and a.response_view_type=4 and b.website_id=2 group by Date(create_dt)";
              String getAzAvgTimeByDate="select Avg(load_time) as load_time, create_dt from page_load_performance.response_details a,page_load_performance.response b where a.request_id= b.request_id and a.response_view_type=4 and b.website_id=3 group by Date(create_dt)";
              //String getFkAvgTimeByDate="select load_time as load_time, create_dt from page_load_performance.response_details a,page_load_performance.response b where a.request_id= b.request_id and a.response_view_type=3 and b.website_id=4";

              String getCount="select Count(*) from page_load_performance.response a ,page_load_performance.response_details b where a.request_id=b.request_id and a.website_id=1 and b.response_view_type=1;";
              LoadParam hk= new LoadParam();
              LoadParam sd= new LoadParam();
              LoadParam az= new LoadParam();
             // LoadParam fk= new LoadParam();

              List<LoadParam> resultList_hk= new ArrayList<LoadParam>();
              List<LoadParam> resultList_sd= new ArrayList<LoadParam>();
              List<LoadParam> resultList_az= new ArrayList<LoadParam>();
             // List<LoadParam> resultList_fk= new ArrayList<LoadParam>();


              resultList_hk=DataAccessClass.getResult(getHkAvgTimeByDate,hk);
              resultList_sd=DataAccessClass.getResult(getSdAvgTimeByDate,sd);
              resultList_az=DataAccessClass.getResult(getAzAvgTimeByDate,az);
             // resultList_fk=DataAccessClass.getResult(getFkAvgTimeByDate,fk);

              %>


            data.addColumn('datetime', 'Date Of Test');
            data.addColumn('number', 'Healthkart');
            data.addColumn('number','Flipkart');
            data.addColumn('number', 'Amazon');



            <%
                   System.out.println(DataAccessClass.count);
                   for(int i=0;i<DataAccessClass.count;i++)
                   {
                    %>

            data.addRow([new Date(<%=resultList_hk.get(i).getDateTime()%>),<%=resultList_hk.get(i).getLoadTime()%>,<%=resultList_sd.get(i).getLoadTime()%>,<%=resultList_az.get(i).getLoadTime()%>]);

            <%}%>


            var chart = new google.visualization.AnnotatedTimeLine(document.getElementById('chart_div'));
            chart.draw(data, {displayAnnotations: true});

        }
        function timedRefresh(timeoutPeriod) {
            setTimeout("location.reload(true);",timeoutPeriod);
            <% System.out.println("page got refreshed");%>
        }
    </script>   ​
</head>
<body onload="JavaScript:timedRefresh(500000);">
<a href=" ./FirstView.jsp">First View </a>
<div id='chart_div' style='width: 1400px; height: 640px;'></div>
</body>
</html>