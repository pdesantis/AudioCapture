Radar #FB8885835

# AudioCapture

## Environment
Computer:
macOS 10.15.7 (19H15)
iMac (Retina 5K, 27-inch, 2019)

Headphones:
- Apple Airpods (2nd Generation)
- Bose QC35

## Setup

Friendly note - this sometimes outputs very LOUD static, so I recommend _not_ keeping your headphones fully over your ears as you test this :)

A simple example app to test this behavior is available here:
Download the sample repository: https://github.com/pdesantis/AudioCapture

1. Connect Airpods (or any Bluetooth headphones with a microphone) to your computer
2. Set them as the default input & output audio device. Keep them in A2DP mode (do _not_ activate the microphone). See attached screenshot, verifying that the output format is 2-channel, 32-bit Float, 48 kHz.
3. Play sound using any app
4. Start an AVCaptureSession with an AVCaptureDeviceInput connected to the Bluetooth microphone

Expected:
- The capture session starts
- Output audio is unaffected (except for a reasonable delay as the device switches from A2DP to HFP mode)

Actual:
- The system audio output (including audio from other apps!) goes silent or sometimes plays very loud static sound.
- System audio output remains broken even after stopping the AVCaptureSession & quitting the app. Audio is only restored when switching 

Other notes:
This does not happen if the device is already in HFP mode (see screenshot #2). in other words, if the microphone was activated by another app before the AVCaptureSession starts, audio output does not break when the capture session starts.

Workaround:
If you create a virtual aggregate device, add the Bluetooth headset to it, and then use the aggregate device as AVCaptureSession's AVCaptureDeviceInput, it works as expected. The Bluetooth device can be in either HFP or A2DP mode before starting the capture session.

Theory:
Perhaps the system is still sending audio in the 2-channel, 32-bit 48kHz format after the device switches to HFP mode?
