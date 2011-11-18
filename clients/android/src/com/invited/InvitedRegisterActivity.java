package com.invited;

import java.util.concurrent.ExecutionException;

import org.json.JSONObject;

import com.github.droidfu.activities.BetterDefaultActivity;
import com.github.droidfu.concurrent.BetterAsyncTask;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.text.Editable;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CheckedTextView;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import android.provider.Settings.Secure;

public class InvitedRegisterActivity extends BetterDefaultActivity implements OnClickListener 
{
	private String androidId;
	public String[] values;

	private SharedPreferences data;
	private SharedPreferences.Editor dataEditor;

	
	
	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		setContentView(R.layout.register);
        super.onCreate(savedInstanceState);
        data = getApplicationContext().getSharedPreferences("data", getApplicationContext().MODE_PRIVATE);
     	androidId = Secure.getString(getApplicationContext().getContentResolver(),Secure.ANDROID_ID);
     
        Button b = (Button)findViewById(R.id.btnRegister);
        b.setOnClickListener(this);
        
	}

	//@Override
	public void onClick(View v) 
	{
		EditText t;
        CheckBox c;
        values = new String[4];
        
        values[0] = androidId;
        
        t = (EditText)findViewById(R.id.reg_email);
        values[1] = t.getText().toString();
        
        c = (CheckBox)findViewById(R.id.acceptTOS);
        values[2] = new java.lang.Boolean(c.isChecked()).toString();
        
        
        t = (EditText)findViewById(R.id.reg_fullname);
        values[3] = t.getText().toString();
        
            
	    InvitedAsyncTask task = new InvitedAsyncTask(getApplicationContext());
	    task.disableDialog();
	    task.execute(InvitedWebServiceURLs.registerUrl,"post",values[0],values[1],values[2]);
	    
	    try 
	    {
			JSONObject result = (JSONObject)task.get();
		
			if (result.has("user"))
			{
				JSONObject user = result.getJSONObject("user");
				dataEditor = data.edit();
				dataEditor.putBoolean("isRegistered", true);
				dataEditor.putString("appToken", user.getString("app_token"));
				dataEditor.putString("deviceId", androidId);
				dataEditor.commit();	
			}
			else
				Toast.makeText(getApplicationContext(), "There was an error", Toast.LENGTH_SHORT);
			
			
		
		} 
	    catch (Exception e) 
	    {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    
	    
	   
	    
	   
		
	}
	
}
