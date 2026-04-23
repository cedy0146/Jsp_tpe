<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TournoiSport</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sport.css">
</head>
<body>
<nav class="navbar">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/tournois">
        🏆 <span>Tournoi</span>SPORT
    </a>
    <ul class="navbar-nav">
        <li><a class="nav-link" href="${pageContext.request.contextPath}/tournois?action=list">Tournois</a></li>
        <li><a class="nav-link" href="${pageContext.request.contextPath}/equipes?action=list">Équipes</a></li>
    </ul>
</nav>
	