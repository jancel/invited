package com.invited;

public class InvitedEvents {
	public String name;
	public String location;
	public String finish;
	public String created_at;
	public String updated_at;
	public String id;
	public String user_id;
	public String start;
	public String disabled;
	public String description;
	
	public InvitedEvents(){
		
	}
	
	@Override
	public String toString()
	{
		return this.name;
	}
}
