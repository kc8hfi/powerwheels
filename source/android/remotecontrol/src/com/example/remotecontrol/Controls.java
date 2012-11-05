package com.example.remotecontrol;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.content.Intent;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import android.view.MotionEvent;
import android.view.View.OnTouchListener;
import android.widget.ImageButton;
import android.widget.Button;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.util.Log;

public class Controls extends Activity implements Commands,OnTouchListener
{
	private ImageButton vehicle_forward_button;
	private ImageButton vehicle_reverse_button;
	private ImageButton vehicle_left_button;
	private ImageButton vehicle_right_button;
	
	private ImageButton turret_up_button;
	private ImageButton turret_down_button;
	private ImageButton turret_left_button;
	private ImageButton turret_right_button;
	
	private Button fire_button;
	
	private TextView status_msg;
	
	private String ip;
	private String port;

	private Socket socket;
	private PrintWriter out;
	
	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		
		//sets the layout
		setContentView(R.layout.controls);

		//get the stuff from the previous activity
		Intent intent = getIntent();
		
		ip = intent.getStringExtra(Connect.IP);
		port = intent.getStringExtra(Connect.PORT);

		try
		{
			socket = new Socket(ip,new Integer(port));
			out = new PrintWriter(socket.getOutputStream(),true);
		}
		catch (Exception e)
		{
			Toast.makeText(this, e.toString(),Toast.LENGTH_SHORT).show();
		}
		
		status_msg = (TextView) this.findViewById(R.id.status_msg);
		
		//get the buttons and add a listener
		vehicle_forward_button = (ImageButton) this.findViewById(R.id.vehicle_up_button);
		vehicle_forward_button.setOnTouchListener(this);
		
		vehicle_reverse_button = (ImageButton) this.findViewById(R.id.vehicle_reverse_button);
		vehicle_reverse_button.setOnTouchListener(this);
		
		vehicle_left_button = (ImageButton) this.findViewById(R.id.vehicle_left_button);
		vehicle_left_button.setOnTouchListener(this);
		
		vehicle_right_button = (ImageButton) this.findViewById(R.id.vehicle_right_button);
		vehicle_right_button.setOnTouchListener(this);
		
		turret_up_button = (ImageButton) this.findViewById(R.id.turret_up_button);
		turret_up_button.setOnTouchListener(this);
		
		turret_down_button = (ImageButton) this.findViewById(R.id.turret_down_button);
		turret_down_button.setOnTouchListener(this);
		
		turret_left_button = (ImageButton) this.findViewById(R.id.turret_left_button);
		turret_left_button.setOnTouchListener(this);		
		
		turret_right_button = (ImageButton) this.findViewById(R.id.turret_right_button);
		turret_right_button.setOnTouchListener(this);
		
		fire_button = (Button) this.findViewById(R.id.fire_button);
		fire_button.setOnTouchListener(this);
		
