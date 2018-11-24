#!/bin/bash

set -e

rake db:migrate && rails server
