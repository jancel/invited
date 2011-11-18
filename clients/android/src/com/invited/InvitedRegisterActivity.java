package com.invited;

import org.json.JSONObject;

import com.github.droidfu.activities.BetterDefaultActivity;
import com.github.droidfu.concurrent.BetterAsyncTask;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CheckedTextView;
import android.widget.EditText;
import android.widget.TextView;
import android.provider.Settings.Secure;

public class InvitedRegisterActivity extends BetterDefaultActivity implements OnClickListener 
{
	private String androidId;
	public String[] values;
	public String appToken;
	
	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		setContentView(R.layout.register);
        super.onCreate(savedInstanceState);
        
        androidId = Secure.getString(getApplicationContext().getContentResolver(),Secure.ANDROID_ID);
        Button b = (Button)findViewById(R.id.btnRegister);
        b.setOnClickListener(this);
        
	}

	@Override
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
	    task.execute(InvitedWebServiceURLs.registerUrl,values[0],values[1],values[2]);
	
	   
	    
	    //grab session if registration worked
	    try
	    {
	    	InvitedAsyncTask createSessionTask=null;
		    if(task.get()!=null)
		    {
		    	createSessionTask = new InvitedAsyncTask(getApplicationContext());
			    createSessionTask.execute(InvitedWebServiceURLs.createSessionUrl,values[0],InvitedApplication.appToken);
		    }
		    
		    
		    if(createSessionTask.get()!=null)
		    {
		    	Intent i = new Intent(getApplicationContext(),InvitedActivity.class);
				//i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
				getApplicationContext().startActivity(i);
		    }
	    }
	    catch(Exception e)
	    {
	    	System.out.println(e.getStackTrace().toString());
	    	//nothing
	    }
	    	
	    	
	 
		
		
	}
	
}
