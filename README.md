# Well-BEEing

Our team, Up To Data's submission to HackUST 2021

This is only the front-end part of our submission. Please refer to https://github.com/AlexSze/hackust2021-wellbeeing-server for the server side

This repositry is a Flutter app for elderly use. This is a demo app that the elderly could sign up and login with their phone numbers. It shows the functionality of abnormal surrounding sound detection. We detects if there is a spike in the surrounding noise.
<br><br>
## How to use
1. Open the app.
1. Enter 8888 8888 (for testing purpose) for telephone number
1. Enter 123456 (for testing purpose) for OTP code
1. Press the button with our logo to start the detection
    - It means normal when the circle on the button remains white.
    - It means abnormal sound detected when the circle on the button turns red.

## Reference
- https://pub.dev/packages/noise_meter
- https://pub.dev/packages/permission_handler
- https://pub.dev/packages/firebase_core
- https://pub.dev/packages/firebase_auth