

_Controls Controls = new _Controls();

public class _Controls{
	public _Controls(){
		SKETCH.registerMethod("draw", this);
	}

	boolean mouseDown = false;

	void mousePressed(){
		mouseDown = true;
	}

	void mouseReleased(){
		mouseDown = false;
	}

	void draw(){
		if(mouseDown){
			if(cPhrase!=null){
				AnimatedLetter al = cPhrase.getLetterAtPosition(previewWindow.getMouseX(), previewWindow.getMouseY());
			}
		}
	}

}