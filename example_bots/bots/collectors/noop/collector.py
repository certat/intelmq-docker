"""
SPDX-FileCopyrightText: 2022 Einar Lanfranco
SPDX-License-Identifier: AGPL-3.0-or-later

Example Collector Bot for Demo purpose only.

Document possible necessary configurations.
"""
import sys
import time
# imports for additional libraries and intelmq
from intelmq.lib.bot import CollectorBot


class NoOpCollectorBot(CollectorBot):
    """Este bot no hace nada util"""
    paso: str = "step"
    cantidad: int = 5
    rate_limit: int = 3600

    def process(self):
        self.logger.info("Comenzando NOOP Collector")
        time.sleep(self.cantidad)
        for i in range(self.cantidad):
            time.sleep(i)
            self.logger.info(f'{self.paso}{i}')
        report = self.new_report()
        report.add("raw","bGEgbmFkYSBtaXNtYQ==")
        report.add("feed.url", "http://noop.url")
        self.send_message(report)
     

BOT = NoOpCollectorBot
