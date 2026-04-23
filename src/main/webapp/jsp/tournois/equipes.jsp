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
    List toutesEquipes = metier.getAllEquipes();
    request.setAttribute("tournoi", tournoi);
    request.setAttribute("toutesEquipes", toutesEquipes);
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
                    <c:out value="${tournoi.nom}"/> - Équipes
                </div>
            </div>
            <nav class="tabs">
<a href="${pageContext.request.contextPath}/jsp/tournois/detail.jsp?id=${tournoi.id}" class="tab">Accueil</a>

                <a href="equipes.jsp?id=${tournoi.id}" class="tab active">Équipes</a>
<a href="${pageContext.request.contextPath}/jsp/tournois/calendrier.jsp?id=${tournoi.id}" class="tab">Calendrier</a>

                <c:if test="${tournoi.championnat}">
<a href="${pageContext.request.contextPath}/jsp/tournois/classement.jsp?id=${tournoi.id}" class="tab">Classement</a>

                </c:if>
            </nav>
        </div>
    </div>

    <!-- LISTE EQUIPE -->
    <c:if test="${empty tournoi.equipes}">
        <p class="text-muted" style="margin-bottom:1.5rem;">Aucune équipe inscrite.</p>
    </c:if>

    <div class="card-grid" style="margin-bottom:2rem;">
        <c:forEach var="equipe" items="${tournoi.equipes}">
            <div class="card" style="display:flex;justify-content:space-between;align-items:center;">
                <div>
                    <div style="font-family:'Bebas Neue',cursive;font-size:1.3rem;">
                        <c:out value="${equipe.nom}"/>
                    </div>
                    <div class="text-muted-light" style="font-size:0.9rem;"><c:out value="${equipe.ville}"/></div>
                </div>
                <form action="${pageContext.request.contextPath}/tournois" method="post" style="margin:0;">
                    <input type="hidden" name="action" value="desinscrire"/>
                    <input type="hidden" name="idTournoi" value="${tournoi.id}"/>
                    <input type="hidden" name="idEquipe" value="${equipe.id}"/>
                    <button type="submit" class="btn btn-danger btn-sm"
                            onclick="return confirm('Retirer cette équipe ?')">X</button>
                </form>
            </div>
        </c:forEach>
    </div>

    <!-- FORM INSCRIRE -->
    <div class="form-card" style="max-width:100%;">
        <h3 style="font-family:'Bebas Neue',cursive;font-size:1.2rem;letter-spacing:2px;margin-bottom:1rem;">
            Inscrire une équipe
        </h3>
        <form action="${pageContext.request.contextPath}/tournois" method="post"
              style="display:flex;gap:1rem;flex-wrap:wrap;">
            <input type="hidden" name="action" value="inscrire"/>
            <input type="hidden" name="idTournoi" value="${tournoi.id}"/>
            <select name="idEquipe" class="form-control" style="flex:1;min-width:200px;" required>
                <option value="">-- Choisir une équipe --</option>
                <c:forEach var="equipe" items="${toutesEquipes}">
                    <option value="${equipe.id}">
                        <c:out value="${equipe.nom}"/> - <c:out value="${equipe.ville}"/>
                    </option>
                </c:forEach>
            </select>
            <button type="submit" class="btn btn-primary">+ Inscrire</button>
        </form>
    </div>

</div>

