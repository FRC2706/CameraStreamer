package ca.team2706.streamer;

import edu.wpi.first.cameraserver.CameraServer;
import edu.wpi.first.networktables.NetworkTableInstance;

public class Streamer {
	
	public static void main(String[] args) {
		
		System.loadLibrary("opencv_java310");
		
		NetworkTableInstance instance = NetworkTableInstance.getDefault();
		instance.startClientTeam(2706);
		
		CameraServer.getInstance().startAutomaticCapture();
		
		while(true) {
			try {
				Thread.sleep(100000);
			}catch(Exception e) {
				
			}
		}
		
	}
	
}