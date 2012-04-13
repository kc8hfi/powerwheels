package vehicle.remotecontrol;

import java.net.Socket;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class Connection extends Activity implements OnClickListener
{
	private Button b;
	private EditText ip_part1;
	private EditText ip_part2;
	private EditText ip_part3;
	private EditText ip_part4;
	private EditText port;
	/** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.connection);
        
        b = (Button)findViewById(R.id.button1);
        b.setOnClickListener(this);
        
        ip_part1 = (EditText)findViewById(R.id.ip_part1);
        ip_part2 = (EditText)findViewById(R.id.ip_part2);
        ip_part3 = (EditText)findViewById(R.id.ip_part3);
        ip_part4 = (EditText)findViewById(R.id.ip_part4);
        port = (EditText)findViewById(R.id.port);
        
        
//        Intent i = getIntent();
//        Bundle b = i.getExtras();
//        String newtext = b.getString("ARRIVING_FROM");
//        
//        TextView title = (TextView)findViewById(R.id.textView1);
//        title.setText("coming from " + newtext);
        
    }
    
    public void onClick(View v)
    {
    	String ip = "";
    	ip = ip + ip_part1.getText().toString() + ".";
    	ip = ip + ip_part2.getText().toString() + ".";
    	ip = ip + ip_part3.getText().toString() + ".";
    	ip = ip + ip_part4.getText().toString();
    	
    	//try the connection to make sure the ip and port are good
		try {
			Socket socket = new Socket(ip,new Integer(port.getText().toString()));
			//disconnect now
			socket.close();
			Intent i = new Intent();
			i.setClassName("vehicle.remotecontrol","vehicle.remotecontrol.RemoteControl");
	        //i.putExtra("ARRIVING_FROM", "connection");
	        i.putExtra("IP",ip);
	        i.putExtra("PORT",port.getText().toString());
	        startActivity(i);
		}
		catch (Exception e)
		{
			String m = e.getMessage() + " Please check the ip and port and try again.";
			Toast.makeText(this, m, Toast.LENGTH_LONG).show();
		}
    }//end onClick
}


