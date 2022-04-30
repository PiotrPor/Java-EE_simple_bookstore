<%-- 
    Document   : JSPWykonaZamowienie
    Created on : Feb 14, 2022, 11:04:18 PM
    Author     : Emperor_of_Virtuals
--%>

<!-- do obslugi bazy danych -->
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<!-- inne importy -->
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="javax.servlet.jsp.*"%>
<%@page import="javax.servlet.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Wykonanie zamowienia</title>
    </head>
    <body>
        <!-- <h1>Hello World!</h1> -->
        <%
            String jejISBN = request.getParameter("ISBN_wybranej");
            String rgp = request.getParameter("ID_zalogowanego");
            int jegoid=-1;
            jegoid = Integer.decode(rgp);
            
            String jejcena="1.0"; //cena ksiazki
            int nrzam=-2; //ID nowego zamowienia
            String NrString; //to co wyzej ale jako String

        String NazwaSterownika = "org.apache.derby.jdbc.ClientDriver";
        try {
            Class.forName(NazwaSterownika);
        } catch (ClassNotFoundException ex) {
            //Logger.getLogger(SerwletUzytkownika.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String adresURL = "jdbc:derby://localhost:1527/JKsiegarnia";
        String user = "root"; 
	String passwd = "root";
        
        PrintWriter pisak = response.getWriter();
        
        String[] TabAboutBook = new String[5]; //tu beda trafiac wyniki zapytan
        
        try {
            Connection polaczenie = DriverManager.getConnection(adresURL, user, passwd);
            polaczenie.setAutoCommit(false);
            Statement stwierdzenie = polaczenie.createStatement(); //obiekt typu Statement sluzy do tworzenia zapytan dla bazy
	   
           
           String NaszeZapytanie;
           String wynik; //wynik zapytania jako linijka tekstu
           int co_chce=-1;
           

           //W zapytaniu dla Statement.executeQuery() nie piszemy na koncu srednika!! 
            
            //SELECT MAX(zamowienieid) FROM pozycje_zamowienia;           
            NaszeZapytanie = "SELECT MAX(zamowienieid) FROM pozycje_zamowienia";
            //pisak.println(NaszeZapytanie+" <br>"); //debug
            ResultSet dajnumer = stwierdzenie.executeQuery(NaszeZapytanie);
            while(dajnumer.next())
            {
                nrzam = Integer.decode(dajnumer.getString(1));
            }
            dajnumer.close();
            nrzam++;
            
            //SELECT cena FROM ksiazki WHERE ISBN='978-83-818-8155-5';
            NaszeZapytanie="SELECT cena FROM ksiazki WHERE ISBN=\'"+jejISBN+"\'";
            //pisak.println(NaszeZapytanie+" <br>"); //debug
            ResultSet dajcene = stwierdzenie.executeQuery(NaszeZapytanie);
            while(dajcene.next())
            {
                jejcena = dajcene.getString(1);
            }
            dajcene.close();
            
            int wynikinsert=7;
            //ResultSet wynik_zapytania = stwierdzenie.executeQuery(NaszeZapytanie);
            //dla UPDATE, INSERT i DELETE uzywa sie Statement.executeUpdate()
            //int zwracana = stwierdzenie.executeUpdate(NaszeZapytanie);
            /*
            --kolejnosc INSERT i DELETE ma znaczenie, bo sa wprowadzone 'constraint'
            INSERT INTO zamowienie VALUES (21,17,24.7,'2016-02-14');
            INSERT INTO pozycje_zamowienia VALUES(21,'978-83-818-8155-5',1);
            SELECT * FROM zamowienie WHERE zamowienieid=21;
            SELECT * FROM pozycje_zamowienia WHERE zamowienieid=21;
            DELETE FROM pozycje_zamowienia WHERE zamowienieid=21;
            DELETE FROM zamowienie WHERE zamowienieid=21;
            */
            NaszeZapytanie="INSERT INTO zamowienie VALUES (";
            NaszeZapytanie += String.valueOf(nrzam)+", "+rgp+", "+jejcena+", \'2022-02-15\')";
            //pisak.println(NaszeZapytanie+" <br>"); //debug
            wynikinsert = stwierdzenie.executeUpdate(NaszeZapytanie);
            
            NaszeZapytanie="INSERT INTO pozycje_zamowienia VALUES(";
            NaszeZapytanie += String.valueOf(nrzam)+", \'"+jejISBN+"\', 1)";
            //pisak.println(NaszeZapytanie+" <br>"); //debug
            wynikinsert = stwierdzenie.executeUpdate(NaszeZapytanie);
            
            /*
            SELECT ks.tytul, ks.autor, ks.cena, r.recenzja
            FROM ksiazki ks, recenzje_ksiazek r 
            WHERE ks.ISBN='978-83-653150-5-2' AND ks.ISBN=r.ISBN
            */
            NaszeZapytanie = "SELECT ks.tytul, ks.autor, ks.cena, r.recenzja ";
            NaszeZapytanie += "FROM ksiazki ks, recenzje_ksiazek r ";
            NaszeZapytanie += "WHERE ks.ISBN=r.ISBN AND ks.ISBN=\'"+jejISBN+"\'";
            ResultSet InfoKsiazki = stwierdzenie.executeQuery(NaszeZapytanie);
            while(InfoKsiazki.next())
            {
                TabAboutBook[0] = InfoKsiazki.getString(1); //tytul
                TabAboutBook[1] = InfoKsiazki.getString(2); //autor
                TabAboutBook[2] = InfoKsiazki.getString(3); //cena
                TabAboutBook[3] = jejISBN;
                TabAboutBook[4] = InfoKsiazki.getString(4); //opis/recenzja
            }
            InfoKsiazki.close();
            
            //koniec pytan do bazy danych
            polaczenie.commit(); 
            stwierdzenie.close();
	    polaczenie.close(); 
            
        } catch (SQLException wyjatek) {
            String info1, info2, info3;
            info1 = "SQLException: " + wyjatek.getMessage();
            info2 = "SQLState: " + wyjatek.getSQLState();
            info3 = "VendorError: " + wyjatek.getErrorCode();
            System.out.println(info1);
            System.out.println(info2);
            System.out.println(info3);
            %>
            <h2><center> Exception! </center></h2>
            <%= info1 %> <br/>
            <%= info2 %> <br/>
            <%= info3 %> <br/>
            <% } %>
        
       <!-- juz skonczylismy korzystac z bazy i mozna robic inne rzeczy -->
       <h3>Zamowiles ksiazke</h3><br>
       <ul>
           <li> Tytul: <%= TabAboutBook[0] %> </li>
           <li> Autor: <%= TabAboutBook[1] %> </li>
           <li> Cena: <%= TabAboutBook[2] %> PLN </li>
           <li> ISBN: <%= TabAboutBook[3] %> </li>
           <li> Recenzja: <%= TabAboutBook[4] %> </li>
       </ul>
        <br>
        <form action="/LogowanieDoBiblioteki/SerwletUzytkownika" method="POST">
           <input type="hidden" name="ID_zalogowanego" value="<%= rgp %>">
          <input type="submit" value="Wracaj">
        </form>
        <!-- <a href="SerwWypozycz"> Link do serwleta </a> <br> -->
    </body>
</html>
