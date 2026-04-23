<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/jsp/header.jsp" %>

<div class="container">

    <!-- Message de succès -->
    <c:if test="${not empty param.msg}">
        <div class="alert alert-success">
            ✅ Opération effectuée avec succès !
        </div>
    </c:if>

    <!-- Section Hero -->
    <div class="hero-section">
        <h1 class="hero-title">🏆 Gestion des <span>Tournois</span></h1>
        <p class="text-muted-light">
            Créez et gérez vos tournois.<br>
            Génération automatique du calendrier incluse.
        </p>
        <div class="stats-grid">
            <div class="stat-box">
                <div class="stat-value">${tournois.size()}</div>
                <div class="stat-label">Tournois</div>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/tournois?action=create" class="btn btn-primary btn-lg" style="margin-top:1rem;">
            + Nouveau Tournoi
        </a>
    </div>

    <!-- En-tête de page -->
    <div class="page-header">
        <h2 class="page-title">Tous les <span>Tournois</span></h2>
    </div>

    <!-- Liste des tournois -->
    <c:choose>
        <c:when test="${empty tournois}">
            <div class="empty-state">
                <div class="icon">🎯</div>
                <h3>Aucun tournoi pour l'instant</h3>
                <p>Lancez-vous et créez votre premier tournoi en quelques secondes.</p>
                <a href="${pageContext.request.contextPath}/tournois?action=create"
                   class="btn btn-success btn-lg" style="margin-top:1rem;">
                    🚀 Créer le premier tournoi
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card-grid">
                <c:forEach var="t" items="${tournois}">
                    <div class="card">
                        <div class="card-header">
                            <span class="card-title"><c:out value="${t.nom}"/></span>
                            <c:choose>
                                <c:when test="${t.enAttente}">
                                    <span class="badge badge-yellow">⏳ En attente</span>
                                </c:when>
                                <c:when test="${t.enCours}">
                                    <span class="badge badge-green">🔥 En cours</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-blue">✔ Terminé</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="card-meta">
                            <c:choose>
                                <c:when test="${t.eliminationDirecte}">
                                    🥊 Élimination Directe
                                </c:when>
                                <c:otherwise>
                                    ⚽ Championnat
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${not empty t.dateDebut}">
                                &nbsp;·&nbsp;
                                <fmt:formatDate value="${t.dateDebut}" pattern="dd/MM/yyyy"/>
                            </c:if>
                        </div>
                        <div class="card-actions">
                            <a href="${pageContext.request.contextPath}/tournois?action=view&id=${t.id}"
                               class="btn btn-outline btn-sm">👁 Voir</a>
                            <a href="${pageContext.request.contextPath}/tournois?action=edit&id=${t.id}"
                               class="btn btn-sm btn-edit">✏ Modifier</a>
                            <a href="${pageContext.request.contextPath}/tournois?action=delete&id=${t.id}"
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Supprimer ce tournoi ?')">🗑 Supprimer</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
