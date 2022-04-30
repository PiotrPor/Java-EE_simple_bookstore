/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package biblioteczne;

// @author UL0246828

public class Ksiazka {
	private String tytul;
	private String autor;
	private String wydawnictwo;
	private String ISBN;
	
	public Ksiazka()
	{
		tytul = "";
		autor = "";
		wydawnictwo = "";
		ISBN="";
	}
	
	public Ksiazka(String ttt, String aaa)
	{
		tytul = ttt;
		autor = aaa;
		wydawnictwo = "Bibliopol SA";
		ISBN = "978-3-16-148410-0";
	}
	
	//getter
	public String getTytul() {return tytul;}
	public String getAutor() {return autor;}
	
	//setter
	public void setTytul(String ttt)
	{
		tytul = ttt;
		return;
	}
	
	public void setAutor(String aaa)
	{
		autor = aaa;
		return;
	}
	
	//funkcja do wypisania wszystkiego
	public String wypisz()
	{
		String wszystko = "\""+ tytul +"\"; "+ autor +"; "+ wydawnictwo +"; " + ISBN +";";
		return wszystko;
	}

}