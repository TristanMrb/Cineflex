<%@ page import="java.io.PrintWriter" %>
<%@ page import="oo.Film" %>
<%@ page import="oo.Vorstellung" %>
<%@ page import="factory.FilmFactory" %>
<%@ page import="factory.VorstellungsFactory" %>
<%@ page import="helper.DateFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");
            String date = request.getParameter("date");
                    String time = request.getParameter("time");
                            // Get PLZ
                            String plz = "00000";
    Cookie[] cookies = request.getCookies();
    for (Cookie c : cookies) {
        if (c.getName().equals("plz")) {
            plz = c.getValue();
        }
    }

    Film film = null;
    Vorstellung vorstellung[] = null;
    film = FilmFactory.getFilm(Integer.parseInt(id));
    try {
        vorstellung = VorstellungsFactory.getVorstellungen(film, date, time, plz);

    } catch (Exception e) {
        out.write(plz);
        out.write("Geht nicht!");
    }
    if (vorstellung[0] == null) {
        out.write(date + time + plz + " " + Integer.parseInt(id));
        return;
    }
    film = vorstellung[0].getFilm();

%>

<html>
<jsp:include page="elements/head.jsp"/>
<body class="d-flex flex-column h-100">
<jsp:include page="elements/header.jsp"/>
<jsp:include page="login.jsp"/>
<jsp:include page="registration.jsp"/>
<jsp:include page="filter.jsp"/>
<%
    try {
%>
<div class="container">
    <div class="col-xl-12">
        <div class="card mt-3 mb-3 text-white w-100">
            <%
                if (!vorstellung[0].equals(null)) {
            %>
            <div class="row no-gutters">
                <div class="col-lg-5">
                    <a href="#"><img src="<%=film.getBildLink()%>" class="card-img" alt="<%=film.getTitel()%>"></a>
                    <div class="table-responsive mt-2">
                        <table class="table text-center">
                            <tbody>
                            <%
                                int counter = 1;
                                for (int i = 0; i < vorstellung.length; i++) {
                                    String hrefURL = "seats.jsp?";
                                    hrefURL += "id=" + vorstellung[i].getVorstellungsID();
                                    switch (counter) {
                                        case 1:
                                            counter++;
                            %>
                            <tr>
                                <td>
                                    <a href="<%=hrefURL%>">
                                    <button class="film-btn" onclick="">
                                        <%=DateFormatter.getFrontendDate(vorstellung[i].getDatum())%><br>
                                        <%=DateFormatter.getFrontendTime(vorstellung[i].getUhrzeit())%> Uhr
                                    </button>
                                    </a>
                                </td>

                                <%
                                        break;
                                    case 2:
                                        counter++;
                                %>

                                <td>
                                    <a href="<%=hrefURL%>">
                                    <button class="film-btn" onclick="">
                                        <%=DateFormatter.getFrontendDate(vorstellung[i].getDatum())%><br>
                                        <%=DateFormatter.getFrontendTime(vorstellung[i].getUhrzeit())%> Uhr
                                    </button>
                                    </a>
                                </td>

                                <%
                                        break;
                                    case 3:
                                        counter = 1;
                                %>
                                <td>
                                    <a href="<%=hrefURL%>">
                                    <button class="film-btn" onclick="">
                                        <%=DateFormatter.getFrontendDate(vorstellung[i].getDatum())%><br>
                                        <%=DateFormatter.getFrontendTime(vorstellung[i].getUhrzeit())%> Uhr
                                    </button>
                                    </a>
                                </td>
                            </tr>
                            <%
                                            break;
                                    }
                                }

                                if (counter == 1) {
                            %>

                            <tr>
                                <td></td>
                                <td></td>
                                <td>
                                    <button class="film-btn" onclick="">mehr</button>
                                </td>
                            </tr>
                            <%
                            } else if (counter == 2) {
                            %>
                            <td></td>
                            <td>
                                <button class="film-btn" onclick="">mehr</button>
                            </td>
                            </tr>
                            <%
                            } else if (counter == 3) {
                            %>
                            <td>
                                <button class="film-btn" onclick="">mehr</button>
                            </td>
                            </tr>
                            <%
                                }
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="card-body">
                        <h5 class="card-title"><%=film.getTitel()%></h5>
                        <p class="card-text"><small class="text-muted"><%=film.getDauer()%> Minuten | FSK <%=
                        film.getFsk()%> | Sprache <%=vorstellung[0].getSprache()%>
                        </small></p>
                        <p class="card-text mrb-justify"><%=film.getBeschreibung()%>
                        </p>
                        <iframe width="560" height="315" src="<%=film.getTrailerLink()%>
                        " frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope;
                        picture-in-picture" allowfullscreen></iframe>
                    </div>
                </div>
            </div>
            <%
            } else {
            %>
            <p class="card-text">Vergewissere dich, dass du ein Kino selektiert hast! ANdernfalls ändere bitte deine
                Werte bei deiner Suche!</p>
            <%
                }
            %>
        </div>
    </div>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<jsp:include page="elements/footer.jsp"/>
</body>
</html>