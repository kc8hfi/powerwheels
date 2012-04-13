/*
 * Copyright 2012
 * Charles Amey
 * 
This file is part of Remote.

Remote is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Remote is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Remote.  If not, see <http://www.gnu.org/licenses/>.
*/

import javax.swing.JFrame;

/*to compile:
 * javac -cp .:lwjgl-2.8.3/jar/lwjgl.jar  *.java
 * 
 * to run:
 * java -cp .:lwjgl-2.8.3/jar/lwjgl.jar  -Djava.library.path=lwjgl-2.8.3/native/linux/ MainWindow
 */

public class MainWindow
{
	public static void main(String[] argv)
	{
		Commands c = new Commands();
		ServerConnection sc = new ServerConnection();
		
		JFrame f = new JFrame();
		f.setTitle("Remote Control");
		f.setVisible(true);
		f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		ThePanel p = new ThePanel(c,sc);
		
		f.setContentPane(p);
		f.pack();
	
		
		Input displayExample = new Input(c,sc);
		displayExample.start();
	}//end main
}//end MainWindow class 