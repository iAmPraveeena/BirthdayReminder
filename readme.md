# Birthday reminder
This test suite was created using Robot automation framework. The goal is to regress all the available features of the endpoint based on the requirements specified in the requirements.pdf. 

The required libraries are specified in the requirements.txt, the user should be able to install the requirements.txt easily.
### Approach:
- Tool and language: Robot Framework + Python

## Code Organisation
Code is created using Robot Framework and Python was used to automated the scenarios mentioned above. The test scripts are located in the Test suites directory organized according to the test types. 

```sh
BirthdayReminder
├── TestSuites
│ ├── Performance
│ │ └── locustFiles
│ │     └── perf.py
│ └── Regression
│     └── robots
│         ├── regressionResponceData.robot
│         ├── regressionResponceMetadata.robot
│         └── regressionResponceMethodValidator.robot
├── log.html
├── output.xml
├── report.html
└── requirement.txt
```
# Execution Instructions
Navigate to BirthdayReminder directory and run the following command to run the robot files
```sh
robot TestSuites/Regression/robots/
```
For a more detailed log run the below command
```sh
robot -L debug TestSuites/Regression/robots/
```
To run individual files run the below command (change the filenames accordingly)
```sh
robot TestSuites/Regression/robots/regressionResponceData.robot
```
Add-in: 
Performance tests, the script is very simple and straight forward and the same can be run in two different modes. 
On the Terminal, Navigate to the BirthdayReminder directory and run the below command.
```sh
#-u stands for the number of users and r stands for the rate at which the users are spawned additionaly the user can mention a -t variable which specifies the time to run. 
locust -f TestSuites/Performance/locustFiles/perf.py --loglevel DEBUG --headless -u 1 -r 1
```
If you prefer a more of a GUI approach you can run
```sh
locust -f TestSuites/Performance/locustFiles/perf.py
```
### Results samples
![Test Results](./log.html, "log.html")
### References
[Requirements](requirements.pdf)
