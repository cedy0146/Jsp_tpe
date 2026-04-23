<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/jsp/header.jsp" %>

<div class="container">

    <c:if test="${not empty param.msg}">
        <div class="alert alert-success">&#9989; Operation effectuee avec succes !</div>
    </c:if>

    <div class="page-header">
        <h1 class="page-title">Gestion des <span>Equipes</span></h1>
        <a href="${pageContext.request.contextPath}/equipes?action=create" class="btn btn-primary">
            + Nouvelle Equipe
        </a>
    </div>

    <c:choose>
        <c:when test="${empty equipes}">
            <div class="empty-state">
                <div class="icon">&#9917;</div>
                <p style="font-size:1.2rem;margin-top:1rem;">Aucune equipe enregistree.</p>
                <a href="${pageContext.request.contextPath}/equipes?action=create"
                   class="btn btn-primary" style="margin-top:1rem;">
                    Creer la premiere equipe
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div style="overflow-x:auto;border-radius:12px;overflow:hidden;border:1px solid rgba(255,255,255,0.06);">
                <table class="table-sport">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Nom de l'equipe</th>
                            <th>Ville</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="e" items="${equipes}" varStatus="st">
                            <tr>
                                <td class="text-muted">${st.count}</td>
                                <td>
                                    <span style="font-family:'Bebas Neue',cursive;font-size:1.2rem;letter-spacing:1px;">
                                        &#9917; <c:out value="${e.nom}"/>
                                    </span>
                                </td>
                                <td class="text-muted-light"><c:out value="${e.ville}"/></td>
                                <td>
                                    <div style="display:flex;gap:0.5rem;">
                                        <a href="${pageContext.request.contextPath}/equipes?action=edit&id=${e.id}"
                                           class="btn btn-outline btn-sm">Modifier</a>
                                        <a href="${pageContext.request.contextPath}/equipes?action=delete&id=${e.id}"
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Supprimer cette equipe ?')">Supprimer</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
