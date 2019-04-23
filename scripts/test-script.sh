#!/bin/bash

wsk list
wsk action invoke /whisk.system/utils/echo --param test test --result
