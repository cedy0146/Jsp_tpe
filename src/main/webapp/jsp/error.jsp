<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/jsp/header.jsp" %>

<div class="container">
    <div class="empty-state">
        <div class="icon">⚠️</div>
        <h1>Une erreur est survenue</h1>
        <div class="alert alert-danger" style="max-width:500px;margin:1rem auto;">
            ${error}
        </div>
        <a href="${pageContext.request.contextPath}/tournois" class="btn btn-primary" style="margin-top:1rem;">
            ← Retour à l'accueil
        </a>
    </div>
</div>
</body>
</html>
