package com.invited.mappings;

public class Event {
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
	
	public Event(){}
	
	@Override
	public String toString()
	{
		return this.name;
	}
}
