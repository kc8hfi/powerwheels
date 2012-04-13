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

import org.lwjgl.LWJGLException;
import org.lwjgl.opengl.Display;
import org.lwjgl.opengl.DisplayMode;
import org.lwjgl.input.Keyboard;
import org.lwjgl.input.Mouse;

public class Input
{
	private Commands command;
	private ServerConnection serverConnection;
	
	public Input (Commands c, ServerConnection sc)
	{
		command = c;
		serverConnection = sc;
	}
	
	public void start() 
	{
		try
		{
			Display.setDisplayMode(new DisplayMode(800,600));
			Display.setTitle("Control");
			Display.create();
		} 
		catch (LWJGLException e) 
		{
			e.printStackTrace();
			System.exit(0);
		}

		// init OpenGL here
		
		while (!Display.isCloseRequested()) 
		{
			
			// render OpenGL here
			pollInput();
			Display.update();
		}
		
		Display.destroy();
	}//end start
	
	public void pollInput()
	{
		if (Mouse.isButtonDown(0))
		{
			int x = Mouse.getX();
			int y = Mouse.getY();
			System.out.println("MOUSE DOWN @ X: " + x + " Y: " + y);
		}
		
		while (Keyboard.next())
		{
			if (Keyboard.getEventKeyState())
			{
				if (Keyboard.getEventKey() == Keyboard.KEY_A)
				{
					//System.out.println("a key pressed");
					//System.out.println("start turn left");
					serverConnection.send(command.start_vehicle_left());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_S)
				{
					//System.out.println("S Key Pressed");
					//System.out.println("start vehicle reverse");
					serverConnection.send(command.start_vehicle_reverse());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_D)
				{
					//System.out.println("D Key Pressed");
					//System.out.println("start turn right");
					serverConnection.send(command.start_vehicle_right());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_W)
				{
					//System.out.println("W Key Pressed");
					//System.out.println("start vehicle forward");
					serverConnection.send(command.start_vehicle_forward());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_I)
				{
					//System.out.println("move turret up");
					serverConnection.send(command.move_turret_up());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_J)
				{
					//System.out.println("move turret left");
					serverConnection.send(command.move_turret_left());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_K)
				{
					//System.out.println("move turret down");
					serverConnection.send(command.move_turret_down());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_L)
				{
					//System.out.println("move turret right");
					serverConnection.send(command.move_turret_right());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_SPACE)
				{
					//System.out.println("start firing");
					serverConnection.send(command.start_fire());
				}
			}//end key down
			else
			{
				if (Keyboard.getEventKey() == Keyboard.KEY_A)
				{
					//System.out.println("A Key Released");
					//System.out.println("stop vehicle left");
					serverConnection.send(command.stop_vehicle_left());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_S)
				{
					//System.out.println("S Key Released");
					//System.out.println("stop vehicle backward");
					serverConnection.send(command.stop_vehicle_reverse());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_D)
				{
					//System.out.println("D Key Released");
					//System.out.println("stop vehicle right");
					serverConnection.send(command.stop_vehicle_right());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_W)
				{
					//System.out.println("W Key Released");
					//System.out.println("stop vehicle forward");
					serverConnection.send(command.stop_vehicle_forward());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_I)
				{
					//System.out.println("stop turret up");
					serverConnection.send(command.stop_turret_up());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_J)
				{
					//System.out.println("stop turret left");
					serverConnection.send(command.stop_turret_left());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_K)
				{
					//System.out.println("stop turret down");
					serverConnection.send(command.stop_turret_down());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_L)
				{
					//System.out.println("stop turret right");
					serverConnection.send(command.stop_turret_right());
				}
				if (Keyboard.getEventKey() == Keyboard.KEY_SPACE)
				{
					//System.out.println("stop firing");
					serverConnection.send(command.stop_fire());
				}
			}//end key up
		}//end keyboard loop
	}//end pollInput
}//end class 
