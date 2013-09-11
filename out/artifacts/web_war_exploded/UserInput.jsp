<%--
  Created by IntelliJ IDEA.
  User: Nitin Wadhwan
  Date: 8/12/13
  Time: 12:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
    String userInput = request.getParameter("graphType");
    if (userInput.equalsIgnoreCase("First_view")) {
     response.sendRedirect("index.jsp");
    }
    else if (userInput.equalsIgnoreCase("Repeat_view")){
        response.sendRedirect("RepeatView.jsp");
    }
    else
    response.sendRedirect("index.jsp");
%>
</body>
</html>