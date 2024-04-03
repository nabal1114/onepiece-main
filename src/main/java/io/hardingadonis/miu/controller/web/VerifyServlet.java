package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.model.detail.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet(name = "VerifyServlet", urlPatterns = {"/verify"})
public class VerifyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if ((user == null) || (user.getStatus() == UserStatus.ACTIVATE)) {
            response.sendRedirect("home");
            return;
        }

        String email = request.getParameter("email");

        String msg = null;

        if ((email == null) || (email.isEmpty())) {
            String hashedStr = Hash.SHA256(email + System.currentTimeMillis());

            session.setAttribute("hashed_verify_str", hashedStr);

            Singleton.email.sendVerifyEmail(user, hashedStr, request);

            msg = "You have received an account verification email. Please check your email!";
        } else {
            if (user.getEmail().equals(email)) {
                String hashedStrParameter = request.getParameter("code");
                String hashedStrSession = (String) session.getAttribute("hashed_verify_str");

                if ((hashedStrParameter != null) && (hashedStrSession != null) && (hashedStrParameter.equals(hashedStrSession))) {
                    user.setStatus(UserStatus.ACTIVATE);

                    session.setAttribute("hashed_verify_str", null);

                    request.setAttribute("success", true);

                    Singleton.userDAO.update(user);
                    Singleton.email.sendWelcomeEmail(user);

                    msg = "Authentication successful!";
                } else {
                    msg = "Authentication failed!";
                }
            } else {
                msg = "Authentication failed!";
            }
        }

        request.setAttribute("msg", msg);

        request.getRequestDispatcher("/view/web/verify.jsp").forward(request, response);
    }
}
