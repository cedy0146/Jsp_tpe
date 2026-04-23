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
    List matchs = metier.getMatchsByTournoi(id);
    request.setAttribute("tournoi", tournoi);
    request.setAttribute("matchs", matchs);
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
                    <c:out value="${tournoi.nom}"/> - Calendrier
                </div>
            </div>
            <nav class="tabs">
<a href="${pageContext.request.contextPath}/jsp/tournois/detail.jsp?id=${tournoi.id}" class="tab">Accueil</a>

                <a href="equipes.jsp?id=${tournoi.id}" class="tab">Équipes</a>
                <a href="calendrier.jsp?id=${tournoi.id}" class="tab active">Calendrier</a>
                <c:if test="${tournoi.championnat}">
                    <a href="classement.jsp?id=${tournoi.id}" class="tab">Classement</a>
                </c:if>
            </nav>
        </div>
    </div>

    <!-- CONTENT -->
    <c:if test="${empty matchs}">
        <p class="text-muted">Aucun match généré. <a href="${pageContext.request.contextPath}/tournois?action=generer&id=${tournoi.id}">Générer le calendrier</a></p>
    </c:if>
    <div class="table-responsive">
        <table class="table-sport table-striped">
            <thead>
                <tr>
                    <th>Journée</th>
                    <th>Date</th>
                    <th>Match</th>
                    <th>Résultat</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="match" items="${matchs}">
                    <tr>
                        <td><strong>J${match.journee}</strong></td>
                        <td><fmt:formatDate value="${match.dateMatch}" pattern="dd/MM"/></td>
                        <td>
                            <div class="match-vs">
                                <span class="badge badge-primary">${match.equipe1.nom}</span> VS <span class="badge badge-primary">${match.equipe2.nom}</span>
                            </div>
                        </td>
                        <td>${match.resultat}</td>
                        <td>
                            <c:if test="${not match.joue}">
                                <a href="${pageContext.request.contextPath}/matchs?action=score&id=${match.id}&idTournoi=${tournoi.id}" class="btn btn-sm btn-primary">Saisir Score</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</div>

