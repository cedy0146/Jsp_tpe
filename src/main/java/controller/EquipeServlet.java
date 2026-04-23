package controller;

import metier.TournoiMetier;
import model.Equipe;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/equipes")
public class EquipeServlet extends HttpServlet {

    private TournoiMetier metier = new TournoiMetier();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "list":
                    req.setAttribute("equipes", metier.getAllEquipes());
                    req.getRequestDispatcher("/jsp/equipes/list.jsp").forward(req, resp);
                    break;

                case "create":
                    req.getRequestDispatcher("/jsp/equipes/form.jsp").forward(req, resp);
                    break;

                case "edit":
                    int id = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("equipe", metier.getAllEquipes().stream()
                            .filter(e -> e.getId() == id).findFirst().orElse(null));
                    req.getRequestDispatcher("/jsp/equipes/form.jsp").forward(req, resp);
                    break;

                case "delete":
                    metier.supprimerEquipe(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/equipes?action=list&msg=supprime");
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/jsp/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        try {
            Equipe e = new Equipe();
            String idStr = req.getParameter("id");
            e.setNom(req.getParameter("nom"));
            e.setVille(req.getParameter("ville"));
            e.setLogoUrl(req.getParameter("logoUrl"));

            if (idStr != null && !idStr.isEmpty()) {
                e.setId(Integer.parseInt(idStr));
                metier.modifierEquipe(e);
            } else {
                metier.ajouterEquipe(e);
            }
            resp.sendRedirect(req.getContextPath() + "/equipes?action=list&msg=sauvegarde");
        } catch (Exception ex) {
            req.setAttribute("error", ex.getMessage());
            req.getRequestDispatcher("/jsp/error.jsp").forward(req, resp);
        }
    }
}
