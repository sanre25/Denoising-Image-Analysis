import cv2
import os
import time

def show_image_with_opencv(file_path):
    try:
        img = cv2.imread(file_path)
        cv2.imshow("Image Viewer", img)
        cv2.waitKey(1000)  # Adjust the waitKey duration (in milliseconds) as needed
        #cv2.destroyAllWindows()
    except Exception as e:
        print(f"Error opening image with OpenCV: {e}")

if __name__ == '__main__':
   
    images_folder = os.path.dirname(os.path.abspath(__file__))  # Get the directory of this script

    # Open each file with OpenCV and create an animation
    for i in range(1, 26):  # Adjusted for 25 frames
        file_name = f"X2_iteration_{i}.png"
        file_path = os.path.join(images_folder, file_name)
        should_exit = show_image_with_opencv(file_path)
        if should_exit:
            break
