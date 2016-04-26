

public class _RAMPreviewCacher{
	
	int animationFrame = 0;
	int animationFrameCount;
	AnimatedPhrase phrase;
	PGraphics previewGraphics;

	public _RAMPreviewCacher(){
		println(width);
		previewGraphics = createGraphics(width, height);
	}

	void cache(AnimatedPhrase ap){
		if(!ap.readyForPreviewCaching()){
			println("WARNING: AnimatedPhrase "+ap.style.animationName+" not ready for caching. Returning out.");
			return;
		}
		println("Preview cache begins...");
		phrase = ap;
		animationFrameCount = phrase.getPhraseAnimationFrameCount();
		animationFrame = 0;
		SKETCH.registerMethod("draw", this);
	}

	// We use this for drawing and saving our images
	void draw(){
		println("Caching preview "+animationFrame+"/"+animationFrameCount+"...");
		previewGraphics.beginDraw();
		previewGraphics.clear();
		previewGraphics.endDraw();
		phrase.setDisplayFrame(animationFrame);
		phrase.display(previewGraphics);
		previewGraphics.save(RAM_PREVIEW_PATH+"preview_"+animationFrame+".png");
		//
		animationFrame ++;
		UI.displayLoadWheel();
		if(animationFrame==animationFrameCount)
			completeCache();
	}

	void completeCache(){
		println("Preview cache complete!");
		SKETCH.unregisterMethod("draw", this);
	}

}