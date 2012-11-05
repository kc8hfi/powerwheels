package com.example.remotecontrol;

import java.net.Socket;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.content.Intent;
import android.widget.EditText;
import android.widget.Toast;

public class Connect extends Activity
{
	public final static String IP = "com.example.remotecontrol.IP";
	public final static String PORT = "com.example.remotecontrol.PORT";
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
    }
    
	/** called when the user clicks the connect button */
	public void connect(View view)
	{
		//do something now
		Intent intent = new Intent(this,Controls.class);
		EditText ip1 = (EditText) findViewById(R.id.ip_part1);
		EditText ip2 = (EditText) findViewById(R.id.ip_part2);
		EditText ip3 = (EditText) findViewById(R.id.ip_part3);
		EditText ip4 = (EditText) findViewById(R.id.ip_part4);
		EditText p = (EditText) findViewById(R.id.port);
		
		String ip_address = "";
		String port = "";
		
		ip_address = ip_address + ip1.getText().toString() + ".";
		ip_address = ip_address + ip2.getText().toString() + ".";
		ip_address = ip_address + ip3.getText().toString() + ".";
		ip_address = ip_address + ip4.getText().toString();

		port = p.getText().toString();
		
		try
		{
			Socket socket = new Socket(ip_address,new Integer(port));
			//disconnect now
			socket.close();
			intent.putExtra(IP,ip_address);
			intent.putExtra(PORT,port);
			startActivity(intent);
		}
		catch (Exception e)
		{
			//tell them to check the ip and port, then try again
			String m = "Please check the ip and port and try again.";
			Toast.makeText(this, m, Toast.LENGTH_LONG).show();

			//this is the error message if it can't connect
			//Toast.makeText(this, e.toString(),Toast.LENGTH_SHORT).show();
			
			//start the next activity anyway
			//startActivity(intent);
		}
	}
}
