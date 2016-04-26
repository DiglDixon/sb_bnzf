
public class PreviewWindow{

	Bounds viewBounds;
	PGraphics canvas;
	// ArrayList backgroundElements = new ArrayList<DisplayElement>();
	// ArrayList midgroundElements = new ArrayList<DisplayElement>();
	// ArrayList foregroundElements = new ArrayList<DisplayElement>();

	public PreviewWindow(Bounds viewBounds){
		this.viewBounds = viewBounds;
		canvas = createGraphics((int)viewBounds.w, (int)viewBounds.h);
	}

	public void pushTransform(){
		pushMatrix();
		translate(viewBounds.x, viewBounds.y);
	}

	public void popTransform(){
		popMatrix();
	}

	public float getMouseX(){
		return mouseX - viewBounds.x;
	}

	public float getMouseY(){
		return mouseY - viewBounds.y;
	}

	public void clear(){
		canvas.beginDraw();
		canvas.clear();
		canvas.endDraw();
	}

	public void drawBorder(){
		pushTransform();
		strokeWeight(1);
		stroke(0);
		noFill();
		rect(0, 0, viewBounds.w, viewBounds.h);
		popTransform();
	}

	// public void addBackgroundElement(DisplayElement de){
	// 	backgroundElements.add(de);
	// }
	// public void addMidgroundElement(DisplayElement de){
	// 	midgroundElements.add(de);
	// }
	// public void addForegroundElement(DisplayElement de){
	// 	foregroundElements.add(de);
	// }

	// Currently forwarded, not registered.
	// public void draw(){
	// 	canvas.beginDraw();
	// 	canvas.clear();
	// 	canvas.endDraw();
	// 	drawElements(backgroundElements);

	// 	drawElements(midgroundElements);

	// 	drawElements(foregroundElements);

	// 	image(canvas, viewBounds.x, viewBounds.y);
	// }

	// public void drawElements(ArrayList list){
	// 	DisplayElement de;
	// 	for(int k = 0; k<list.size(); k++){
	// 		de = (DisplayElement) list.get(k);
	// 		de.display(canvas);
	// 	}
	// }






}