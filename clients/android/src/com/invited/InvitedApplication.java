package com.invited;

import android.provider.Settings.Secure;
import android.content.SharedPreferences;

import com.github.droidfu.DroidFuApplication;

public class InvitedApplication extends DroidFuApplication {
	public static final String SETTINGS_FILE = "InvitedAppSettings";
	public static final String PREFERENCE_FILE = "InvitedAppPreferences";
	
	public static String appToken = "5742a8d8cba21cd6a19acda585642c94";
}
