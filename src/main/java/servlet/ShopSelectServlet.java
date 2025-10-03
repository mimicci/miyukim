package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import bean.ShopBean;

/**
 * Servlet implementation class ShopSelectServlet
 */
@WebServlet("/ShopSelectServlet")
public class ShopSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShopSelectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		// Servlet側でリストを設定
		List<ShopBean> shopBeanList = new ArrayList<ShopBean>();	
		List<String> shopList = new ArrayList<String>();
		shopList.add("ピッツェリア　バー31");
		shopList.add("たまに屋　荻窪店");
		shopList.add("シカゴピッザ");
		shopList.add("農家の台所");
		for (String shop : shopList) {
			ShopBean shopbean = new ShopBean(shop);
			shopBeanList.add(shopbean);
		}
		request.setAttribute("shopBeanList", shopBeanList);
		RequestDispatcher dispacher = request.getRequestDispatcher("./ShopRandamSelect.jsp");
		dispacher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
