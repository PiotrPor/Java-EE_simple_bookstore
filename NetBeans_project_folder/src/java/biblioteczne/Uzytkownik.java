/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package biblioteczne;

/**
 * @author UL0246828
 */
public class Uzytkownik {
      private String Nazwa;
      private String Haslo;
      private String ImieNazwisko;
      
      //konstruktor bezparametrowy
      public Uzytkownik()
      {
    	  Nazwa = "";
    	  Haslo = "";
      }
      //konstruktor parametrowy
      public Uzytkownik(String aaa, String bbb, String ccc)
      {
    	  Nazwa = aaa;
    	  Haslo = bbb;
    	  ImieNazwisko = ccc;
      }
      
      //getter'y
      public String getNazwa() {return Nazwa;}
      public String getHaslo() {return Haslo;}
      public String getIN() {return ImieNazwisko;}
      
      //setter'y
      public void setNazwa(String abc)
      {
    	  Nazwa = abc;
    	  return;
      }
      
      public void setHaslo(String abc)
      {
    	  Haslo = abc;
    	  return;
      }
      
      public void setDaneOsobowe(String abc)
      {
    	  ImieNazwisko = abc;
    	  return;
      }
}
