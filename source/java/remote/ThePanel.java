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

import javax.swing.JPanel;
import javax.swing.JButton;
import javax.swing.JTextField;
import javax.swing.JLabel;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.*;
import javax.swing.*;

public class ThePanel extends JPanel implements ActionListener
{
	public ThePanel(Commands c, ServerConnection s)
	{
		cmd = c;
		sc = s;
		connectButton = new JButton("connect");
		connectButton.addActionListener(this);
		connectButton.setActionCommand("connect");
		
		JLabel ipLabel = new JLabel("IP Address");
		ip = new JTextField("157.182.180.79",15);

		JLabel portLabel = new JLabel("Port");
		port = new JTextField("4201");
		
		BorderLayout bl = new BorderLayout();
		bl.setVgap(10);
		setLayout(bl);
		
		JPanel pl = new JPanel();
		pl.setLayout(new GridLayout(2,2,10,10));
		pl.add(ipLabel);
		pl.add (portLabel);
		
		JPanel pt = new JPanel();
		pt.setLayout(new GridLayout(2,1,10,10));
		pt.add(ip);
		pt.add (port);
		
		JPanel pb = new JPanel();
		pb.setLayout(new BoxLayout(pb,BoxLayout.Y_AXIS));
		pb.add(connectButton);

		//panel for the page_start
		JPanel stuff = new JPanel();
		stuff.add(pl);
		stuff.add(pt);
		stuff.add(pb);
		
		add(stuff,BorderLayout.PAGE_START);
		
		//panel for the center
		JPanel center = new JPanel();
		center.setBorder(BorderFactory.createLineBorder(Color.black));
		center.setLayout(new BoxLayout(center,BoxLayout.Y_AXIS));
		String instructions = 	"1.  Type in the ip address of the server\n";
		center.add(new JLabel(instructions));
		instructions =		"2.  Click the connect button.\n";
		center.add(new JLabel(instructions));
		instructions =		"3.  click in the \"Control\" window to begin remote control.\n\n";
		center.add(new JLabel(instructions));
		instructions =		"The vehicle controls are on the left.\n";
		center.add(new JLabel(instructions));
		instructions =		"The turret and gun controls are on the right.";
		center.add(new JLabel(instructions));

		add(center,BorderLayout.CENTER);
		
		//panel for the page end part of the layout
		JPanel pageEnd = new JPanel();
		
		//panel for the vehicle control keys
		JPanel keys = new JPanel();
		keys.setBorder(BorderFactory.createLineBorder(Color.black));
		keys.setLayout(new GridLayout(5,2,20,0));
		keys.add(new JLabel("W",SwingConstants.CENTER));
		keys.add(new JLabel("Forward"));
		keys.add(new JLabel("S",SwingConstants.CENTER));
		keys.add(new JLabel("Backward"));
		keys.add(new JLabel("A",SwingConstants.CENTER));
		keys.add(new JLabel("Left"));
		keys.add(new JLabel("D",SwingConstants.CENTER));
		keys.add(new JLabel("Right"));
		keys.add(new JLabel (""));
		keys.add(new JLabel (""));
		add(keys,BorderLayout.LINE_START);

		//panel for the turret control keys
		JPanel tkeys = new JPanel();
		tkeys.setBorder(BorderFactory.createLineBorder(Color.black));
		tkeys.setLayout(new GridLayout(5,2,20,0));
		tkeys.add(new JLabel("I",SwingConstants.CENTER));
		tkeys.add(new JLabel("Turret up"));
		tkeys.add(new JLabel("K",SwingConstants.CENTER));
		tkeys.add(new JLabel("Turret down"));
		tkeys.add(new JLabel("J",SwingConstants.CENTER));
		tkeys.add(new JLabel("Turret left"));
		tkeys.add(new JLabel("L",SwingConstants.CENTER));
		tkeys.add(new JLabel("Turret Right"));
		tkeys.add(new JLabel("space",SwingConstants.CENTER));
		tkeys.add(new JLabel("Fire Gun"));
		
		//add the vehicle controls and the turret controls
		pageEnd.add(keys,BorderLayout.LINE_END);
		pageEnd.add(tkeys,BorderLayout.LINE_END);
		
		add(pageEnd,BorderLayout.PAGE_END);
		
	}//end constructor
	
	public void actionPerformed(ActionEvent evt)
	{
		if (evt.getActionCommand().equals("connect"))
		{
			System.out.println("connect to the server");
			sc.connect(ip.getText(),port.getText());
			
			if (sc.isConnected())
			{
				connectButton.setText("disconnect");
				connectButton.setActionCommand("disconnect");
			}
		}
		if (evt.getActionCommand().equals("disconnect"))
		{
			connectButton.setText("connect");
			connectButton.setActionCommand("connect");
			sc.close();
		}
	}//end actionPerformed
	
	private Commands cmd;
	private ServerConnection sc;
	
	private JButton connectButton;
	private JTextField ip;
	private JTextField port;
	
}//end ThePanel class
