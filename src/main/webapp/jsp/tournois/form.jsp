<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/jsp/header.jsp" %>

<div class="container">
    <div class="page-header">
        <h1 class="page-title">
            <c:choose>
                <c:when test="${not empty tournoi}">Modifier le <span>Tournoi</span></c:when>
                <c:otherwise>Nouveau <span>Tournoi</span></c:otherwise>
            </c:choose>
        </h1>
        <a href="${pageContext.request.contextPath}/tournois?action=list" class="btn btn-outline">&#8592; Retour</a>
    </div>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/tournois" method="post">
            <input type="hidden" name="action" value="save"/>
            <c:if test="${not empty tournoi}">
                <input type="hidden" name="id"     value="${tournoi.id}"/>
                <input type="hidden" name="statut" value="${tournoi.statut}"/>
            </c:if>

            <div class="form-group">
                <label class="form-label">Nom du tournoi *</label>
                <input type="text" name="nom" class="form-control"
                       value="<c:out value='${tournoi.nom}'/>"
                       placeholder="Ex: Coupe de Printemps 2025" required/>
            </div>

            <div class="form-group">
                <label class="form-label">Type de tournoi *</label>
                <select name="type" class="form-control" required>
                    <option value="">-- Choisir un type --</option>
                    <option value="CHAMPIONNAT"
                        <c:if test="${not empty tournoi && tournoi.championnat}">selected</c:if>>
                        &#127885; Championnat (aller-retour)
                    </option>
                    <option value="ELIMINATION_DIRECTE"
                        <c:if test="${not empty tournoi && tournoi.eliminationDirecte}">selected</c:if>>
                        &#129354; Elimination Directe
                    </option>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label">Date de debut</label>
                <input type="date" name="dateDebut" class="form-control"
                    <c:if test="${not empty tournoi && not empty tournoi.dateDebut}">
                        value="<fmt:formatDate xmlns:fmt='http://java.sun.com/jsp/jstl/fmt'
                               value='${tournoi.dateDebut}' pattern='yyyy-MM-dd'/>"
                    </c:if>
                />
            </div>

            <div class="form-group">
                <label class="form-label">Date de fin</label>
                <input type="date" name="dateFin" class="form-control"
                    <c:if test="${not empty tournoi && not empty tournoi.dateFin}">
                        value="<fmt:formatDate xmlns:fmt='http://java.sun.com/jsp/jstl/fmt'
                               value='${tournoi.dateFin}' pattern='yyyy-MM-dd'/>"
                    </c:if>
                />
            </div>

            <div class="page-header">
                <button type="submit" class="btn btn-primary">&#128190; Enregistrer</button>
                <a href="${pageContext.request.contextPath}/tournois?action=list" class="btn btn-outline">Annuler</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
