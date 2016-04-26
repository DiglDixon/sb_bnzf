

public class FontAnimationStyle{

	PFont font;
	String animationName;
	String nativeFontName;
	int nativeFontMatchSize;
	int animationFrameCount = 30;
	int animationFramePadding = 2;
	int imageHeight = 600;
	int imageWidth = 600;
	int letterOriginInImage = 216;
	int letterBaselineInImage = 388;

	public FontAnimationStyle(String animationName, String fontName, int matchSize){
		this.animationName = animationName;
		this.nativeFontName = fontName;
		this.nativeFontMatchSize = matchSize;
		this.font = createFont(nativeFontName, 30);
	}

	public int getDefaultDisplayIndex(){
		return animationFrameCount-1;
	}

	public String getImagePath(char c, int i){
		if(Character.isUpperCase(c)){
			return "./"+animationName+"/"+c+"_upper/"+c+nf(i, animationFramePadding)+".png";
		}else{
			return "./"+animationName+"/"+c+"/"+c+nf(i, animationFramePadding)+".png";
		}
	}

	public String getImagePath(char c){
		return getImagePath(c, getDefaultDisplayIndex());
	}

	public String getErrorImagePath(){
		return getImagePath('d', getDefaultDisplayIndex());
	}

	public float getPhraseWidth(String s){
		if(s.length()==0){
			return 0;
		}
		textFont(font);
		textSize(nativeFontMatchSize);
		return textWidth(s);
	}

	public float getCharWidth(char c){
		textFont(font);
		textSize(nativeFontMatchSize);
		return textWidth(c);
	}

	public float getLetterAscent(){
		textFont(font);
		textSize(nativeFontMatchSize);
		return textAscent();
	}

	public float getLetterDescent(){
		textFont(font);
		textSize(nativeFontMatchSize);
		return textDescent();
	}


}