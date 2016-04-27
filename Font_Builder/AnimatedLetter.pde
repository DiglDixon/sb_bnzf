// If this extended a null class, we'd need to override much less in children.
class AnimatedLetter{

	FontAnimationStyle style;
	private char myValue;
	PImage displayImage;
	LetterImageSet letterImages;

	float xPosition, yPosition;
	Bounds letterBounds = new Bounds();
	float kerning = 0;
	float letterWidth;
	int animationFrame;
	int animationStartFrame = 0;

	public AnimatedLetter(char v, FontAnimationStyle style){
		this.style = style;
		setValue(v);
	}

	private void setValue(char v){
		myValue = v;
		letterWidth = style.getCharWidth(myValue);
		initialiseLetterImages(myValue);
	}

	private void initialiseLetterImages(char v){
		if(v==' '){
			letterImages = new NullLetterImageSet(v, style);
		}else{
			letterImages = IMAGE_SETS.get(v);
		}
	}

	public char getValue(){
		return myValue;
	}	

	public void setPosition(float x, float y){
		xPosition = x;
		yPosition = y;
		updateLetterBounds();
	}

	public void updateLetterBounds(){
		float ascent = style.getLetterAscent();
		letterBounds.x = getDisplayPositionX() + style.letterOriginInImage;
		letterBounds.y = style.letterBaselineInImage - ascent;
		letterBounds.w = getWidth();
		letterBounds.h = ascent + style.getLetterDescent();
	}

	public boolean letterImagesLoading(){
		return letterImages.loadUnderway();
	}

	public boolean letterImagesLoaded(){
		return letterImages.hasLoaded();
	}

	public void forceImagesLoad(){
		letterImages.beginLoad();
	}

	public float getDisplayPositionX(){
		return xPosition + kerning;
	}

	public float getWidth(){
		return letterWidth;
	}

	public void setAnimationStartFrame(int i){
		animationStartFrame = i;
	}

	public void resetAnimation(){
		animationFrame = animationStartFrame;
	}

	public boolean canDisplay(){
		return (!isBlankSpace() && supportedAnimationFrame());
	}

	public boolean isBlankSpace(){
		return myValue == (' ');
	}

	public void setAnimationFrame(int f){
		animationFrame = f;
	}

	public boolean animationComplete(){
		return (animationFrame == style.animationFrameCount-1);
	}

	public void incrementAnimationFrame(){
		animationFrame = min(animationFrame + 1, style.animationFrameCount-1);
	}

	public boolean supportedAnimationFrame(){
		return (animationFrame >=0 && animationFrame <style.animationFrameCount);
	}

	public PImage getImage(){
		return letterImages.getFrame(animationFrame);
	}

	public PImage getFrameImage(int index){
		return letterImages.getFrame(index);
	}

}

// class AnimatedLetterSpace extends AnimatedLetter{
// 	public AnimatedLetterSpace(FontAnimationStyle style){
// 		super(' ', style);
// 	}

// 	public void setValue
// }

// class AnimatedLetterDuplicate extends AnimatedLetter{
// 	AnimatedLetter reference;

// 	public AnimatedLetterDuplicate(AnimatedLetter reference){
// 		super(reference.myValue, reference.style);
// 		this.reference = reference;
// 	}

// 	public PImage getImage(){
// 		return reference.getFrameImage(animationFrame);
// 	}

// 	public PImage getFrameImage(int frame){
// 		return reference.getFrameImage(frame);
// 	}
// }
