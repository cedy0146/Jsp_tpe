package controller;

import metier.TournoiMetier;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/matchs")
public class MatchServlet extends HttpServlet {

    private TournoiMetier metier = new TournoiMetier();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        int idTournoi = Integer.parseInt(req.getParameter("idTournoi"));

        try {
            if ("score".equals(action)) {
                req.setAttribute("match", metier.getMatchsByTournoi(idTournoi).stream()
                        .filter(m -> m.getId() == Integer.parseInt(req.getParameter("id")))
                        .findFirst().orElse(null));
                req.setAttribute("idTournoi", idTournoi);
                req.getRequestDispatcher("/jsp/matchs/score.jsp").forward(req, resp);
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
            int idMatch = Integer.parseInt(req.getParameter("idMatch"));
            int idTournoi = Integer.parseInt(req.getParameter("idTournoi"));
            int score1 = Integer.parseInt(req.getParameter("score1"));
            int score2 = Integer.parseInt(req.getParameter("score2"));

            metier.enregistrerScore(idMatch, score1, score2);
            resp.sendRedirect(req.getContextPath() + "/tournois?action=view&id=" + idTournoi + "&msg=score_enregistre");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/jsp/error.jsp").forward(req, resp);
        }
    }
}
