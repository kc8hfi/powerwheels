package vehicle.remotecontrol;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnTouchListener;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.Toast;

public class RemoteControl extends Activity
implements OnTouchListener,Commands
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
	
	private String ip;
	private String port;
	
	private Socket socket;
	private PrintWriter out;
	
	//private Button next_button;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        vehicle_forward_button = (ImageButton) this.findViewById(R.id.vehicle_up_button);
        vehicle_forward_button.setOnTouchListener(this);
        
        vehicle_reverse_button = (ImageButton) this.findViewById(R.id.vehicle_reverse_button);
        vehicle_reverse_button.setOnTouchListener(this);
        
        vehicle_left_button = (ImageButton) this.findViewById(R.id.vehicle_left_button);
        vehicle_left_button.setOnTouchListener(this);
       
        vehicle_right_button = (ImageButton) this.findViewById(R.id.vehicle_right_button);
        vehicle_right_button.setOnTouchListener(this);
        
        turret_up_button = (ImageButton) this.findViewById(R.id.turret_up_button);
        turret_down_button = (ImageButton) this.findViewById(R.id.turret_down_button);
        turret_left_button = (ImageButton) this.findViewById(R.id.turret_left_button);
        turret_right_button = (ImageButton) this.findViewById(R.id.turret_right_button);
        
        turret_up_button.setOnTouchListener(this);
        turret_down_button.setOnTouchListener(this);
        turret_left_button.setOnTouchListener(this);
        turret_right_button.setOnTouchListener(this);
        
        fire_button = (Button) this.findViewById(R.id.fire_button);
        fire_button.setOnTouchListener(this);
        
		Intent i = getIntent();
		Bundle b = i.getExtras();
		
		ip = b.getString("IP");
		port = b.getString("PORT");
		
		try 
		{
			socket = new Socket(ip,new Integer(port));
			out = new PrintWriter(socket.getOutputStream(),true);
		}
		catch (Exception e)
		{
			Toast.makeText(this, e.toString(), Toast.LENGTH_LONG).show();
		}
    }//end onCreate
    
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
		
    }//end onPause
    
    /**
     * The back button on the phone breaks the socket connection just like before.
     * i believe the socket is still open,  because if you click the connect button,
     * the server never sees the connect request
     */
    /*
     * the firebutton motor controller needs to be tweaked
     */
    /*
     * servos for the turrent,  make them move while holding down
     * the button
     * 
     * how to use the accelerometer to make vehicle move
     * x-y coordinate plane to indicate how the phone is tilted
     * add a center button, to move accelerometer back to 0,0
     * and make it center when rotating phone from portrait to landscape
     * and back
     * 
     * space out the controls, fix the layout
     */
    
    public void onResume()
    {
    	super.onResume();
    	Log.d("resume","resumed");
    }//end onResume

    public void onBackPressed()
    {
    	Log.d("back","back button was pressed");

    	try 
    	{
			socket.close();
			Intent i = new Intent();
			i.setClassName("vehicle.remotecontrol","vehicle.remotecontrol.Connection");
	        //i.putExtra("ARRIVING_FROM", "connection");
//	        i.putExtra("IP",ip);
//	        i.putExtra("PORT",port.getText().toString());
	        startActivity(i);

		} 
    	catch (IOException e)
    	{
			// TODO Auto-generated catch block
   			Toast.makeText(this, e.toString(), Toast.LENGTH_LONG).show();
		}

    }
    
	@Override
	public boolean onTouch(View v, MotionEvent event) 
	{
		// TODO Auto-generated method stub
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
		return false;
	}//end onTouch
	
	private void start_vehicle_forward()
	{
		Log.d("vehicle", START_VEHICLE_FORWARD);
		out.println(START_VEHICLE_FORWARD);
	}
	
	private void stop_vehicle_forward()
	{
		Log.d("vehicle", STOP_VEHICLE_FORWARD);
		out.println(STOP_VEHICLE_FORWARD);
	}
	
	private void start_vehicle_reverse()
	{
		Log.d("vehicle",START_VEHICLE_REVERSE);
		out.println(START_VEHICLE_REVERSE);
	}
	
	private void stop_vehicle_reverse()
	{
		Log.d("vehicle",STOP_VEHICLE_REVERSE);
		out.println(STOP_VEHICLE_REVERSE);
	}
    
	private void start_vehicle_left()
	{
		Log.d("vehicle",START_VEHICLE_LEFT);
		out.println(START_VEHICLE_LEFT);
	}
	
	private void stop_vehicle_left()
	{
		Log.d("vehicle",STOP_VEHICLE_LEFT);
		out.println(STOP_VEHICLE_LEFT);
	}

	private void start_vehicle_right()
	{
		Log.d("vehicle",START_VEHICLE_RIGHT);
		out.println(START_VEHICLE_RIGHT);
	}

	private void stop_vehicle_right()
	{
		Log.d("vehicle",STOP_VEHICLE_RIGHT);
		out.println(STOP_VEHICLE_RIGHT);
	}
	
	private void start_turret_up()
	{
		Log.d("turret",START_TURRET_UP);
		out.println(START_TURRET_UP);
	}
	
	private void stop_turret_up()
	{
		Log.d("turret",STOP_TURRET_UP);
		out.println(STOP_TURRET_UP);
	}
	
	private void start_turret_down()
	{
		Log.d("turret",START_TURRET_DOWN);
		out.println(START_TURRET_DOWN);
	}
	
	private void stop_turret_down()
	{
		Log.d("turret",STOP_TURRET_DOWN);
		out.println(STOP_TURRET_DOWN);
	}
	
	private void start_turret_left()
	{
		Log.d("turret",START_TURRET_LEFT);
		out.println(START_TURRET_LEFT);
	}
	
	private void stop_turret_left()
	{
		Log.d("turret",STOP_TURRET_LEFT);
		out.println(STOP_TURRET_LEFT);
	}
	
	private void start_turret_right()
	{
		Log.d("turret",START_TURRET_RIGHT);
		out.println(START_TURRET_RIGHT);
	}
	
	private void stop_turret_right()
	{
		Log.d("turret",STOP_TURRET_RIGHT);
		out.println(STOP_TURRET_RIGHT);
	}
	
	private void start_fire()
	{
		Log.d("gun",START_FIRE);
		out.println(START_FIRE);
	}
	
	private void stop_fire()
	{
		Log.d("gun",STOP_FIRE);
		out.println(STOP_FIRE);
	}
	//	public void onTouch(View v, MotionEvent me)
//	{
//		//do something when up gets pressed
//		Log.d("something","up");
//		//v.onKeyDown(keyCode, event);
//	}

}//end RemoteControl class