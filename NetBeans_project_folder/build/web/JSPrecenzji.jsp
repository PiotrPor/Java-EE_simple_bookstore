<%-- 
    Document   : JSPrecenzji
    Created on : Feb 16, 2022, 5:07:34 PM
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
        <title>Recenzja/Opis</title>
    </head>
    <body>
        <!-- <h1>Hello World!</h1> -->
        <%            
            String ISBN_wybranej = request.getParameter("jejISBN");

        String NazwaSterownika = "org.apache.derby.jdbc.ClientDriver";
        try {
            Class.forName(NazwaSterownika);
        } catch (ClassNotFoundException ex) {
            //Logger.getLogger(SerwletUzytkownika.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String adresURL = "jdbc:derby://localhost:1527/JKsiegarnia";
        String user = "root"; 
	String passwd = "root";
        
        String jejTytul="_", jejAutor="_", jejRecenzja="_";
        
        PrintWriter pisak = response.getWriter();
        
        try {
            Connection polaczenie = DriverManager.getConnection(adresURL, user, passwd);
            polaczenie.setAutoCommit(false);
            Statement stwierdzenie = polaczenie.createStatement(); //obiekt typu Statement sluzy do tworzenia zapytan dla bazy
            
            /*
            SELECT ks.tytul, ks.autor, r.recenzja
            FROM ksiazki ks, recenzje_ksiazek r 
            WHERE ks.ISBN='978-83-653150-5-2' AND ks.ISBN=r.ISBN
            */
            String NaszeZapytanie="";
            NaszeZapytanie = "SELECT ks.tytul, ks.autor, r.recenzja ";
            NaszeZapytanie += "FROM ksiazki ks, recenzje_ksiazek r ";
            NaszeZapytanie+="WHERE ks.ISBN=r.ISBN AND ks.ISBN=\'"+ISBN_wybranej+"\'";
            
            ResultSet dlarec = stwierdzenie.executeQuery(NaszeZapytanie);
            while(dlarec.next())
            {
                jejTytul = dlarec.getString(1);
                jejAutor = dlarec.getString(2);
                jejRecenzja = dlarec.getString(3);
            }
            dlarec.close();

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
            
            <!-- Teraz piszemy to co ma byc widoczne w <body> -->
            <h2>Recenzja</h2>
            <b>Tytul:</b> "<%= jejTytul %>" <br>
            <b>Autor:</b> <%= jejAutor %> <br>
            <b>Opis/Recenzja:</b> <%= jejRecenzja %> <br>
            <hr>
            <!-- <a href="/LogowanieDoBiblioteki/SerwletUzytkownika"> Powrot </a> -->
            <form method="post" action="SerwletUzytkownika">
                <input type="submit" value="Wracaj">
            </form>
    </body>
</html>
