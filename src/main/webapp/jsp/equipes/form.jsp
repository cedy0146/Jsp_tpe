<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/jsp/header.jsp" %>

<div class="conteneur-principal">
    <div class="page-header">
        <h1 class="page-title">
            <c:choose>
                <c:when test="${not empty equipe}">Modifier l'<span>Équipe</span></c:when>
                <c:otherwise>Nouvelle <span>Équipe</span></c:otherwise>
            </c:choose>
        </h1>

        <a href="${pageContext.request.contextPath}/equipes?action=list" class="btn btn-outline">
            ← Retour
        </a>
    </div>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/equipes" method="post" class="formulaire-tournoi">
            <c:if test="${not empty equipe}">
                <input type="hidden" name="id" value="${equipe.id}">
            </c:if>

            <div class="form-group">
                <label for="nom" class="form-label">Nom de l'équipe</label>
                <input type="text" id="nom" name="nom" class="form-control"
                       value="${equipe.nom}" placeholder="Ex: Lions FC" required>
            </div>

            <div class="form-group">
                <label for="ville" class="form-label">Ville</label>
                <input type="text" id="ville" name="ville" class="form-control"
                       value="${equipe.ville}" placeholder="Ex: Casablanca">
            </div>

            <div class="form-group">
                <label for="logoUrl" class="form-label">URL du Logo (optionnel)</label>
                <input type="text" id="logoUrl" name="logoUrl" class="form-control"
                       value="${equipe.logoUrl}" placeholder="https://...">
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">💾 Enregistrer</button>
                <a href="${pageContext.request.contextPath}/equipes?action=list" class="btn btn-outline">Annuler</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>