		//set the status message with the ip and the port
		status_msg.setText(ip+":"+port);
	}
	
	public void onPause()
	{
		super.onPause();
		Log.d("pause","paused");
		//we need to stop everything!!
		stop_vehicle_forward();
		stop_vehicle_reverse();
		stop_vehicle_left();
		stop_vehicle_right();
				
		stop_turret_left();
		stop_turret_right();
		stop_turret_up();
		stop_turret_down();
		
		stop_fire();
		
		//end the activity
		Log.d("pause","calling finish now");
		finish();
	}//end onPause
	
	public void onDestroy()
	{
		super.onDestroy();
		try
		{
			Log.d("controls","destroy");
			if (!socket.isClosed())
			{
				Log.d("controls","closing socket");
				socket.close();
			}
		}
		catch(Exception e)
		{
			Log.d("controls",e.toString());
		}
	}
	
	public boolean onTouch(View v, MotionEvent event) 
	{
		if (vehicle_forward_button.getId() == v.getId())
		{
			if (event.getAction() == MotionEvent.ACTION_DOWN)
			{
				start_vehicle_forward();
			}
			if (event.getAction() == MotionEvent.ACTION_UP)
			{
				stop_vehicle_forward();
			}
		}
		if (vehicle_reverse_button.getId() == v.getId())
		{
			if (event.getAction() == MotionEvent.ACTION_DOWN)
			{
				start_vehicle_reverse();
			}
			if (event.getAction() == MotionEvent.ACTION_UP)
			{
				stop_vehicle_reverse();
			}
		}
		if (vehicle_left_button.getId() == v.getId())
		{
			if (event.getAction() == MotionEvent.ACTION_DOWN)
			{
				start_vehicle_left();
			}
			if (event.getAction() == MotionEvent.ACTION_UP)
			{
				stop_vehicle_left();
			}
		}
		if (vehicle_right_button.getId() == v.getId())
		{
			if (event.getAction() == MotionEvent.ACTION_DOWN)
			{
				start_vehicle_right();
			}
			if (event.getAction() == MotionEvent.ACTION_UP)
			{
				stop_vehicle_right();
			}
		}
		if (turret_up_button.getId() == v.getId())
		{
			if (event.getAction() == MotionEvent.ACTION_DOWN)
			{
				start_turret_up();
			}
			if (event.getAction() == MotionEvent.ACTION_UP)
			{
				stop_turret_up();
			}
		}
		if (turret_down_button.getId() == v.getId())
		{
			if (event.getAction() == MotionEvent.ACTION_DOWN)
			{
				start_turret_down();
			}
			if (event.getAction() == MotionEvent.ACTION_UP)
			{
				stop_turret_down();
			}
		}
		if (turret_left_button.getId() == v.getId())
		{
			if (event.getAction() == MotionEvent.ACTION_DOWN)
			{
				start_turret_left();
			}
			if (event.getAction() == MotionEvent.ACTION_UP)
			{
				stop_turret_left();
			}
		}
		if (turret_right_button.getId() == v.getId())
		{
			if (event.getAction() == MotionEvent.ACTION_DOWN)
			{
				start_turret_right();
			}
			if (event.getAction() == MotionEvent.ACTION_UP)
			{
				stop_turret_right();
			}
		}
		if (fire_button.getId() == v.getId())
		{
			if (event.getAction() == MotionEvent.ACTION_DOWN)
			{
				start_fire();
			}
			if (event.getAction() == MotionEvent.ACTION_UP)
			{
				stop_fire();
			}
		}
		return true;
	}//end onTouch

	private void start_vehicle_forward()
	{
// 		Toast.makeText(this,START_VEHICLE_FORWARD ,Toast.LENGTH_SHORT).show();
		if (out != null)
			out.println(START_VEHICLE_FORWARD);
	}
	
	private void stop_vehicle_forward()
	{
		if (out != null)
			out.println(STOP_VEHICLE_FORWARD);
	}
	
	private void start_vehicle_reverse()
	{
		if (out != null)
			out.println(START_VEHICLE_REVERSE);
	}
	
	private void stop_vehicle_reverse()
	{
		if (out != null)
			out.println(STOP_VEHICLE_REVERSE);
	}
    
	private void start_vehicle_left()
	{
		if (out != null)
			out.println(START_VEHICLE_LEFT);
	}
	
	private void stop_vehicle_left()
	{
		if (out != null)
			out.println(STOP_VEHICLE_LEFT);
	}

	private void start_vehicle_right()
	{
		if (out != null)
			out.println(START_VEHICLE_RIGHT);
	}

	private void stop_vehicle_right()
	{
		if (out != null)
			out.println(STOP_VEHICLE_RIGHT);
	}
	
	private void start_turret_up()
	{
		if (out != null)
			out.println(START_TURRET_UP);
	}
	
	private void stop_turret_up()
	{
		if (out != null)
			out.println(STOP_TURRET_UP);
	}
	
	private void start_turret_down()
	{
		if (out != null)
			out.println(START_TURRET_DOWN);
	}
	
	private void stop_turret_down()
	{
		if (out != null)
			out.println(STOP_TURRET_DOWN);
	}
	
	private void start_turret_left()
	{
		if (out != null)
			out.println(START_TURRET_LEFT);
	}
	
	private void stop_turret_left()
	{
		if (out != null)
			out.println(STOP_TURRET_LEFT);
	}
	
	private void start_turret_right()
	{
		if (out != null)
			out.println(START_TURRET_RIGHT);
	}
	
	private void stop_turret_right()
	{
		if (out != null)
			out.println(STOP_TURRET_RIGHT);
	}
	
	private void start_fire()
	{
		if (out != null)
			out.println(START_FIRE);
	}
	
	private void stop_fire()
	{
		if (out != null)
			out.println(STOP_FIRE);
	}

//these are a bunch of functions that were used for testing
// 	public void vehicle_forward(View view)
// 	{
// 		Toast.makeText(this,START_VEHICLE_FORWARD ,Toast.LENGTH_SHORT).show();
// 	}
// 	public void vehicle_backward(View view)
// 	{
// 		Toast.makeText(this, "vehicle backward",Toast.LENGTH_SHORT).show();
// 	}
// 	public void vehicle_left(View view)
// 	{
// 		Toast.makeText(this, "vehicle left",Toast.LENGTH_SHORT).show();
// 	}
// 	public void vehicle_right(View view)
// 	{
// 		Toast.makeText(this, "vehicle right",Toast.LENGTH_SHORT).show();
// 	}
// 	public void turret_up(View view)
// 	{
// 		Toast.makeText(this, "turret up",Toast.LENGTH_SHORT).show();
// 	}
// 	public void turret_down(View view)
// 	{
// 		Toast.makeText(this, "turret down",Toast.LENGTH_SHORT).show();
// 	}
// 	public void turret_left(View view)
// 	{
// 		Toast.makeText(this, "turret left",Toast.LENGTH_SHORT).show();
// 	}
// 	public void turret_right(View view)
// 	{
// 		Toast.makeText(this, "turret right",Toast.LENGTH_SHORT).show();
// 	}
// 	public void turret_fire(View view)
// 	{
// 		Toast.makeText(this, "turret fire",Toast.LENGTH_SHORT).show();
// 	}
	
	
}//end class Controls