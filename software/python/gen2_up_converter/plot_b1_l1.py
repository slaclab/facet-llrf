#!/usr/bin/env python2

import epics
import matplotlib.pyplot as plt

dac = epics.caget('SIOC:B084:RF53:0:STR1:STREAM_SHORT1')
plt.plot(dac)
plt.show()
