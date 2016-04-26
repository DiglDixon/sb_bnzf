

public class Bounds{
	public float x, y, w, h;
	public Bounds(){}
	public Bounds(float x, float y, float w, float h){
		this.x = x; this.y = y; this.w = w; this.h = h;
	}

	public boolean contains(float incomingX, float incomingY){
		return (x < incomingX && (x+w) > incomingX && y < incomingY && (y+h) > incomingY);
	}

	public void display(){
		rect(x, y, w, h);
	}

}