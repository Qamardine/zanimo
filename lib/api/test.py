#!/usr/bin/python3

User = "zanimo@ttn"
Password = "NNSXS.VUQ5HZXOL7BYE6OYG2PPKHSE7BHJLRWIWIVWNDY.2MF3HKQ7LPMIMXYNR6DRHUIPNMOLTFCZGYYSLSYRYLM732WJPAVQ"
theRegion = "EU1"		# The region you are using


import os, sys, logging, time

import paho.mqtt.client as mqtt
import json
import csv
from datetime import datetime


# Write uplink to tab file
def export_lat_lon(someJSON):
    end_device_ids = someJSON["end_device_ids"]
    device_id = end_device_ids["device_id"]
    application_id = end_device_ids["application_ids"]["application_id"]
    if "uplink_message" in someJSON:
        uplink_message = someJSON["uplink_message"]
        decoded_payload= uplink_message["decoded_payload"]
        lattitude=decoded_payload["latitude"]
        longitude=decoded_payload["longitude"]
    else:
        location_solved=someJSON["location_solved"]
        location=location_solved["location"]
        lattitude=location["latitude"]
        longitude=location["longitude"]
    return lattitude, longitude
# MQTT event functions
def on_connect(mqttc, obj, flags, rc):
    print("\nConnect: rc = " + str(rc))

def on_message(mqttc, obj, msg):
    #print("\nMessage: " + msg.topic + " " + str(msg.qos)) # + " " + str(msg.payload))
    parsedJSON = json.loads(msg.payload)
    #print(json.dumps(parsedJSON, indent=4))	# Uncomment this to fill your terminal screen with JSON
    a,b=export_lat_lon(parsedJSON)
    print(a)
    print(b)
    with open('data.txt', 'w') as f:
        f.writelines(str(a)+'\n')
        f.writelines(str(b))

def on_subscribe(mqttc, obj, mid, granted_qos):
    print("\nSubscribe: " + str(mid) + " " + str(granted_qos))

def on_log(mqttc, obj, level, string):
    print("\nLog: "+ string)
    logging_level = mqtt.LOGGING_LEVEL[level]
    logging.log(logging_level, string)



print("Body of program:")

print("Init mqtt client")
mqttc = mqtt.Client()

print("Assign callbacks")
mqttc.on_connect = on_connect
mqttc.on_subscribe = on_subscribe
mqttc.on_message = on_message
#mqttc.on_log = on_log		# Logging for debugging OK, waste

print("Connect")
# Setup authentication from settings above
mqttc.username_pw_set(User, Password)


# IMPORTANT - this enables the encryption of messages
mqttc.tls_set()	# default certification authority of the system

#mqttc.tls_set(ca_certs="mqtt-ca.pem") # Use this if you get security errors
# It loads the TTI security certificate. Download it from their website from this page: 
# https://www.thethingsnetwork.org/docs/applications/mqtt/api/index.html
# This is normally required if you are running the script on Windows


mqttc.connect(theRegion.lower() + ".cloud.thethings.network", 8883, 60)


print("Subscribe")
mqttc.subscribe("#", 0)	# all device uplinks

print("And run forever")
try:    
	run = True
	while run:
		mqttc.loop(1) 	# seconds timeout / blocking time
		print(".", end="", flush=True)	# feedback to the user that something is actually happening
		
    
except KeyboardInterrupt:
    print("Exit")
    sys.exit(0)