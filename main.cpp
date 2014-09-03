#include <iostream>
#include <cstdint>

#include <cvd/image_io.h>
#include <cvd/gl_helpers.h>
#include <cvd/videodisplay.h>
#include <cvd/glwindow.h>

using namespace std;
using namespace CVD;

int main() {
    Image<Rgb<uint8_t>> img = img_load("testimg.jpg");
    ImageRef size = img.size();

    ImageRef p(0,0);

    Rgb<uint8_t> targetColour(177,12,12);
    uint16_t distanceThreshold = 40;


    bool in_block = false;
    ImageRef block_start;
    ImageRef block_end;
    do {
        Rgb<uint8_t> pixel = img[p];
        uint16_t distance = 0;
        distance += abs((int16_t)targetColour.red - pixel.red);
        distance += abs((int16_t)targetColour.green - pixel.green);
        distance += abs((int16_t)targetColour.blue - pixel.blue);

        if (distance < distanceThreshold) { // close to target
            img[p] = targetColour;
            if (in_block) {

            } else {
                 in_block = true;
                 block_start = p;
            }
            //cout << "distance of " << distance << " at " << p.x << "," << p.y << endl;
        } else { // not the right colour
            img[p] = Rgb<uint8_t>(0,0,0);
            if (in_block) {
                in_block = false;
                block_end = p;
            } else {

            }
            //cout << "   distance of " << distance;
        }

    } while (p.next(size));


    GLWindow w = GLWindow(size);

    while (1) {
        glDrawPixels(img);
        w.swap_buffers();
    }

    return 0;
}

