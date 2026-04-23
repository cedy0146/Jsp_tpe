<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="metier.TournoiMetier,model.Tournoi,java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>

<%
String idStr = request.getParameter("id");
if (idStr != null && !idStr.isEmpty()) {
    TournoiMetier metier = new TournoiMetier();
    int id = Integer.parseInt(idStr);
    Tournoi tournoi = metier.getTournoiById(id);
    List classement = metier.getClassement(id);
    request.setAttribute("tournoi", tournoi);
    request.setAttribute("classement", classement);
}
%>

<div class="container">

    <c:if test="${not empty param.msg}">
        <div class="alert alert-success">Operation effectuée !</div>
    </c:if>

    <!-- TITLE / NAV -->
    <div class="hero-section" style="margin-bottom:2rem;">
        <div style="display:flex;justify-content:space-between;align-items:flex-start;">
            <div>
                <div style="font-family:'Bebas Neue',cursive;font-size:2.5rem;letter-spacing:3px;">
                    <c:out value="${tournoi.nom}"/> - Classement
                </div>
            </div>
            <nav class="tabs">
                <a href="detail.jsp?id=${tournoi.id}" class="tab">Accueil</a>
                <a href="equipes.jsp?id=${tournoi.id}" class="tab">Équipes</a>
                <a href="calendrier.jsp?id=${tournoi.id}" class="tab">Calendrier</a>
                <a href="classement.jsp?id=${tournoi.id}" class="tab active">Classement</a>
            </nav>
        </div>
    </div>

    <!-- CONTENT -->
    <c:if test="${empty classement}">
        <p class="text-muted">Classement après premiers matchs.</p>
    </c:if>
    <div class="table-responsive">
        <table class="table table-sport table-striped">
            <thead>
                <tr>
                    <th>Rank</th>
                    <th>Équipe</th>
                    <th>PJ</th>
                    <th>V</th>
                    <th>N</th>
                    <th>D</th>
                    <th>BP</th>
                    <th>BC</th>
                    <th>Diff</th>
                    <th>Pts</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${classement}" varStatus="status">
                    <tr>
<td class="rank-${status.count}"><strong>${status.count}</strong></td>
                        <td>${c.equipe.nom}</td>
                        <td>${c.matchsJoues}</td>
                        <td>${c.victoires}</td>
                        <td>${c.nuls}</td>
                        <td>${c.defaites}</td>
                        <td>${c.butsPour}</td>
                        <td>${c.butsContre}</td>
                        <td>${c.differenceButs}</td>
                        <td><strong>${c.points}</strong></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</div>

