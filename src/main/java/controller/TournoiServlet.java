package controller;

import metier.TournoiMetier;
import model.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/tournois")
public class TournoiServlet extends HttpServlet {

    private TournoiMetier metier = new TournoiMetier();
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "list":
                    List<Tournoi> tournois = metier.getAllTournois();
                    req.setAttribute("tournois", tournois);
                    dispatch(req, resp, "/jsp/tournois/list.jsp");
                    break;

                case "create":
                    dispatch(req, resp, "/jsp/tournois/form.jsp");
                    break;

                case "edit":
                    int id = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("tournoi", metier.getTournoiById(id));
                    dispatch(req, resp, "/jsp/tournois/form.jsp");
                    break;

                case "view":
                    int tid = Integer.parseInt(req.getParameter("id"));
                    Tournoi t = metier.getTournoiById(tid);
                    req.setAttribute("tournoi", t);
                    req.setAttribute("matchs", metier.getMatchsByTournoi(tid));
                    req.setAttribute("classement", metier.getClassement(tid));
                    req.setAttribute("toutesEquipes", metier.getAllEquipes());
                    dispatch(req, resp, "/jsp/tournois/detail.jsp");
                    break;

                case "delete":
                    metier.supprimerTournoi(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/tournois?action=list&msg=supprime");
                    break;

                case "generer":
                    metier.genererCalendrier(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/tournois?action=view&id=" +
                            req.getParameter("id") + "&msg=calendrier_genere");
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/tournois");
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            try {
                dispatch(req, resp, "/jsp/error.jsp");
            } catch (Exception ex) {
                throw new ServletException(ex);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        req.setCharacterEncoding("UTF-8");

        try {
            if ("save".equals(action)) {
                Tournoi t = new Tournoi();
                String idStr = req.getParameter("id");
                t.setNom(req.getParameter("nom"));
                t.setType(Tournoi.Type.valueOf(req.getParameter("type")));

                String dd = req.getParameter("dateDebut");
                String df = req.getParameter("dateFin");
                if (dd != null && !dd.isEmpty()) t.setDateDebut(sdf.parse(dd));
                if (df != null && !df.isEmpty()) t.setDateFin(sdf.parse(df));

                if (idStr != null && !idStr.isEmpty()) {
                    t.setId(Integer.parseInt(idStr));
                    t.setStatut(Tournoi.Statut.valueOf(req.getParameter("statut")));
                    metier.modifierTournoi(t);
                } else {
                    metier.creerTournoi(t);
                }
                resp.sendRedirect(req.getContextPath() + "/tournois?action=list&msg=sauvegarde");

            } else if ("inscrire".equals(action)) {
                int idTournoi = Integer.parseInt(req.getParameter("idTournoi"));
                int idEquipe = Integer.parseInt(req.getParameter("idEquipe"));
                metier.inscrireEquipe(idTournoi, idEquipe);
                resp.sendRedirect(req.getContextPath() + "/tournois?action=view&id=" + idTournoi);

            } else if ("desinscrire".equals(action)) {
                int idTournoi = Integer.parseInt(req.getParameter("idTournoi"));
                int idEquipe = Integer.parseInt(req.getParameter("idEquipe"));
                metier.desinscrireEquipe(idTournoi, idEquipe);
                resp.sendRedirect(req.getContextPath() + "/tournois?action=view&id=" + idTournoi);
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            try {
                dispatch(req, resp, "/jsp/error.jsp");
            } catch (Exception ex) {
                throw new ServletException(ex);
            }
        }
    }

    private void dispatch(HttpServletRequest req, HttpServletResponse resp, String path)
            throws ServletException, IOException {
        req.getRequestDispatcher(path).forward(req, resp);
    }
}
