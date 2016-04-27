

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

	char[] supportedCharacters = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};

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

	public boolean characterSupported(char c){
		for(int k = 0;k<supportedCharacters.length; k++){
			if(supportedCharacters[k]==c)
				return true;
		}
		return false;
	}

	public String getImagePath(char c){
		return getImagePath(c, getDefaultDisplayIndex());
	}

	public String getErrorImagePath(){
		return getImagePath('a', getDefaultDisplayIndex());
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