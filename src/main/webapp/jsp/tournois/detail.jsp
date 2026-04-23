<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/jsp/header.jsp" %>

<div class="container">

    <c:if test="${not empty param.msg}">
        <div class="alert alert-success">Operation effectuee !</div>
    </c:if>

    <!-- EN-TETE -->
    <div class="hero-section" style="margin-bottom:2rem;">
        <div style="display:flex;justify-content:space-between;align-items:flex-start;flex-wrap:wrap;gap:1rem;">
            <div>
                <div style="font-family:'Bebas Neue',cursive;font-size:2.5rem;letter-spacing:3px;">
                    <c:out value="${tournoi.nom}"/>
                </div>
                <div style="margin-top:0.5rem;display:flex;gap:0.75rem;flex-wrap:wrap;align-items:center;">
                    <c:choose>
                        <c:when test="${tournoi.eliminationDirecte}">
                            <span class="badge badge-yellow">Elim. Directe</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-blue">Championnat</span>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${tournoi.enAttente}">
                            <span class="badge badge-yellow">En attente</span>
                        </c:when>
                        <c:when test="${tournoi.enCours}">
                            <span class="badge badge-green">En cours</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-blue">Termine</span>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${not empty tournoi.dateDebut}">
                        <span class="text-muted-light">
                            <fmt:formatDate value="${tournoi.dateDebut}" pattern="dd/MM/yyyy"/>
                        </span>
                    </c:if>
                </div>
            </div>
            <div style="display:flex;gap:0.75rem;flex-wrap:wrap;">
                <a href="${pageContext.request.contextPath}/tournois?action=generer&id=${tournoi.id}"
                   class="btn btn-warning"
                   onclick="return confirm('Generer le calendrier ? Les matchs existants seront supprimes.')">
                    Generer Calendrier
                </a>
                <a href="${pageContext.request.contextPath}/tournois?action=edit&id=${tournoi.id}"
                   class="btn btn-outline">Modifier</a>
                <a href="${pageContext.request.contextPath}/tournois?action=list"
                   class="btn btn-outline">Retour</a>
            </div>
        </div>

        <div class="stats-grid" style="margin-top:1.5rem;">
            <div class="stat-box">
                <div class="stat-value">${tournoi.equipes.size()}</div>
                <div class="stat-label">Equipes</div>
            </div>
            <div class="stat-box">
                <div class="stat-value">${matchs.size()}</div>
                <div class="stat-label">Matchs</div>
            </div>
            <div class="stat-box">
                <c:set var="joues" value="0"/>
                <c:forEach var="match" items="${matchs}">
                    <c:if test="${match.joue}">
                        <c:set var="joues" value="${joues + 1}"/>
                    </c:if>
                </c:forEach>
                <div class="stat-value">${joues}</div>
                <div class="stat-label">Joues</div>
            </div>
        </div>
    </div>

    <!-- ONGLETS -->
    <div class="tabs">
<a href="${pageContext.request.contextPath}/jsp/tournois/equipes.jsp?id=${tournoi.id}" class="tab active">Equipes</a>


<a href="${pageContext.request.contextPath}/jsp/tournois/calendrier.jsp?id=${tournoi.id}" class="tab">Calendrier</a>


        <c:if test="${tournoi.championnat}">
<a href="${pageContext.request.contextPath}/jsp/tournois/classement.jsp?id=${tournoi.id}" class="tab">Classement</a>

        </c:if>
    </div>

    <!-- TAB EQUIPES -->
    <div id="tab-equipes">
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

    <!-- TAB CALENDRIER -->
    <div id="tab-calendrier" style="display:none;">
        <c:if test="${empty matchs}">
            <p class="text-muted">Aucun match généré. <a href="${pageContext.request.contextPath}/tournois?action=generer&id=${tournoi.id}">Générer le calendrier</a></p>
        </c:if>
        <div class="table-responsive">
            <table class="table table-striped">
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
                                <div style="display:flex;align-items:center;gap:0.5rem;">
                                    <strong>${match.equipe1.nom}</strong> vs <strong>${match.equipe2.nom}</strong>
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

    <!-- TAB CLASSEMENT (CHAMPIONNAT seulement) -->
    <div id="tab-classement" style="display:none;">
        <c:if test="${empty classement}">
            <p class="text-muted">Classement après premiers matchs.</p>
        </c:if>
        <div class="table-responsive">
            <table class="table table-striped">
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
                            <td><strong>${status.count}</strong></td>
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

    <script>
        function showTab(tabId, tabBtn) {
            // Hide all tabs
            document.querySelectorAll('[id^=tab-]').forEach(tab => tab.style.display = 'none');
            document.querySelectorAll('.tab').forEach(btn => btn.classList.remove('active'));
            // Show selected
            document.getElementById(tabId).style.display = 'block';
            tabBtn.classList.add('active');
            return false;
        }
    </script>
