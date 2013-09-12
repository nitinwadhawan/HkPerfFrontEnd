<%--
  Created by IntelliJ IDEA.
  User: Nitin Wadhawan
  Date: 8/12/13
  Time: 12:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="hkperf.DataAccessClass" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<body onload="JavaScript:timedRefresh(5000000);">
<title>First View</title>
<%@ page import="hkperf.LoadParam,
                     java.util.ArrayList,
                     java.util.List"
        %>
<style type="text/css">
    table{
        max-width: 500px;
    }
    table td {
        max-width: 250px;
    }
</style>
<script type='text/javascript' src='http://www.google.com/jsapi'></script>
<script type='text/javascript'>
    google.load('visualization', '1', {'packages': ['annotatedtimeline']});
    google.setOnLoadCallback(drawVisualization);

    function drawVisualization() {
        var data = new google.visualization.DataTable();

        <%
          String getHkAvgTimeByDate="select load_time as load_time, create_dt from page_load_performance.response_details a,page_load_performance.response b where a.request_id= b.request_id and a.response_view_type=3 and b.website_id=1";
          String getCount="select Count(*) from page_load_performance.response a ,page_load_performance.response_details b where a.request_id=b.request_id and a.website_id=1 and b.response_view_type=1;";
          LoadParam hk= new LoadParam();
          List<LoadParam> resultList_hk= new ArrayList<LoadParam>();
          DataAccessClass dataAccessClass=new DataAccessClass();
          resultList_hk=dataAccessClass.getResult(getHkAvgTimeByDate,hk);
          %>
        data.addColumn('datetime', 'Date Of Test');
        data.addColumn('number', 'Healthkart');
        <%
               System.out.println(DataAccessClass.count);

               for(int i=0;i<DataAccessClass.count;i++)
               {
                %>

        data.addRow([new Date(<%=resultList_hk.get(i).getDateTime()%>), <%=resultList_hk.get(i).getLoadTime()%>]);

        <%}%>


        var chart = new google.visualization.AnnotatedTimeLine(document.getElementById('chart_div'));
        chart.draw(data, {displayAnnotations: true});


    }
    function timedRefresh(timeoutPeriod) {
        setTimeout("location.reload(true);", timeoutPeriod);
        <% System.out.println("page got refreshed");%>
    }
</script>
​
Click <a href=" ./RepeatView.jsp">here </a> for Repeat View

<div id='chart_div' style='width: 500px; height: 500px;'></div>
</body>
</html>