package cn.iselab.restopicer.petwosclient.util;

import java.io.*;

/**
 * SimpleFileWriter is a small class to wrap around the usual File/PrintWriter
 * to shield you from the exception handling which we haven't yet gotten
 * to in class. 
 * <P>It has just four methods of note: one to open a new file for writing,
 * two to print or println a string to the file, and one to close the
 * the file when done. To keep it small, it does not have all the overloaded 
 * versions of print/println to accept all types, just convert to string first,
 * and then use the string-only print methods.
 * <P>Here is a simple example that shows using the SimpleFileWriter
 * to create a new file and write some text into it:
 * <PRE>
 *    SimpleFileWriter writer = SimpleFileWriter.openFileForWriting("output.txt");
 *    if (writer == null) {
 *       System.out.println("Couldn't open file!");
 *       return;
 *    }
 *    writer.print("Here is some text!");
 *    writer.println(" The year is " + 1999 + " and I feel fine.");
 *    writer.close();
 * </PRE>
 * <P>You are free to edit or extend this class, but we don't expect that
 * you should need to make any changes.
 *
 *
 */

public class SimpleFileWriter 
{
   /**
	 * Opens a new file for writing. The filename can either be a relative
	 * path, which will be relative to the working directory of the program
	 * when started, or an absolute path. If the file can be created, a
	 * a new SimpleFileWriter is returned. If the file already exists, this
	 * will overwrite its contents. If the file cannot be
	 * opened (for any reason: wrong name, wrong path, lack of permissions, etc.)
	 * null is returned.
	 */

	public static SimpleFileWriter openFileForWriting(String filename)
	{
		try {
			return new SimpleFileWriter(new PrintWriter(new FileWriter(filename), true));
		} catch(IOException e) {	
			return null;
		}	
	}	
	
   /**
	 * Appends a string to the end of the file without adding any
	 * trailing new line. 
	 */
	public void print(String s)
	{
		writer.print(s);
	}

   /**
	 * Appends a string to the end of the file and adds a
	 * trailing new line. 
	 */
	public void println(String s)
	{
		writer.println(s);
	}
	
	
	/**
	 * Closes the file when done writer.  You should close a writer when
	 * you are finished to flush its contents to disk and release the OS 
	 * resources for use by others.
	 */
	public void close()
	{
		writer.close();
	}
	
	/**
	 * Constructor is private so that only means to create a new writer
	 * is through the static method which does error checking.
	 */
	private SimpleFileWriter(PrintWriter writer) 
	{
		this.writer = writer;
	}
	
	private PrintWriter writer;

}