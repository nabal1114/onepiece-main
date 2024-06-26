package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.model.detail.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        request.getRequestDispatcher("/view/web/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        HttpSession session = request.getSession();

        User user = Singleton.userDAO.get(email);

        if (user != null && user.getHashedPassword().equals(Hash.SHA256(password))) {
            session.setAttribute("user", user);
            
            if (user.getStatus() == UserStatus.ACTIVATE) {
                response.sendRedirect("home");
                return;
            } else {
                response.sendRedirect("verify");
                return;
            }
        }

        String errorMsg = "Wrong password!";
        if (user == null) {
            errorMsg = "Account does not exist!";
            email = null;
        }

        request.setAttribute("email", email);
        request.setAttribute("errorMsg", errorMsg);

        this.doGet(request, response);
    }
}
