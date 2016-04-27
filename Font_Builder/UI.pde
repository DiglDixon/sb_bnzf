
ControlP5 cp5;

_UI UI = new _UI();

PreviewWindow previewWindow;

void constructUI(){
	// CP5
    cp5 = new ControlP5(this);
    defaultFont = createFont("SerranoPro-Light", 30);
    cp5.addTextfield("input")
        .setCaptionLabel(" ")
        .setPosition(50, height-60)
        .setSize(width-100, 50)
        .setColorCursor(255)
        .setColorBackground(color(0)) // Background colour
        .setColorForeground(color(0, 0)) // This is the border
        .setColorActive(color(255, 0)) // Border colour when highlighted
        .setColor(255) // Text colour
        .setFont(defaultFont)
        .setFocus(true)
        ;
}

void displayUI(){
	// Debugging
	fill(0);
	textSize(15);
	text(nf(frameRate, 2, 1)+" fps", 10, 30);
	if(frameRate < 25){
		fill(200, 0, 0);
		text("NOT REAL TIME", 10, 50);	
	}
}


class _UI{
	public _UI(){}

	public void displayLoadWheel(String s){
		noStroke();
		fill(255, 150, 150);
		ellipse(50+cos(frameCount*0.1)*10, 50+sin(frameCount*0.1)*10, 10, 10);
		fill(0);
		text(s, 70, 60);
	}

	public void displayLoadWheel(){
		displayLoadWheel("");
	}
}





//