# Plan : Fixer les onglets dans detail.jsp - Changer liens # vers pages dédiées

## Contexte
Les onglets utilisent JS showTab qui fonctionne, mais utilisateur veut "modifier le lien". Passer à navigation pages séparées.

## Étapes à compléter :

### 1. [x] Modifier section tabs dans detail.jsp
 - Remplacer onclick par href="equipes.jsp?id=${tournoi.id}" etc.
 - Enlever href="#"

### 2. [ ] Supprimer contenus tabs dans detail.jsp
 - Retirer div id="tab-equipes", "tab-calendrier", "tab-classement"
 - Garder hero-section et boutons actions

### 3. [ ] Supprimer script showTab

### 4. [x] Vérifier subpages (equipes.jsp, calendrier.jsp, classement.jsp) gèrent ?id=${tournoi.id}


### 5. [ ] Test : Cliquer tabs → navigation vers pages avec données tournoi

**Statut : Prêt à implémenter étape par étape**

