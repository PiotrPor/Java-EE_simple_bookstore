<%-- 
    Document   : formularz_nowego_uzytkownika
    Created on : Feb 4, 2022, 9:20:12 AM
    Author     : Emperor_of_Virtuals
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Wpisz dane nowego uzytkownika</h2>
        <form method="post" action="SerwletDodawania">
          Login <input type="text" name="login_nowego"> <br>
          Password <input type="text" name="haslo_nowego"> <br>
          Imie <input type="text" name="imie_nowego"> <br>
          Nazwisko <input type="text" name="nazwisko_nowego"> <br>
          <input type="submit" value="Dodaj">
        </form>
    </body>
</html>
