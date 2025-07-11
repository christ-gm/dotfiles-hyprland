#!/bin/bash
direction=$1
current=$2
hyprctl dispatch workspace "$((current + direction))"