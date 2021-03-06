<%@ page import="oo.Film" %>
<%@ page import="factory.FilmFactory" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="elements/head.jsp"/>
<body class="d-flex flex-column h-100">
<jsp:include page="elements/header.jsp"/>
<jsp:include page="locationPicker.jsp"/>
<jsp:include page="login.jsp"/>
<jsp:include page="registration.jsp"/>
<jsp:include page="search.jsp"/>

<%
    SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
    Date date = new Date();

    SimpleDateFormat st = new SimpleDateFormat("HH:mm");
    Date time = new Date();

    String plz = "00000";
    Cookie[] cookies = request.getCookies();
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("plz")) {
            plz = cookie.getValue();
        }
    }

    Film filme[] = FilmFactory.getFilme(plz);

    if (filme != null) {
%>
<div class="container">
    <%
        if (filme[0] != null) {
            for (Film f : filme) {
                String hrefURL = "singleMovie.jsp?";
                hrefURL += "id=" + f.getFilmID();
                hrefURL += "&date=" + sd.format(date);
                ;
                hrefURL += "&time=" + st.format(time);
                ;
    %>

    <div class="card mt-3 mb-3">
        <div class="row">
            <div class="col-lg-5">
                <img src="<%= f.getBildLink()%>" class="card-img" alt="<%= f.getTitel()%>">
            </div>
            <div class="col-lg-7">
                <div class="card-body">
                    <h5 class="card-title"><%=f.getTitel()%>
                    </h5>
                    <p class="card-text"><small class="text-muted"><%=f.getDauer()%> min | FSK <%=f.getFsk()%> | <%=f.getGenreString()%> | <%=f.getSpracheString()%>
                    </small></p>
                    <p class="card-text mrb-justify"><%=f.getBeschreibung()%>
                    </p>
                    </p>
                    <a href="<%=hrefURL%>" class="btn btn-primary">Zum Film</a>
                </div>
            </div>
        </div>
    </div>
    <%
                }
            } else {
                    out.write("<div class=\"card mt-3 mb-3\">");
                    out.write("<div class=\"card-body text-center\">");
                    out.write("<h5 class=\"card-title\">Für dein ausgewähltes Kino gibt es keine Vorstellungen ..</h5>");
                    out.write("<p class=\"card-text\"><small class=\"text-muted\">Gerne kannst Du ein anderes Kino von uns besuchen.</small></p>");
                    out.write("</div>");
                    out.write("</div>");
                }
        }
    %>
</div>

<jsp:include page="elements/footer.jsp"/>
</body>
</html>