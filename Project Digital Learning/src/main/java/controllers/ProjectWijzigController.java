package controllers;

import java.io.*;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import models.User;
import models.Project;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import services.HibernateUtil;
//import services.HibernateUtil;

public class ProjectWijzigController extends HttpServlet {

    private static String titelNieuw = "New project experience";
    private static String titelWijzig = "Edit project experience";

    /* HTTP GET request */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        /* start session */
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        /* User information */
        List<User> tempProject = new LinkedList();
        // Zet de session in een variabele
        Criteria criteria = session.createCriteria(User.class);
        tempProject = criteria.list();
        request.setAttribute("projectList", tempProject);

        if (request.getParameter("id") != null) {
            // If ID is present, retrieve information.
            long projectId = Long.parseLong(request.getParameter("id"));
            request.setAttribute("id", projectId);

            Project managedProject = (Project) session.load(Project.class, projectId);

            request.setAttribute("fromYear", managedProject.getFromYear());
            request.setAttribute("tillYear", managedProject.getTillYear());
            request.setAttribute("name", managedProject.getName());
            request.setAttribute("profession", managedProject.getProfession());
            request.setAttribute("description", managedProject.getProfession());

            doorsturen(request, response, titelWijzig); //Stuurt door naar de Wijzig gebruiker pagina.
        } else {
            doorsturen(request, response, titelNieuw); //Stuurt door naar de Nieuwe gebruiker pagina.
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String dispatchUrl = null;

        boolean isProjectUpdate = request.getParameter("id") != null;

        if (isProjectUpdate) {
            //nieuwe code:
            long projectId = Long.parseLong(request.getParameter("id"));

            Session session = HibernateUtil.getSessionFactory().getCurrentSession();
            Transaction tx = session.beginTransaction();
            Project managedProject = (Project) session.load(Project.class, projectId);

            managedProject.setFromYear(Integer.parseInt(request.getParameter("fromYear")));
            managedProject.setTillYear(Integer.parseInt(request.getParameter("tillYear")));
            managedProject.setName(request.getParameter("name"));
            managedProject.setProfession(request.getParameter("profession"));
            managedProject.setDescription(request.getParameter("description"));

            User user = new User();
            user.setUserId(Integer.parseInt(request.getParameter("user")));
            managedProject.setUser(user);

            session.update(managedProject);

            tx.commit();

        } else {
            Project project = new Project();

            project.setFromYear(Integer.parseInt(request.getParameter("fromYear")));
            project.setTillYear(Integer.parseInt(request.getParameter("tillYear")));
            project.setName(request.getParameter("name"));
            project.setProfession(request.getParameter("profession"));
            project.setDescription(request.getParameter("description"));

            User user = new User();
            user.setUserId(Integer.parseInt(request.getParameter("user")));
            project.setUser(user);

            Session session = HibernateUtil.getSessionFactory().getCurrentSession();

            Transaction tx = session.beginTransaction();

            session.save(project);

            tx.commit();

        }

//            sessie.setAttribute("gebruikers", gebruikers);
//
//            sessie.setAttribute("aantalGebruikers", gebruikers.size());
        response.sendRedirect("../profile");
        if (dispatchUrl != null) {
            RequestDispatcher rd
                    = request.getRequestDispatcher(dispatchUrl);
            rd.forward(request, response);
        }
    }

    private void doorsturen(HttpServletRequest request, HttpServletResponse response, String titel)
            throws ServletException, IOException {
        // Set de pagina titel op het request
        request.setAttribute("paginaTitel", titel);

        // Stuur het resultaat van gebruiker_wijzigen.jsp terug naar de client
        String address = "/project_wijzigen.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(address);
        dispatcher.forward(request, response);
    }

    /**
     * Maakt een Project object aan de hand van de parameters uit het http request.
     */
    private Project getProductFromRequest(HttpServletRequest request) {
        Project p = new Project();

        if (request.getParameter("id") != null && !request.getParameter("id").isEmpty()) {
            p.setProjectNumber(Long.parseLong(request.getParameter("id")));
        }
        if (request.getParameter("fromYear") != null) {
            p.setFromYear(Integer.parseInt(request.getParameter("fromYear")));
        }
        if (request.getParameter("tillYear") != null) {
            p.setTillYear(Integer.parseInt(request.getParameter("tillYear")));
        }
        if (request.getParameter("name") != null) {
            p.setName(request.getParameter("name"));
        }
        if (request.getParameter("profession") != null) {
            p.setProfession(request.getParameter("profession"));
        }
        if (request.getParameter("description") != null) {
            p.setDescription(request.getParameter("description"));
        }

        return p;
    }

}