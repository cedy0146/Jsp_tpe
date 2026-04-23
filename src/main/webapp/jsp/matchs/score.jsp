<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/jsp/header.jsp" %>

<div class="container">
    <div class="page-header">
        <h1 class="page-title">Entrer le <span>Score</span></h1>
        <a href="${pageContext.request.contextPath}/tournois?action=view&id=${idTournoi}" class="btn btn-outline">← Retour</a>
    </div>

    <div class="form-card">
        <c:if test="${not empty match}">
            <!-- Affichage du match -->
            <div style="display:flex;align-items:center;justify-content:space-between;
                        margin-bottom:2rem;padding:1.5rem;
                        background:var(--gris-mid);border-radius:10px;">
                <div style="font-family:'Bebas Neue',cursive;font-size:1.8rem;text-align:center;flex:1;">
                    ${match.equipe1.nom}
                </div>
                <div class="match-vs">VS</div>
                <div style="font-family:'Bebas Neue',cursive;font-size:1.8rem;text-align:center;flex:1;">
                    ${match.equipe2.nom}
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/matchs" method="post">
                <input type="hidden" name="idMatch" value="${match.id}">
                <input type="hidden" name="idTournoi" value="${idTournoi}">

                <div style="display:grid;grid-template-columns:1fr auto 1fr;gap:1.5rem;align-items:end;margin-bottom:2rem;">
                    <div class="form-group" style="margin:0;">
                        <label class="form-label" style="text-align:center;display:block;">${match.equipe1.nom}</label>
                        <input type="number" name="score1" class="form-control"
                               style="text-align:center;font-size:2rem;font-family:'Bebas Neue',cursive;"
                               min="0" max="99" value="0" required>
                    </div>
                    <div class="match-dash">—</div>
                    <div class="form-group" style="margin:0;">
                        <label class="form-label" style="text-align:center;display:block;">${match.equipe2.nom}</label>
                        <input type="number" name="score2" class="form-control"
                               style="text-align:center;font-size:2rem;font-family:'Bebas Neue',cursive;"
                               min="0" max="99" value="0" required>
                    </div>
                </div>

                <div style="display:flex;gap:1rem;justify-content:center;">
                    <button type="submit" class="btn btn-primary">✅ Confirmer le Score</button>
                    <a href="${pageContext.request.contextPath}/tournois?action=view&id=${idTournoi}" class="btn btn-outline">Annuler</a>
                </div>
            </form>
        </c:if>

        <c:if test="${empty match}">
            <p class="text-muted">Match introuvable.</p>
        </c:if>
    </div>
</div>
</body>
</html>
