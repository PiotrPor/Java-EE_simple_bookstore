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
<!-- ##### -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Potwierdzenie logowania</title>
</head>
<body bgcolor="#a68a27">
   <%
          Boolean stanlogowania = false;
          Boolean jestadminem = false;
          String login, haslo;
          login = request.getParameter("wpisany_username");
          haslo = request.getParameter("wpisane_haslo");
          session.setAttribute("user_login", login);
          session.setAttribute("user_password", haslo);
          
          String NazwaSterownika = "org.apache.derby.jdbc.ClientDriver";
          String adresURL = "jdbc:derby://localhost:1527/JKsiegarnia";
          String user = "root"; 
	  String passwd = "root";
          
          String str1, str2;
          String Zapytanie;
        
          try {
            Connection polaczenie = DriverManager.getConnection(adresURL, user, passwd);
            polaczenie.setAutoCommit(false);
            Statement stwierdzenie = polaczenie.createStatement();
            
            //SELECT * FROM uzytkownicy WHERE login='admin' AND password='admin';
            Zapytanie = "SELECT * FROM uzytkownicy WHERE login=";
            Zapytanie += "\'"+login+"\' AND password=\'"+haslo+"\'";
            ResultSet wykryty = stwierdzenie.executeQuery(Zapytanie);
            while(wykryty.next())
            {
                stanlogowania = true;
                str1 = wykryty.getString(3);
                str2 = wykryty.getString(4);
                if(str1.equals("Administrator") && str2.equals("Naczelny"))
                {
                    jestadminem = true;
                }
            }
            wykryty.close();
            
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
            }
          
          if (stanlogowania && !jestadminem)
          {
              session.setAttribute("czy_zalogowany", (Boolean)true);
        %>
          Logujesz sie jako <u>zwykly uzytkownik</u> <br>
          <form method="post" action="SerwletUzytkownika">
            <input type="text" name="username" value=<%=login%>>
            <input type="text" name="password" value=<%=haslo%>>
            <input type="submit" value="ok">
          </form>
        <%  
          }
          else if (stanlogowania && jestadminem)
          {
              session.setAttribute("czy_zalogowany", (Boolean)true);
        %>
          Logujesz sie jako <u>Admin</u> <br>
          Mozesz wybrac <i>zapytanie</i> <br>
          <form method="post" action="Bazodanowy">
            <input type="radio" id="nr_0" name="numer_pytania" value="0">
            Dane wszystkich klientow <br>
            <input type="radio" id="nr_1" name="numer_pytania" value="1">
            Wypisze dla kazdego ktore ksiazki zamowil <br>
            <input type="radio" id="nr_2" name="numer_pytania" value="2">
            Wypisze ksiazki zamowione przez klienta o konkretnym id (1-20)
             <input type="number" name="pytajID" min="1" max="20" value="5"> <br>
            <input type="radio" id="nr_3" name="numer_pytania" value="3">
            Kto ile ksiazek zamowil <br>
            <input type="submit" value="Zapytaj">
          </form> <br>
            
           <!-- zey mozna dodac nowego uzytkownika --> 
          <form method="post" action="formularz_nowego_uzytkownika.jsp">
            <input type="submit" value="Zarejestruj nowego uzytkownika">
          </form>
        <% }else if(!stanlogowania) { %>
          <form method="post" action="kolejne_logowanie.jsp">
            <input type="text" name="username" value=<%=login%>>
            <input type="text" name="password" value=<%=haslo%>>
            <input type="submit" value="ok">
          </form>
        <% } %>
        <br> <br> <hr>
        Wyloguj/zrezygnuj <br>
        <a href="/LogowanieDoBiblioteki/index.jsp">Wracaj</a>        
</body>
</html>