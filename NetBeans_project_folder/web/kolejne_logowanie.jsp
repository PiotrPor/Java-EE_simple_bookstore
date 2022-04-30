<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body bgcolor="#ffee00">
       <h2>
           Zaloguj sie <font color="#ff0800">jeszcze raz</font>
       </h2>
        <%
          int LL;
          //trzeba rzutowac do 'Integer' zamiast 'int' bo atrybuty sesji sa typu 'Object' (?)
          LL = (Integer)session.getAttribute("ilosc_logowan");
          LL += 1;
          session.setAttribute("ilosc_logowan", LL);
           //session.setAttribute("ilosc_logowan", (int)1);
          //session.setAttribute("czy_zalogowany", (Boolean)false);
        %>
        Proba numer <%= LL%> <br>
         <form method="post" action="decyzyjny.jsp">
         Login <input type="text" name="wpisany_username"> <br>
         Password <input type="text" name="wpisane_haslo"> <br>
         <input type="submit" value="zaloguj">
        </form>
</body>
</html>