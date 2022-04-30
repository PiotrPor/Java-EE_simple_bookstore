/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serwlet;

//zeby to byl sprawny serwlet
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//do obslugi bazy danych
import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
  www.geeksforgeeks.org/java-servlet-and-jdbc-example-insert-data-in-mysql/
  www.journaldev.com/1997/servlet-jdbc-database-connection-example
 */
@WebServlet(name = "Bazodanowy", urlPatterns = {"/Bazodanowy"})
public class Bazodanowy extends HttpServlet {
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
      //chyba nie zostanie przez mnie uzyte
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Bazodanowy</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Bazodanowy at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        //}
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
            throws ServletException, IOException {
        //wykona sie jesli wpiszemy "Bazodanowy" od razu w URL
        PrintWriter out = response.getWriter();
        out.println("<home>");
        out.println("<head><title>Upomnienie</title></head>");
        out.println("<body>");
        out.println("<center>");
        out.println("  <img src=\"angry.jpg\" height=300 width=300 alt=\"[Angry emote here]\">");
        out.println("</center> <br/>");
        out.println("Zaloguj sie prawidlowo a nie baw sie adresem!!");
        out.println("</body></html>");
 	//out.print("doGet: Hello World");
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
    protected void doPost(HttpServletRequest prosba, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        String NazwaSterownika = "org.apache.derby.jdbc.ClientDriver";
        
        try {
            Class.forName(NazwaSterownika);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Bazodanowy.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        //String adresURL = "jdbc:derby://localhost:1527/JKsiegarnia";
        String adresURL = "jdbc:derby://localhost/JKsiegarnia";
        String user = "root"; 
	String passwd = "root";
        //wartosci z zapytania
        int numerpytania=0;
        String QuestionNumber = prosba.getParameter("numer_pytania");
        numerpytania = Integer.decode(QuestionNumber);
        String IDklienta = String.valueOf(3);
        IDklienta = prosba.getParameter("pytajID");
        
        //zapytania, jakie moze zadac admin
        String[] TabPytania = new String[4];
        String[] TabOpisy = new String[4];
        int[] TabIleKolumn = {4,3,5,2}; //ile kolumn zwraca ktore zapytanie
           //pierwsze pytanie (domyslne)
        TabPytania[0] = "SELECT * FROM klienci";
           //drugie pytanie
        TabPytania[1] = "SELECT kn.nazwisko, ks.tytul, ks.autor ";
        TabPytania[1] += "FROM zamowienie z, pozycje_zamowienia pz, ksiazki ks, klienci kn ";
        TabPytania[1] += "WHERE pz.zamowienieid=z.zamowienieid AND ks.ISBN=pz.ISBN ";
        TabPytania[1] += "AND kn.klientid=z.klientid ORDER BY kn.nazwisko";
           //trzecie pytanie
        TabPytania[2] = "SELECT z.zamowienieid, ks.tytul, ks.autor, ks.ISBN, ks.cena ";
        TabPytania[2] += "FROM zamowienie z, pozycje_zamowienia pz, ksiazki ks, klienci kn ";
        TabPytania[2] += "WHERE pz.zamowienieid=z.zamowienieid AND ks.ISBN=pz.ISBN AND ";
        TabPytania[2] += "kn.klientid=z.klientid AND kn.klientid="+ IDklienta+" ";
        TabPytania[2] += "ORDER BY z.zamowienieid";
           //czwarte pytanie
        TabPytania[3] = "SELECT kn.nazwisko, COUNT(*) FROM zamowienie z, klienci kn ";
        TabPytania[3] += "WHERE kn.klientid=z.klientid GROUP BY kn.nazwisko";
        //opisy zapytan
        TabOpisy[0] = "Dane wszystkich klientow";
        TabOpisy[1] = "Wypisze dla kazdego ktore ksiazki zamowil";
        TabOpisy[2] = "Wypisze ksiazki zamowione przez klienta o ID "+ IDklienta;
        TabOpisy[3] = "Kto ile ksiazek zamowil";
        
        String[] tablica = new String[40];
        
        int a,b;
        
        PrintWriter pisak = response.getWriter();
        dopiszPoczatekStrony(pisak);
         
        try {
            Connection polaczenie = DriverManager.getConnection(adresURL, user, passwd);
            polaczenie.setAutoCommit(false);
            
            Statement stwierdzenie = polaczenie.createStatement(); //obiekt typu Statement sluzy do tworzenia zapytan dla bazy
	   
           String NaszeZapytanie;
           
           
           ResultSet rezultat = stwierdzenie.executeQuery(TabPytania[numerpytania]);
           String wynik;
           a=0;
	   while (rezultat.next()) 
	   { 
             wynik = "";
             //ilosc kolumn zwracana jest inna dla kazdego pytania
             for (b=1; b<=TabIleKolumn[numerpytania]; b++)
             {
                 wynik += "<td> "+ rezultat.getString(b) +" </td> ";
             }
             tablica[a] = wynik;
             a++;
           } 
		//zakonczenie pracy
		rezultat.close(); 
		polaczenie.commit(); 
		stwierdzenie.close();
		polaczenie.close(); 
                
            
            if(tablica[0].isEmpty())
            {
                pisak.println("<h2><center><i> Brak wynikow zapytania </i></center></h2>");
            }
            else
            {
                pisak.println("<h2> Wynik zapytania </h2>");
                pisak.println(TabOpisy[numerpytania] +" <br>");
                pisak.println("<table border=\"1\">");
                for (b=0; b<a; b++)
                { 
                   pisak.println(" <tr>");
                   pisak.println("  <td> "+ String.valueOf(b+1) +" </td>  "+ tablica[b]);
                   pisak.println(" </tr>");
                }
                pisak.println("</table>");
            }
            
            
        } catch (SQLException wyjatek) {
            Logger.getLogger(Bazodanowy.class.getName()).log(Level.SEVERE, null, wyjatek);
            System.out.println("SQLException: " + wyjatek.getMessage());
            System.out.println("SQLState: " + wyjatek.getSQLState());
            System.out.println("VendorError: " + wyjatek.getErrorCode());
        }
        
        //login = request.getParameter("wpisany_username");
        //haslo = request.getParameter("wpisane_haslo");
        //<a href="/LogowanieDoBiblioteki/decyzyjny.jsp">Powrot</a>
        pisak.println("<hr/>");
        pisak.println("<a href=\"/LogowanieDoBiblioteki/decyzyjny.jsp?wpisany_username=admin&wpisane_haslo=admin\">Powrot</a>");
        pisak.println("</body>");
        pisak.println("</html>");
            
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet to send a SQL querry to our database";
    }// </editor-fold>

    //moja wlasna metoda, potrzebna przy wypisaniu wynikow
    public void dopiszPoczatekStrony(PrintWriter ppp)
    {
        ppp.println("<html>");
        ppp.println("<head>");
        ppp.println(" <title> Serwlet Bazodanowy </title>");            
        ppp.println("</head>");
        ppp.println("<body bgcolor=\"#0beeee\">");
    }
}
