#!/bin/bash

source R/library/RMatlab/scripts/RMatlab.sh
export R_LIBS_USER="R/library/"
matlab $*
