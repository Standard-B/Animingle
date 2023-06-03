package com.sist.animingle.board.adoption;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/board/adoptionview.do")
public class AdoptionView extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//AdoptionView.java

		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/board/adoption/adoptionview.jsp");
		dispatcher.forward(req, resp);

	}

}
