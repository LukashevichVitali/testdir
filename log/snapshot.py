#!/usr/bin/env python

import psutil
import argparse
import datetime
import json
import time

parser = argparse.ArgumentParser(description='Lukashevich script')
parser.add_argument('-t', '--timer', type=int, default=1, dest='timer', help='select time for timer(default 300s)')
parser.add_argument('-l', '--log', type=str, default='txt', dest='log', help='select type: txt or json(default txt)')
args = parser.parse_args()


class Snapshot:
    def __init__(self):
        print('log start')

    def output_log_by_timer(self):
        system_data = datetime.datetime.now()
        system_cpu = psutil.cpu_percent(interval=1, percpu=True)
        system_ram = psutil.virtual_memory().total / (1024.0 ** 3)
        system_io = psutil.disk_io_counters().read_count
        system_disk_percent = psutil.disk_usage('/').percent
        system_net = psutil.net_io_counters(pernic=False)

        select_type_log = args.log
        number_count = 0

        while True:
            number_count += 1
            if select_type_log == 'txt':
                log_data = open('log.txt', 'a')
                print("SNAPSHOT", number_count, system_data, "CPU %:", system_cpu, "RAM Total:", system_ram,
                      "IO:", system_io, "Used disk:", system_disk_percent, "Network:", system_net, file=log_data)
                time.sleep(args.timer)
            if select_type_log == 'json':
                log_json = {
                    "SNAPSHOT": number_count,
                    "CPU %:": system_cpu,
                    "RAM Total:": system_ram,
                    "IO:": system_io,
                    "Used disk:": system_disk_percent,
                    "Network:": system_net
                }
                json_object = json.dumps(log_json, indent=6)
                with open("log.json", "a") as outfile:
                    outfile.write(json_object)
                    outfile.write('\n')
                time.sleep(args.timer)
