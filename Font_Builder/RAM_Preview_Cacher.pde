

public class _RAMPreviewCacher{
	
	int animationFrame = 0;
	int animationFrameCount;
	AnimatedPhrase phrase;
	PGraphics cacheGraphics;
	boolean underway;
	boolean autoPlay = true;

	public _RAMPreviewCacher(){
		println(width);
		cacheGraphics = createGraphics(width, height);
	}

	void cache(AnimatedPhrase ap){
		if(!ap.readyForPreviewCaching()){
			println("WARNING: AnimatedPhrase "+ap.style.animationName+" not ready for caching. Returning out.");
			return;
		}
		println("Preview cache begins...");
		phrase = ap;
		animationFrame = 0;
		phrase.resetAnimation();
		animationFrameCount = phrase.getPhraseAnimationFrameCount();
		underway = true;
		SKETCH.registerMethod("draw", this);
	}

	// We use this for drawing and saving our images
	void draw(){
		println("Caching preview "+animationFrame+"/"+animationFrameCount+"...");
		cacheGraphics.beginDraw();
		cacheGraphics.clear();
		cacheGraphics.endDraw();
		phrase.incrementAnimationFrame();
		phrase.display(cacheGraphics);
		cacheGraphics.save(RAM_PREVIEW_PATH+"preview_"+animationFrame+".png");
		//
		animationFrame ++;
		UI.displayLoadWheel("Caching RAM Preview...");
		if(animationFrame==animationFrameCount)
			completeCache();
	}

	void completeCache(){
		underway = false;
		println("Preview cache complete!");
		SKETCH.unregisterMethod("draw", this);
		if(autoPlay){
			RAMPreviewPlayer.setFrameOutputCount(animationFrameCount);
			RAMPreviewPlayer.beginCacheLoad();
		}
	}

}