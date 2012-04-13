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


/*
 * define a bunch of constants for the commands 
 * that get sent to the server
 */

public class Commands
{
	static final String START_VEHICLE_FORWARD 	=	"BVF";
	static final String STOP_VEHICLE_FORWARD 	=	"EVF";
	static final String START_VEHICLE_REVERSE	=	"BVB";
	static final String STOP_VEHICLE_REVERSE	=	"EVB";
	static final String START_VEHICLE_LEFT		=	"BVL";
	static final String STOP_VEHICLE_LEFT		=	"EVL";
	static final String START_VEHICLE_RIGHT		=	"BVR";
	static final String STOP_VEHICLE_RIGHT		=	"EVR";

	static final String START_TURRET_LEFT		=	"BTL";
	static final String STOP_TURRET_LEFT		=	"ETL";
	static final String START_TURRET_RIGHT		=	"BTR";
	static final String STOP_TURRET_RIGHT		=	"ETR";
	static final String START_TURRET_UP		=	"BTU";
	static final String STOP_TURRET_UP			=	"ETU";
	static final String START_TURRET_DOWN		=	"BTD";
	static final String STOP_TURRET_DOWN		=	"ETD";

	static final String START_FIRE			=	"SF";
	static final String STOP_FIRE				=	"EF";

	public Commands ()
	{
	}
	
	public String start_vehicle_forward()
	{
		//System.out.println("send: " + START_VEHICLE_FORWARD);
		return START_VEHICLE_FORWARD;
	}
	public String stop_vehicle_forward()
	{
		//System.out.println("send: " + STOP_VEHICLE_FORWARD);
		return STOP_VEHICLE_FORWARD;
	}
	public String start_vehicle_reverse()
	{
		//System.out.println("send:  " + START_VEHICLE_REVERSE);
		return START_VEHICLE_REVERSE;
	}
	public String stop_vehicle_reverse()
	{
		//System.out.println("send: " + STOP_VEHICLE_REVERSE);
		return STOP_VEHICLE_REVERSE;
	}
	public String start_vehicle_left()
	{
		//System.out.println("send: " + START_VEHICLE_LEFT);
		return START_VEHICLE_LEFT;
	}
	public String stop_vehicle_left()
	{
		//System.out.println("send: " + STOP_VEHICLE_LEFT);
		return STOP_VEHICLE_LEFT;
	}
	public String start_vehicle_right()
	{
		//System.out.println("send: " + START_VEHICLE_RIGHT);
		return START_VEHICLE_RIGHT;
	}
	public String stop_vehicle_right()
	{
		//System.out.println("send: " + STOP_VEHICLE_RIGHT);
		return STOP_VEHICLE_RIGHT;
	}
	public String move_turret_up()
	{
		return START_TURRET_UP;
	}
	public String move_turret_left()
	{
		return START_TURRET_LEFT;
	}
	public String move_turret_down()
	{
		return START_TURRET_DOWN;
	}
	public String move_turret_right()
	{
		return START_TURRET_RIGHT;
	}
	public String stop_turret_up()
	{
		return STOP_TURRET_UP;
	}
	public String stop_turret_left()
	{
		return STOP_TURRET_LEFT;
	}
	public String stop_turret_down()
	{
		return STOP_TURRET_DOWN;
	}
	public String stop_turret_right()
	{
		return STOP_TURRET_RIGHT;
	}
	public String start_fire()
	{
		return START_FIRE;
	}
	public String stop_fire()
	{
		return STOP_FIRE;
	}
	
}//end commands
