This experiment involves using the JetBot cart to recognise 5 types of custom gestures and perform the corresponding actions. Through this assignment, we can learn how to configure a system image for the Nano, get familiar with how to use Jupyter Lab to remotely control the JetBot, collect datasets, mount a USB stick, and realise the function of recognising gestures and performing corresponding actions.

# Configuring the system image
The Jetson Nano is a computer for embedded designers, researchers, and DIY manufacturers that delivers 472GFLOPS of compute performance with a quad-core 64-bit ARM CPU and 128-core integrated NVIDIA GPU. It also includes 4GB of LPDDR4 memory in a high-efficiency, low-power package with 5W/10W power modes and a 5V DC input. Before we can officially use the Jetson Nano, we first need to configure a system image for it. The system image burned for this experiment is Jetbot_Udisk_20220219_64G.

The steps are as follows:

**STEP1** Formatting the USB stick

Install the software SDFormatter and use it to format the USB memory stick, the software interface is shown below:

![5c01c3ca92ad318b2ca200043676835](https://github.com/evexuxi/Intelligent-Tracking-Car-System-Project-Series/assets/122734805/4fbb46cc-8f15-4e00-9905-029e47a1c82b)

**STEP2** Burning the system image

Use the software Etcher to burn the pre-downloaded system image Jetbot_Udisk_20220219_64G. First download, install and start the Etcher utility, the software interface is shown below:

![fbb4b5d06dbfb89cbe33df5fda06528](https://github.com/evexuxi/Intelligent-Tracking-Car-System-Project-Series/assets/122734805/4df28484-1e86-42ad-add8-4a52606645ba)

Insert the USB stick into the computer, select the img file in the software, and then click "Flash!" to start burning the image (as shown in Figure a above). When the burning is finished, it will show "Flash Complete", as shown in Figure b above.

Note that after the burning is finished, you will see the USB flash drive divided into several partitions under Windows and you cannot click into them, this is normal, because the disc partitions under Linux are not visible under Windows. This is a normal phenomenon, because the disc partition under Linux is not visible under Windows.
The Jetson Nano has been successfully burned. After burning successfully, the system may prompt you to format the partition because the partition is not recognised, do not format it at this time! Click Cancel, then the USB flash drive will pop up, and finally insert the USB flash drive into the USB port of the Jetson Nano motherboard.
Click Cancel, and then the USB flash drive will pop up, finally insert the USB flash drive into the USB port of the Jetson Nano motherboard.

Insert the USB flash drive into the cart (you can't unplug it in this experiment), connect the mouse, keyboard, monitor and other peripherals, and then power on the cart, at this time, the cart's buzzer will sound until the end of the boot. After successful power-on, connect the cart to Wi-Fi, and the OLED screen will display the network address after successful connection.

Manually close the boot-up APP process to free up system resources.

![646fc43d1106f2f44cc3e2904c8dc6e](https://github.com/evexuxi/Intelligent-Tracking-Car-System-Project-Series/assets/122734805/ab2700ce-b6ea-4b6a-87e2-0eca37ee307c)

The serial servo uses the UART2 serial port 2TX, since the servo only receives data, we only use the The serial port UART_2_TX is mounted on the /dev/ttyTHS1 device on the JetbotUbuntu18.04 system, so to use the servo you need to enable the serial port privileges first. device on the JetbotUbuntu 18.04 system, so to use the servo you need to enable the serial port privileges first.

![536d9e1faf7f6a43cdd4c0657b9aa55](https://github.com/evexuxi/Intelligent-Tracking-Car-System-Project-Series/assets/122734805/76bac442-3558-4eb4-8c98-3837670df62f)

![058bea17caaad0fb76e89fa050d8981](https://github.com/evexuxi/Intelligent-Tracking-Car-System-Project-Series/assets/122734805/c351d387-e565-4f0a-8935-ee436e78a690)

At this point, the configuration of the trolley end is finished, and other peripherals plugged into the trolley, except for the USB stick, can now be removed.

:construction: **Collection of gesture datasets**

**STEP3** Using the Jupyter Lab platform to capture gesture datasets

Jupyter Lab (previously known as IPython notebook, Jupyter notebook) is an interactive Jupyter Lab (previously known as IPython notebook, Jupyter notebook) is an interactive notebook that runs more than 40 programming languages.
Jupter Lab is essentially an open source web application that facilitates the creation and sharing of literary program documentation, supporting real-time code, mathematical equations, visualisations and Markdown. We need to do this task on Jupyter Lab, so we just need to prepare a computer and connect it to JetBot.
So we only need to prepare a computer and connect it to the JetBot, and we don't need to connect any other peripheral devices other than USB sticks to the cart. First of all, our JetBot Firstly, our JetBot is connected to the same LAN as the PC network via Wi-Fi, and when logging in, we only need to input the IP address shown on the OLED screen of the JetBot into the browser.
When logging in, you just need to enter the IP address shown on the OLED screen of the JetBot in the browser, and then add: 8888. For example: http://192.168.1.11:8888.

Go to the Jupyter Lab interface and create a "Hand_recognition" folder directly in the interface, where all the code you need to run on jupyter will be saved. The code that needs to be run on jupyter will be stored here. First create a "data_collect.ipynb" file in this folder to collect all kinds of gesture images.

Requirements for dataset collection: Collect five different types of gesture images, the gesture types are named "stop", "left", "right", "forward", "forward" (can be customised, need not be exactly the same), gesture examples are shown in the figure below:

![b0acfbb4f041c08fea57918b8c48abd](https://github.com/evexuxi/Intelligent-Tracking-Car-System-Project-Series/assets/122734805/b29ca971-90c1-4da2-9918-33ef12ea75f2)

The specific implementation code can be found in the code file.

After you finish collecting pictures, compress the "dataset" file and then download the compressed file to your own computer.

**STEP4** Extracting key points on the hand with mediapipe

After collecting a sufficient number of hand gesture images, the we need to extract the key points of the hand in the images to generate the dataset required for model training. We use the mediapipe and opencv libraries to extract 21 3D keypoints of the hand.

The extracted hand keypoint dataset "data.csv" will be used to train the subsequent gesture recognition network.

:construction: **Training a gesture recognition network**

Using the obtained hand key point dataset "data.csv", we train our neural network model and save the weights when the model reaches the maximum accuracy of weights when the model reaches its highest accuracy.

:construction: **Gesture Recognition **

