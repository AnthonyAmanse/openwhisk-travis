#!/bin/bash

wsk -i list
wsk -i action invoke /whisk.system/utils/echo --param test test --result
