# Bernie-Sits-Shiny
Bernie sits on streetview in an R Shiny App

## Motivation
The original Bernie sits: https://bernie-sits.herokuapp.com/ by [Nick Sawhney](https://twitter.com/nick_sawhney). Looking at the original, there was some room for improvement. It got the job done, but I thought reverse engineering it would be fun.

I figured it was programmed in python using Django. It had that typical "I didn't put any extra thought into the web page template" feel that Django websites in python often have. I thought I could make it a bit prettier using R and Shiny.

## Features
The original had a text input, action button, and output an image on the screen. My version has that, but also includes:
- Enhanced formatting
- User input checks, with useful messages

## End Result
While I won't publish it for the same reason that Nick took the original down (the streetview API and hosting that number of concurrent users isn't cheap), here is the end result:

