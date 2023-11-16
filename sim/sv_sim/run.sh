#!/bin/bash

str=$(pwd)
rem="/sim/sv_sim"
export proj_root=${str%$rem}
echo $proj_root

xrun +UVM_TESTNAME=$1 -seed $2 -gui -f run.args
