#!/bin/bash
#
# stream msw3 excel files into line-json 
#

find data-raw -type f\
 | sort\
 | sed 's/ /%20/g'\
 | sed "s+^+https://github.com/jhpoelen/msw3/raw/main/+g"\
 | xargs preston track\
 | preston excel-stream\
 > msw3.json


