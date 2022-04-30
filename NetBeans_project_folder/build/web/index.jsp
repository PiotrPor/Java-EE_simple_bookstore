<%-- 
    Document   : index
    Created on : Dec 27, 2021, 6:57:16 PM
    Author     : Emperor_of_Virtuals
--%>
<%-- Projekt na zaliczenie bazodanowej Java EE --%>
<!--
  TODO:
  - decyzyjny.jsp nie rozpozna uzytkownikow zarejestrowanych przez admina
  DONE:
  - mozna przejsc ze strony uzytkownika przez sciezke wypozyczania
  - przy powrocie z wypozyczenia do strony uzytkownika nadal wiadomo kto jest zalogowany
  - admin uruchamia zapytania gotowymi przyciskami
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> strona logowania </title>
</head>
<body bgcolor="#a68a27">
        <h1>
            Zaloguj sie do <font color="#1b00ca"> Biblioteki </font> 
        </h1>
        <%
          session.setAttribute("ilosc_logowan", (int)1);
          session.setAttribute("czy_zalogowany", (Boolean)false);
          session.setAttribute("user_login", "a");
          session.setAttribute("user_password", "a");
        %>
        <form method="post" action="decyzyjny.jsp">
          Login <input type="text" name="wpisany_username"> <br>
          Password <input type="text" name="wpisane_haslo"> <br>
          <input type="submit" value="Log in">
        </form>
        <br>
        <img src="sterta_ksiazek.jpg" height="400" width="400" alt="Obrazek sterty ksiazek">
</body>
</html>