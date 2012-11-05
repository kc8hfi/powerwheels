package com.example.remotecontrol;

interface Commands 
{
	public static final String START_VEHICLE_FORWARD	= 	"BVF";
	public static final String STOP_VEHICLE_FORWARD 	= 	"EVF";
	public static final String START_VEHICLE_REVERSE	= 	"BVB";
	public static final String STOP_VEHICLE_REVERSE	=	"EVB";
	public static final String START_VEHICLE_LEFT	=	"BVL";
	public static final String STOP_VEHICLE_LEFT		= 	"EVL";
	public static final String START_VEHICLE_RIGHT	= 	"BVR";
	public static final String STOP_VEHICLE_RIGHT	= 	"EVR";

	public static final String START_TURRET_LEFT		=	"BTL";
	public static final String STOP_TURRET_LEFT		= 	"ETL";
	public static final String START_TURRET_RIGHT	=	"BTR";
	public static final String STOP_TURRET_RIGHT		=	"ETR";
	public static final String START_TURRET_UP		= 	"BTU";
	public static final String STOP_TURRET_UP		= 	"ETU";
	public static final String START_TURRET_DOWN		=	"BTD";
	public static final String STOP_TURRET_DOWN		= 	"ETD";

	public static final String START_FIRE		= "SF";
	public static final String STOP_FIRE		= "EF";

}