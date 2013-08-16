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
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
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
    <script type="text/javascript">
        google.load("visualization", "1", {packages:["corechart"]});
        google.setOnLoadCallback(drawChart);
        function drawChart() {
            <%
            String getHkAvgTimeByDate="select AVG(load_time) as load_time, create_dt from page_load_performance.response_details a,page_load_performance.response b where a.request_id= b.request_id and a.response_view_type=4 and b.website_id=1 group by DATE(create_dt)";
            String getSdAvgTimeByDate="select AVG(load_time) as load_time, create_dt from page_load_performance.response_details a,page_load_performance.response b where a.request_id= b.request_id and a.response_view_type=4 and b.website_id=2 group by DATE(create_dt)";
            LoadParam hk= new LoadParam();
            LoadParam sd= new LoadParam();
            List<LoadParam> resultList_hk= new ArrayList<LoadParam>();
            List<LoadParam> resultList_sd= new ArrayList<LoadParam>();


            resultList_hk=DataAccessClass.getResult(getHkAvgTimeByDate,hk);
            resultList_sd=DataAccessClass.getResult(getSdAvgTimeByDate,sd);

            %>
            var data = new google.visualization.DataTable();
            data.addColumn('date', 'Date Of Test(Medium)');
            data.addColumn('number', 'Healthkart');
            data.addColumn('number','SnapDeal');

            //TODO select minimum of the count or modify query according to this.

            var dataView = new google.visualization.DataView(data);
            //dataView.setColumns([{calc: function(data, row) { return data.getFormattedValue(row, 0); }, type:'string'}, 1]);
            <%
            System.out.println(DataAccessClass.count);
            for(int i=0;i<=3;i++)
            {
             %>

            data.addRow([new Date(<%=resultList_hk.get(i).getDateTime().substring(0,10)%>),<%=resultList_hk.get(i).getLoadTime()%>,<%=resultList_sd.get(i).getLoadTime()%>]);

            <%}%>
            var options = {title: 'Page Performance Results'};
            var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
            chart.draw(dataView, options);
            vAxis: {title: "Time(ms)"};
            hAxis: {title: "Date/Time"};
            seriesType: "bars";
            chart.draw(dataView, options);
        }
    </script>
</head>
<body>
<div id="chart_div" style="width: 700px; height: 400px;">TNT</div>
</body>

</html>