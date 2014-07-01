package cn.iselab.restopicer.petwosclient;

/**
 * Main App!
 * Examples!
 * @author Joshua ZHANG
 */
public class App 
{
    public static void main( String[] args )
    {
    	WOSClientPet pet = new WOSClientPet();
    	pet.apply_session_identifier()
    	   .setUserQuery("SO=Synthetic Metals")
    	   .addEdition("WOS", "SCI")
    	   .setTimeSpan("2013-01-01", "2014-01-01")
    	   .setMaxcountofeach(10)
    	   .task_process()
    	   .remove_session_identifier();
    }
}