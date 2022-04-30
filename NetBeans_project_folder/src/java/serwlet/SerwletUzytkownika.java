/*
  Ten serwlet uruchamiaja zwykli uzytkownicy
  Zaglada do bazy danych i wypisuje ich ksiazki
*/
package serwlet;

//importy by serwlet dzialal prawidlowo
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; //by mozna uzywac sesji (jej atrybutow przede wszystkim)
//importy do obslugi bazy danych
import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Emperor_of_Virtuals
 */
@WebServlet(name = "SerwletUzytkownika", urlPatterns = {"/SerwletUzytkownika"})
public class SerwletUzytkownika extends HttpServlet {

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
            out.println("<title>Servlet SerwletUzytkownika</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SerwletUzytkownika at " + request.getContextPath() + "</h1>");
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
            throws ServletException, IOException {
        //processRequest(request, response);
        PrintWriter pisz = response.getWriter();
        pisz.println("<home>");
        pisz.println("<head><title>Upomnienie</title></head>");
        pisz.println("<body>");
        pisz.println("<center>");
        pisz.println("  <img src=\"angry.jpg\" height=300 width=300 alt=\"[Angry emote here]\">");
        pisz.println("</center> <br/>");
        pisz.println("Zaloguj sie prawidlowo a nie baw sie adresem!!");
        pisz.println("</body></html>");
 	//pisz.print("Bezposrednie wpisanie URL wywoluje doGet");
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
            throws ServletException, IOException {
        
        
        String NazwaSterownika = "org.apache.derby.jdbc.ClientDriver";
        HttpSession sesja = prosba.getSession(); //aktualna sesja w ramach ktorej przyszedl HttpServletRequest
        
        try {
            Class.forName(NazwaSterownika);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SerwletUzytkownika.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String adresURL = "jdbc:derby://localhost:1527/JKsiegarnia";
        String user = "root"; 
	String passwd = "root";
        //String podanylogin = prosba.getParameter("username");
        //String haslo_logowania = prosba.getParameter("password");
        String podanylogin = (String)sesja.getAttribute("user_login");
        String haslo_logowania = (String)sesja.getAttribute("user_password");
        int jegoid=-1;
        
        PrintWriter pisak = odpowiedz.getWriter();
        dopiszPoczatekStrony(pisak);
        //pisak.println("Z atrybutow sesji: "+podanylogin+" "+haslo_logowania+" <br>");
        
        try {
            Connection polaczenie = DriverManager.getConnection(adresURL, user, passwd);
            polaczenie.setAutoCommit(false);
            
            Statement stwierdzenie = polaczenie.createStatement(); //obiekt typu Statement sluzy do tworzenia zapytan dla bazy
	   
           int a=0;
           String[] tablica = new String[25]; //tu beda trafiac wyniki zapytan
           
           String NaszeZapytanie;
           String wynik; //wynik zapytania jako linijka tekstu
           String jego_nazwa; //jak nazywa sie logujacy sie czlowiek
           String jego_nazwisko; //tylko nazwisko tego czlowieka
           
           jego_nazwa = "Jan Kowalski";
           jego_nazwisko = "Kowalski";

           //Zapytanie: SELECT imie, nazwisko FROM uzytkownicy WHERE login='user' AND password='delfin';
           //W zapytaniu dla Statement.executeQuery() nie piszemy na koncu srednika!! 
           NaszeZapytanie = "SELECT imie, nazwisko FROM uzytkownicy WHERE login=";
           NaszeZapytanie +="\'"+ podanylogin +"\' AND password=";
           NaszeZapytanie += "\'"+ haslo_logowania +"\'";
           
           // user + delfin = Jan Balcerczyk
           // uzytkownik + delfin = Zbigniew Poliszewski
           
            ResultSet dane_czlowieka = stwierdzenie.executeQuery(NaszeZapytanie);
            while(dane_czlowieka.next())
            {
                jego_nazwisko = dane_czlowieka.getString(2);
                jego_nazwa = dane_czlowieka.getString(1) +" "+ jego_nazwisko;
            }
            dane_czlowieka.close();
            
            //int jegoid=-1;
            NaszeZapytanie = "SELECT klientid FROM klienci WHERE nazwisko=\'"+jego_nazwisko+"\'";
            ResultSet prawdziweid = stwierdzenie.executeQuery(NaszeZapytanie);
            String abcdef;
            while(prawdziweid.next())
            {
                abcdef = prawdziweid.getString(1);
                jegoid = Integer.decode(abcdef);
            }
            prawdziweid.close();
            
            //nowe zapytanie
            /*
           SELECT
            z.zamowienieid AS Nr_zamowienia,
            ks.tytul AS Tytul,
            ks.autor AS Autor,
            ks.ISBN AS ISBN,
            ks.cena AS Cena
           FROM
            zamowienie z, pozycje_zamowienia pz, ksiazki ks, klienci kn
           WHERE
            pz.zamowienieid = z.zamowienieid AND
            ks.ISBN = pz.ISBN AND
            kn.klientid = z.klientid AND kn.nazwisko='Balcerczyk'
           ORDER BY z.zamowienieid;
           */
            NaszeZapytanie = "SELECT ";
            NaszeZapytanie += "z.zamowienieid AS Nr_zamowienia, ";
            NaszeZapytanie += "ks.tytul AS Tytul, ks.autor AS Autor, ";
            NaszeZapytanie += "ks.ISBN AS ISBN, ks.cena AS Cena ";
            NaszeZapytanie += "FROM zamowienie z, pozycje_zamowienia pz, ksiazki ks, klienci kn ";
            NaszeZapytanie += " WHERE pz.zamowienieid = z.zamowienieid AND ";
            NaszeZapytanie += "ks.ISBN = pz.ISBN AND kn.klientid = z.klientid AND ";
            NaszeZapytanie += "kn.nazwisko=\'"+ jego_nazwisko +"\' ";
            NaszeZapytanie += "ORDER BY z.zamowienieid";
            ResultSet rezultat = stwierdzenie.executeQuery(NaszeZapytanie);
            //odczytanie wyniku zapytania
            a=0;
	    while (rezultat.next()) 
	    { 
                //u nas jest 5 kolumn
                wynik = "<td> "+ rezultat.getString(1) +" </td> ";
                wynik += "<td> "+ rezultat.getString(2) +" </td> ";
                wynik += "<td> "+ rezultat.getString(3) +" </td> ";
                wynik += "<td> "+ rezultat.getString(4) +" </td> ";
                wynik += "<td> "+ rezultat.getString(5) +" </td> ";
                //System.out.println(wynik); //wypisze wynik
                tablica[a] = wynik;
                a++;
            } 
	    rezultat.close(); //zakonczenie pracy
            //koniec pytan do bazy danych
            polaczenie.commit(); 
            stwierdzenie.close();
	    polaczenie.close(); 
            
            //rezultaty naszej pracy zostana "wpisane" na strone HTML
            pisak.println("<h1><center> Witaj w ksiegarni, "+ jego_nazwa +" </center></h1>");
            
            //powstanie tabela z wynikami zapytania do bazy (tabela w HTML)
            int b=0;
            pisak.println("<table border=\"1\" bgcolor=\"white\">");
            //pierwszy wiersz tabeli to naglowki/tytuly kolumn
               //ten String jest teraz uzyty w innym celu
            wynik = "<td>Nr_zamowienia</td> <td>Tytul</td> <td>Autor</td> ";
            wynik += "<td>ISBN</td> <td>Cena</td>";
            pisak.println(" <tr>");
            pisak.println("   "+ wynik);
            pisak.println(" </tr>");
            for (b=0; b<a; b++)
            { 
              pisak.println(" <tr>");
              pisak.println("   "+ tablica[b]);
              pisak.println(" </tr>");
            }
            pisak.println("</table>");
            
        } catch (SQLException wyjatek) {
            String info1, info2, info3;
            Logger.getLogger(SerwletUzytkownika.class.getName()).log(Level.SEVERE, null, wyjatek);
            info1 = "SQLException: " + wyjatek.getMessage();
            info2 = "SQLState: " + wyjatek.getSQLState();
            info3 = "VendorError: " + wyjatek.getErrorCode();
            System.out.println(info1);
            System.out.println(info2);
            System.out.println(info3);
            pisak.println("<h2><center> Exception! </center></h2>");
            pisak.println(info1 + "<br/>");
            pisak.println(info2 + "<br/>");
            pisak.println(info3 + "<br/>");
        }
        
        //juz skonczylismy korzystac z bazy i mozna robic inne rzeczy
        pisak.println("<br>");
        //pisak.println("<a href=\"SerwWypozycz\"> Link do serwleta </a> <br>");
        if(jegoid>0)
        {
            pisak.println("<form method=\"post\" action=\"/LogowanieDoBiblioteki/JSPWypozyczenia.jsp\">");
            pisak.println("<input type=\"hidden\" name=\"ID_zalogowanego\" value=\""+ String.valueOf(jegoid) +"\">");
            pisak.println("<input type=\"submit\" value=\"Wypozycz ksiazke\">");
            pisak.println("</form>");
            pisak.println("<br>");
        }
        //zakonczenie strony
        pisak.println("<a href=\"/LogowanieDoBiblioteki/index.jsp\">Wroc na poczatek</a>");
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
        return "Short description";
    }// </editor-fold>
    
    //moja wlasna metoda, potrzebna przy wypisaniu wynikow
    public void dopiszPoczatekStrony(PrintWriter ppp)
    {
        ppp.println("<html>");
        ppp.println("<head>");
        ppp.println(" <title> Serwlet DB zwyklego uzytkownika </title>");            
        ppp.println("</head>");
        ppp.println("<body bgcolor=\"#54ff57\">");
    }

}
