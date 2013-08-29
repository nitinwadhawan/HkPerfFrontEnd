<%--
  Created by IntelliJ IDEA.
  User: Nitin Wadhwan
  Date: 8/16/13
  Time: 5:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Interactive test</title>
    <%@ page import="hkperf.DataAccessClass,
                     hkperf.LoadParam,
                     java.util.ArrayList,
                     java.util.List"
            %>
    <script type='text/javascript' src='http://www.google.com/jsapi'></script>
    <script type='text/javascript'>
        google.load('visualization', '1', {'packages': ['annotatedtimeline']});
        google.setOnLoadCallback(drawVisualization);

        function drawVisualization() {
            var data = new google.visualization.DataTable();

            <%
              String getHkAvgTimeByDate="select load_time as load_time, create_dt from page_load_performance.response_details a,page_load_performance.response b where a.request_id= b.request_id and a.response_view_type=3 and b.website_id=1";
              String getSdAvgTimeByDate="select load_time as load_time, create_dt from page_load_performance.response_details a,page_load_performance.response b where a.request_id= b.request_id and a.response_view_type=3 and b.website_id=2";
              String getCount="select Count(*) from page_load_performance.response a ,page_load_performance.response_details b where a.request_id=b.request_id and a.website_id=1 and b.response_view_type=1;";
              LoadParam hk= new LoadParam();
              LoadParam sd= new LoadParam();
              List<LoadParam> resultList_hk= new ArrayList<LoadParam>();
              List<LoadParam> resultList_sd= new ArrayList<LoadParam>();


              resultList_hk=DataAccessClass.getResult(getHkAvgTimeByDate,hk);
              resultList_sd=DataAccessClass.getResult(getSdAvgTimeByDate,sd);


              %>


            data.addColumn('datetime', 'Date Of Test');
            data.addColumn('number', 'Healthkart');
            data.addColumn('number', 'SnapDeal');


            <%
                   System.out.println(DataAccessClass.count);
                   for(int i=0;i<DataAccessClass.count;i++)
                   {
                    %>

            data.addRow([new Date(<%=resultList_hk.get(i).getDateTime()%>), <%=resultList_hk.get(i).getLoadTime()%>, <%=resultList_sd.get(i).getLoadTime()%>]);

            <%}%>


            var chart = new google.visualization.AnnotatedTimeLine(document.getElementById('chart_div'));
            chart.draw(data, {displayAnnotations: true});

        }
    </script>
    ​
</head>
<body>
hello
<div id='chart_div' style='width: 1000px; height: 440px;'></div>
</body>
</html>