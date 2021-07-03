#!/usr/bin/env bash

#Create new post
#First and only argument to this script is the title of the post

date=$(date +"%Y-%m-%d")
time=$(date +"%H:%M")
filename=_posts/"$date"-"$1".md
template_insert="---
layout: post
title: \"$1\"
date: $date $time
categories: [News]
tags: [news]
image: \"post_default_header.jpg\"
comments: true
---
"

touch "$filename"
echo -e "$template_insert" > "$filename"