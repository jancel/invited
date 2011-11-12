package com.invited;

import org.apache.http.impl.client.AbstractHttpClient;
import org.apache.http.params.HttpParams;
import org.json.JSONObject;
import org.json.JSONTokener;
import android.content.Context;
import android.content.Intent;
import android.util.Base64;
import android.widget.Toast;

import com.github.droidfu.concurrent.BetterAsyncTask;
import com.github.droidfu.http.BetterHttp;
import com.github.droidfu.http.BetterHttpRequest;
import com.github.droidfu.http.BetterHttpResponse;

public class InvitedRegisterAsyncTask<String, Void, Boolean> extends BetterAsyncTask<String, Void, Boolean> {

	public InvitedRegisterAsyncTask(Context arg0) {
		super(arg0);
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void handleError(Context arg0, Exception arg1) {
		// TODO Auto-generated method stub
		
	}

	
	
	@Override
	protected Boolean doCheckedInBackground(Context context, String... params) throws Exception {
		
		BetterHttp.setupHttpClient();
		
		String cred= (String)Base64.encodeToString(("test: ").getBytes(), Base64.DEFAULT);
		BetterHttp.setDefaultHeader("User-Agent", "Android");
		BetterHttp.setDefaultHeader("Authorization", "Basic "+cred);
		AbstractHttpClient client =BetterHttp.getHttpClient();
		HttpParams hp =client.getParams();
		hp.setParameter("email", params[0]);
		hp.setParameter("terms", params[1]);
		hp.setParameter("device_id", params[2]);
		BetterHttpRequest post = BetterHttp.post("http://test:@jancel.doesntexist.com:3000/device_activation");
		BetterHttpResponse response= post.send();
		String s = (String)response.getResponseBodyAsString();
		
		JSONObject object = (JSONObject) new JSONTokener(response.getResponseBodyAsString()).nextValue();
		
		if(object.has("errors"))
			return (Boolean) java.lang.Boolean.FALSE;
		else
			return (Boolean) java.lang.Boolean.TRUE;			
		
    }

	@Override
	protected void after(Context arg0, Boolean arg1) {
		// TODO Auto-generated method stub
		Toast.makeText(arg0, "test", 10);
		if (arg1.equals(true))
		{
			Intent i = new Intent(arg0,InvitedActivity.class);
			arg0.startActivity(i);
		}
	}

}
