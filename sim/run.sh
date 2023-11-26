#!/bin/bash

project_path=$(pwd)
sim_path="/sim"
export proj_root=${project_path%$sim_path}

gui=''
if [ "$3" == "gui" ]; then
    gui='-gui'
fi

xrun +UVM_TESTNAME=$1 -seed $2 $gui -f run.args
