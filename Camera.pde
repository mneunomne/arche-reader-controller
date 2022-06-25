public class Camera {
  Capture video;
  PApplet parent;
  
  int captureSize = 2;
  int capturePosX, capturePosY;
  int w,h;

  Camera(PApplet _parent) {
    // null
    parent = _parent;
  }
  
  void init() {
    String[] cameras = Capture.list();
    if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      exit();
    } else {
      println("Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        println(cameras[i]);
      }
      // The camera can be initialized directly using an 
      // element from the array returned by list():
      video = new Capture(parent, cameras[0]);
      video.start();
    }

    w = video.width;
    h = video.height;

    println("video size", w, h);
    
    capturePosX = w/2-captureSize/2;
    capturePosY = h/2-captureSize/2;
  }


  void display() {
    image(video, 0, 0, width, height);
    stroke(255, 0, 0);
    noFill();
    rect((float(capturePosX)/w)*width, (float(capturePosY)/h)*height, (float(captureSize)/w)*width, (float(captureSize)/w)*width); 
  }

  int getCenterValue () {
    float sum = 0;
    video.loadPixels();
    for(int y = capturePosY; y < capturePosY+captureSize; y++) {
      for(int x = capturePosX; x < capturePosX+captureSize; x++) {
        int i = x+y*w;
        float b = red(video.pixels[i]);
        sum+=b;
      }  
    }
    int average = floor(sum/(captureSize*captureSize));
    return average;
  }

  int [] getCenterMatrix () {
    int interval = 10;
    int [] matrix = new int[9];
    for(int y = capturePosY; y < capturePosY+captureSize; y++) {
      for(int x = capturePosX; x < capturePosX+captureSize; x++) {
        for (int i = 0; i < matrix.length; i++) {
          int index = x+y*w;
          float b = red(video.pixels[index]);
        }
      }  
    }
    return matrix;
  }
}
