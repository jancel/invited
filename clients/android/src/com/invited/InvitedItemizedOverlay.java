package com.invited;
import java.util.ArrayList;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.drawable.Drawable;

import com.google.android.maps.ItemizedOverlay;
import com.google.android.maps.OverlayItem;

public class InvitedItemizedOverlay extends ItemizedOverlay {
	
	private ArrayList<OverlayItem> mOverlays = new ArrayList<OverlayItem>();
	private Context mContext;

	public InvitedItemizedOverlay(Drawable defaultMarker) {
		super(boundCenterBottom(defaultMarker));
		// TODO Auto-generated constructor stub
	}
	
	public InvitedItemizedOverlay(Drawable defaultMarker, Context context) {
		  super(boundCenterBottom(defaultMarker));
		  mContext = context;
	}

	@Override
	protected OverlayItem createItem(int i) {
		
		return mOverlays.get(i);
		
	}

	@Override
	public int size() {
		// TODO Auto-generated method stub
		return mOverlays.size();
	}
	
	public void addOverlay(OverlayItem overlay) {
	    mOverlays.add(overlay);
	    populate();
	}

	public boolean removeItem(int position){
		Boolean worked = true;
		try {
			mOverlays.remove(position);
		}
		catch (Exception e){
			worked = false;
		}
		return worked;
	}
	
	@Override
	protected boolean onTap(int index) {
	  OverlayItem item = mOverlays.get(index);
	  AlertDialog.Builder dialog = new AlertDialog.Builder(mContext);
	  dialog.setTitle(item.getTitle());
	  dialog.setMessage(item.getSnippet());
	  
	  final Intent i = new Intent("PickLocation.Selected");
      i.putExtra("index", index);

      
	  dialog.setPositiveButton("Select location", new DialogInterface.OnClickListener() {
          public void onClick(DialogInterface dialog, int id) {
        	  //select location and send back to calling activity.
                            
              mContext.sendBroadcast(i);
         }
	  });
	  dialog.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
          public void onClick(DialogInterface dialog, int id) {
        	  //select location and send back to calling activity.
              dialog.cancel();
         }
	  });
	  dialog.show();
	  return true;
	}

	public void clear() {
		// TODO Auto-generated method stub
		mOverlays.clear();
	}

				

}

