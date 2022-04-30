/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serwlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//
import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
//
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Emperor_of_Virtuals
 */
@WebServlet(name = "SerwletDodawania", urlPatterns = {"/SerwletDodawania"})
public class SerwletDodawania extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SerwletDodawania</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SerwletDodawania at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        //processRequest(request, response);
        PrintWriter pisz = response.getWriter();
        pisz.println("<html><head><title> Nie nie </title></head>");
        pisz.println("<body>");
        pisz.println("<b><u> Wejsdz tu w inny sposob >:( </u></b>");
        pisz.println("</body></html>");
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest prosba, HttpServletResponse odpowiedz)
            throws ServletException, IOException 
    {
        //processRequest(request, response);
        String NazwaSterownika = "org.apache.derby.jdbc.ClientDriver";
        try {
            Class.forName(NazwaSterownika);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SerwletUzytkownika.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String adresURL = "jdbc:derby://localhost:1527/JKsiegarnia";
        String DB_login = "root"; 
	String DB_password = "root";
        String podany_login = prosba.getParameter("login_nowego");
        String podane_haslo = prosba.getParameter("haslo_nowego");
        String podane_imie = prosba.getParameter("imie_nowego");
        String podane_nazwisko = prosba.getParameter("nazwisko_nowego");
        
        PrintWriter pisak = odpowiedz.getWriter();
        //dopiszPoczatekStrony(pisak);
        //napisanie poczatku strony
        pisak.println("<html>");
        pisak.println("<head>");
        pisak.println(" <title> Rejestracja uzytkownika </title>");            
        pisak.println("</head>");
        pisak.println("<body bgcolor=\"#54ff57\">");
        
        //uzywanie bazy danych
        //wszystko w wielkim try{}catch(){}
        try
        {
            Connection polaczenie = DriverManager.getConnection(adresURL, DB_login, DB_password);
            polaczenie.setAutoCommit(false);
            
            Statement stwierdzenie = polaczenie.createStatement(); //obiekt typu Statement sluzy do tworzenia zapytan dla bazy
	   
           //int a=0;
           //String[] tablica = new String[6]; //tu beda trafiac wyniki zapytan
           
           /*
           INSERT INTO 
             uzytkownicy(login,password,imie,nazwisko) 
           VALUES 
             ('admin', 'admin', 'Tomasz', 'Tomaszewski');
           */
           String NaszeZapytanie;
           NaszeZapytanie = "INSERT INTO uzytkownicy(login,password,imie,nazwisko) VALUES(";
           NaszeZapytanie += "\'"+ podany_login + "\', ";
           NaszeZapytanie += "\'"+ podane_haslo + "\', ";
           NaszeZapytanie += "\'"+ podane_imie + "\', ";
           NaszeZapytanie += "\'"+ podane_nazwisko + "\')";
           
           //ResultSet wynik_zapytania = stwierdzenie.executeQuery(NaszeZapytanie);
            //dla UPDATE, INSERT i DELETE uzywa sie Statement.executeUpdate()
           int zwracana = stwierdzenie.executeUpdate(NaszeZapytanie);
            //zwraca liczbe
           //wynik_zapytania.close();
           
           //koniec pytan do bazy danych
            polaczenie.commit(); 
            stwierdzenie.close();
	    polaczenie.close(); 
            
            pisak.println("Dodano uzytkownika <br/>");
            pisak.println("  Tozsamosc: "+ podane_imie +" "+ podane_nazwisko+" <br/>");
            pisak.println("  Login: "+ podany_login+" <br/>");
            pisak.println("  Haslo: "+ podane_haslo+"<br/>");
            //linijki tylko tymczasowo
            //pisak.println("\n<hr>\n  <i>"+ NaszeZapytanie +"</i>");
            
        
        } catch (SQLException wyjatek) {
            String info1, info2, info3;
            Logger.getLogger(SerwletUzytkownika.class.getName()).log(Level.SEVERE, null, wyjatek);
            info1 = "SQLException: " + wyjatek.getMessage();
            info2 = "SQLState: " + wyjatek.getSQLState();
            info3 = "VendorError: " + wyjatek.getErrorCode();
            //informacja o wyjatku pojawi sie w 2 miejscach
            System.out.println(info1);
            System.out.println(info2);
            System.out.println(info3);
            pisak.println("<h2><center> Exception! </center></h2>");
            pisak.println(info1 + "<br/>");
            pisak.println(info2 + "<br/>");
            pisak.println(info3 + "<br/>");
        }
        
        //zakonczenie strony
        pisak.println("<br/><hr>   Powrot<br/>");
        //pisak.println("<form method=\"post\" action=\"decyzyjny.jsp\">");
        //pisak.println("<input type=\"submit\" value=\"RETURN\">");
        //pisak.println("</form> <br/>");
        pisak.println("<a href=\"/LogowanieDoBiblioteki/decyzyjny.jsp?wpisany_username=admin&wpisane_haslo=admin\">RETURN</a> <br/>");
        pisak.println("</body>");
        pisak.println("</html>");
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet used to add new user to a table in the database";
    }// </editor-fold>

}
