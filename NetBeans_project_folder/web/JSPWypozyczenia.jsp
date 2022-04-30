<%-- 
    Document   : JSPWypozyczenia
    Created on : Feb 14, 2022, 9:40:35 PM
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
        <title> Wypozycz jakas ksiazke </title>
    </head>
    <body>
        <%
            int jegoid=-1;
            String rgp = request.getParameter("ID_zalogowanego");
            jegoid = Integer.decode(rgp);

String NazwaSterownika = "org.apache.derby.jdbc.ClientDriver";
        try {
            Class.forName(NazwaSterownika);
        } catch (ClassNotFoundException ex) {
            //Logger.getLogger(SerwletUzytkownika.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String adresURL = "jdbc:derby://localhost:1527/JKsiegarnia";
        String user = "root"; 
	String passwd = "root";
        //String podanylogin = request.getParameter("username");
        //String haslo_logowania = request.getParameter("password");
        
        PrintWriter pisak = response.getWriter();
        
        try {
            Connection polaczenie = DriverManager.getConnection(adresURL, user, passwd);
            polaczenie.setAutoCommit(false);
            Statement stwierdzenie = polaczenie.createStatement(); //obiekt typu Statement sluzy do tworzenia zapytan dla bazy
	   
           int a=0;
           String[] tablica = new String[25]; //tu beda trafiac wyniki zapytan
           String[] ISBNTab = new String[25]; //w tej tablicy beda tylko ISBNy
           
           String NaszeZapytanie;
           String wynik; //wynik zapytania jako linijka tekstu
           String link;
           int co_chce=-1;
           

           //Zapytanie: SELECT imie, nazwisko FROM uzytkownicy WHERE login='user' AND password='delfin';
           //W zapytaniu dla Statement.executeQuery() nie piszemy na koncu srednika!! 
           /*NaszeZapytanie = "SELECT imie, nazwisko FROM uzytkownicy WHERE login=";
           NaszeZapytanie +="\'"+ podanylogin +"\' AND password=";
           NaszeZapytanie += "\'"+ haslo_logowania +"\'";
           */
           // user + delfin = Jan Balcerczyk
           // uzytkownik + delfin = Zbigniew Poliszewski
           
            
            //nowe zapytanie
            //wypisz dane ksiazek, ktorych jeszcze nie wypozyczyl
            /*
              SELECT k.*
              FROM ksiazki k, pozycje_zamowienia pz, zamowienie zm
              WHERE k.ISBN = pz.ISBN AND pz.zamowienieid=zm.zamowienieid
              AND zm.klientid<>13
              ORDER BY k.cena;
           */
            /*
            NaszeZapytanie = "SELECT k.tytul AS \"Tytul\", k.autor AS \"Autor\", k.ISBN AS \"Nr ISBN\", ";
            NaszeZapytanie += "k.cena AS \"Cena\" ";
            NaszeZapytanie += "FROM ksiazki k, pozycje_zamowienia pz, zamowienie zm ";
            NaszeZapytanie += "WHERE k.ISBN = pz.ISBN AND pz.zamowienieid=zm.zamowienieid ";
            NaszeZapytanie += "AND zm.klientid<>"+rgp+" ORDER BY k.cena";
            */
            NaszeZapytanie = "SELECT k.tytul AS \"Tytul\", k.autor AS \"Autor\", k.ISBN AS \"Nr ISBN\", ";
            NaszeZapytanie += "k.cena AS \"Cena\" FROM ksiazki k";
            ResultSet rezultat = stwierdzenie.executeQuery(NaszeZapytanie);
            //odczytanie wyniku zapytania
            a=0;
	    while (rezultat.next()) 
	    { 
                //u nas sa 4 kolumny
                wynik = "<td> "+ rezultat.getString(1) +" </td> ";
                wynik += "<td> "+ rezultat.getString(2) +" </td> ";
                wynik += "<td> "+ rezultat.getString(3) +" </td> ";
                wynik += "<td> "+ rezultat.getString(4) +" </td> ";
                tablica[a] = wynik;
                ISBNTab[a] = rezultat.getString(3);
                a++;
            } 
	    rezultat.close(); //zakonczenie pracy
            //koniec pytan do bazy danych
            polaczenie.commit(); 
            stwierdzenie.close();
	    polaczenie.close(); 
            
            //rezultaty naszej pracy zostana "wpisane" na strone HTML            
               //powstanie tabela z wynikami zapytania do bazy (tabela w HTML)
            int b=0;
            pisak.println("<form action=\"/LogowanieDoBiblioteki/JSPWykonaZamowienie.jsp\">");
            pisak.println("<table border=\"1\" bgcolor=\"white\">");
            //pierwszy wiersz tabeli to naglowki/tytuly kolumn
               //ten String jest teraz uzyty w innym celu
            wynik = "<td>Tytul</td> <td>Autor</td> <td>Numer ISBN</td> <td>Cena</td> <td>  </td> <td> </td>";
            pisak.println(" <tr>");
            pisak.println("   "+ wynik);
            pisak.println(" </tr>");
            
            for (b=0; b<a; b++)
            { 
              //<input type="checkbox" id="my_tickbox_1" name="nazwa_zmiennej" value="507">
              wynik = "<input type=\"radio\" id=\"radiobutton_"+ String.valueOf(b+1) +"\" ";
              wynik += "name=\"ISBN_wybranej\" value=\""+ ISBNTab[b] +"\">";
              //<a href="/LogowanieDoBiblioteki/JSPrecenzja.jsp?jejISBN=aaaaa">recenzja</a>
              link="<a href=\"/LogowanieDoBiblioteki/JSPrecenzji.jsp?jejISBN=";
              link+= ISBNTab[b] +"\">recenzja</a>";
              //caly wiersz tabeli
              pisak.println(" <tr>");
              pisak.println("   "+ tablica[b] +" <td>"+wynik+"</td><td>"+link+"</td>");
              pisak.println(" </tr>");
            }
            pisak.println("</table><br>");
            pisak.println("<input type=\"hidden\" name=\"ID_zalogowanego\" value=\""+rgp+"\">");
            pisak.println("<input type=\"submit\" value=\"Wypozycz\">");
            pisak.println("</form>");
            
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
        <br>
        <!-- <a href="../src/java/serwlet/SerwletUzytkownika"> Link do serwleta </a> <br> -->
        <!-- <form action="SerwletUzytkownika" method="POST"> -->
        <form action="/LogowanieDoBiblioteki/SerwletUzytkownika" method="POST">
        <% pisak.println("<input type=\"hidden\" name=\"ID_zalogowanego\" value=\""+rgp+"\">"); %>
        <input type="submit" value="Wracaj">
        </form>
    </body>
</html>
