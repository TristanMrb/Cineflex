<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="db_connector.Connector" %>
<%@ page import="db_connector.QueryBuilder" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="elements/head.jsp"/>
<body>
<jsp:include page="elements/header.jsp"/>

<jsp:include page="login.jsp"/>
<jsp:include page="registration.jsp"/>
<jsp:include page="filter.jsp"/>

<div class="jumbotron jumbotron-fluid footer">
    <div class="container">
        <h1 class="display-4">Hier finden Sie uns:</h1>
        <%
            try{

                Cookie cookie = null;
                Cookie[] cookies = null;
                String outputValue = "Standort";

                cookies = request.getCookies();

                if (cookies != null) {
                    for (int i = 0; i < cookies.length; i++) {
                        if (cookies[i].getName().equals("city")) {
                            cookie = cookies[i];
                            outputValue = cookie.getValue();
                            break;
                        }
                    }
                }

            }catch(Exception e){
                out.write("<iframe src=\"https://www.google.com/maps/d/embed?mid=1iFLu1_eFR5Kvh6D5A1hARlFCm13TXPUb&hl=de\" width=\"1000\" height=\"1000\"></iframe>");
            }finally {

            }

        %>

    </div>
</div>

<jsp:include page="elements/footer.jsp"/>
</body>
</html>
