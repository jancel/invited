package com.invited;

import com.github.droidfu.activities.BetterDefaultActivity;
import com.github.droidfu.concurrent.BetterAsyncTask;

import android.app.Activity;
import android.content.Context;
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

public class RegisterActivity extends BetterDefaultActivity implements OnClickListener 
{
	private String androidId;
	public String[] values;
	
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
        
        t = (EditText)findViewById(R.id.reg_fullname);
        values[0] = t.getText().toString();
        
        t = (EditText)findViewById(R.id.reg_email);
        values[1] = t.getText().toString();
        
        c = (CheckBox)findViewById(R.id.acceptTOS);
        values[2] = new java.lang.Boolean(c.isChecked()).toString();
        
        values[3] = androidId;
	        
	    InvitedRegisterAsyncTask<String, Void, Boolean> task = new InvitedRegisterAsyncTask<String, Void, Boolean>(getApplicationContext());
	    task.disableDialog();
	    task.execute(values[1],values[2],values[3]);
	    
		
		
	}
	
}
