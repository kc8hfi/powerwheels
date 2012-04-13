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

import java.net.Socket;
import java.net.InetAddress;
import java.io.IOException;
import java.io.PrintWriter;

public class ServerConnection
{
	public ServerConnection()
	{
		socket = new Socket();
	}
	
	public boolean connect(String ip,String port)
	{
		boolean success = false;
		try 
		{
			System.out.println("ip address: " + ip + "\nport:" + port);
			socket = new Socket(InetAddress.getByName(ip),Integer.parseInt(port));
			out = new PrintWriter(socket.getOutputStream(), true);
			success = true;
		}
		catch(IOException e)
		{
			System.out.println(e);
			success = false;
		}
		return success;
	}//end connect
	
	public void send(String s)
	{
		if (socket.isConnected())
		{
			System.out.println("send: " + s);
			out.println(s);
		}
	}
	
	public boolean isConnected()
	{
		return socket.isConnected();
	}
	
	public void close()
	{
		try
		{
			socket.close();
		}
		catch(IOException e)
		{
			System.out.println(e);
		}
	}//end close
	
	private Socket socket;
	private PrintWriter out;
}//end connection