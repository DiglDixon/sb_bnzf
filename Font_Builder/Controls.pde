

_Controls Controls = new _Controls();

public class _Controls{

	public boolean controlDown = false;
	public boolean mouseDown = false;

	public _Controls(){
		SKETCH.registerMethod("draw", this);
	}


	void mousePressed(){
		mouseDown = true;
	}

	void mouseReleased(){
		mouseDown = false;
	}

	void controlPressed(){
		println("Control down");
		controlDown = true;
	}

	void controlReleased(){
		println("Control up");
		controlDown = false;
	}

	void draw(){
		if(mouseDown){
			if(cPhrase!=null){
				AnimatedLetter al = cPhrase.getLetterAtPosition(previewWindow.getMouseX(), previewWindow.getMouseY());
			}
		}
	}

}