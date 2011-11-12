package com.invited;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;

public class InvitedActivity extends Activity {
    /** Called when the activity is first created. */
	
	private SharedPreferences data;
	
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        Intent intent = new Intent(this,RegisterActivity.class);
  		data = this.getSharedPreferences("data", MODE_PRIVATE);
  		boolean firstRun=data.getBoolean("firstRun", true);
  		
  		if(firstRun)
  			startActivity(intent);
    }
}