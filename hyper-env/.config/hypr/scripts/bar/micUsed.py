#!/usr/bin/env python3

import subprocess
import re
import json
import sys
import argparse

def properties_to_dict(inputStr):
  lines = inputStr.strip().split('\n')
  result = {}

  for line in lines:
      keys, value = line.split(' = ')
      keys = keys.split('.')
      current_dict = result

      for key in keys[:-1]:
          if key not in current_dict:
              current_dict[key] = {}
          current_dict = current_dict[key]

      current_dict[keys[-1]] = value.strip('""')

  return result


def get_mics_in_use():
  # Run the command and retrieve the output
  output = subprocess.check_output(["pactl", "list", "sources"]).decode("utf-8")

  # Split the output into sections using "Sources" as the delimiter
  sections = re.split(r"(?m)^Source\b", output)[1:]
  sections = list(filter(lambda x: "RUNNING" in x, sections))
  sections = list(filter(lambda x: "Audio/Source" in x, sections))
  return sections


# ARGS
parser = argparse.ArgumentParser()
parser.add_argument("-c", "--check", action="store_true", help="Check if there inputs in use, do not return data")


# MAIN
args = parser.parse_args()
sections = get_mics_in_use()


if args.check:
  if len(sections) >= 1:
    print("Micrphones Used")
    sys.exit(0)
  else: 
    print("No Microphones")
    sys.exit(1)




sources = []
key_value_pattern = r"\t+(\w+):(.*)"
for section in sections:
    # Remove characters before "State"
    section = re.sub(r".*State:", "\tState:", section, count=1)
    # Remove everything from "Ports:" onwards
    section = re.sub(r"Ports:.*", "", section, flags=re.DOTALL)
    # Remove everything from "Volume:" to the end of the line containing "Base Volume"
    section = re.sub(r"^\s*Mute:.*?(?=^\s*Monitor of Sink:)", "", section, flags=re.DOTALL | re.MULTILINE)

    # Extract key-value pairs
    source_dict = {}
    lines = section.strip().split("\n")
    for line in lines:
        match = re.match(key_value_pattern, line)
        if match:
            key = match.group(1).strip()
            value = match.group(2).strip()

            if key == "Properties":
              value = {}

            source_dict[key] = value

    # Extract Properties Subdicts
    stripped_section = re.sub(r".*Properties:", "", section, flags=re.DOTALL)
    stripped_section = re.sub(r"\t", "", stripped_section)
    # print(stripped_section)
    source_dict["Properties"] = properties_to_dict(stripped_section)

    # Add result to sources collection
    sources.append(source_dict)
    
    
  # "exec": "echo '{ \"text\": \"\", \"class\": \"used\"}'",

# Filter sources based on state and media class
output = {
  "text": "",
  "class": "used",
  "sources": [],
  "tooltip": ""
}
for source in sources:
  newObj = {
    "name": source['Properties']['alsa']['name'],
    "card_name": source['Properties']['alsa']['card_name']
  }
  output["tooltip"] += f"{newObj['name']} | {newObj['card_name']}\n"
  output["sources"].append(newObj)
  
output["tooltip"] = output["tooltip"][:output["tooltip"].rfind('\n')] if '\n' in output["tooltip"] else output["tooltip"]
print(json.dumps(output))
