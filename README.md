# HTTP Web Server

## Setup

Clone this repository
```bash
$ git clone https://github.com/mgmilton/http_web_server
```

## Executing the Server
This is a minimal HTTP web server built using ruby. It responds to the following paths:

```bash
"/"  yields Response Diagnostics
"/hello" yields Hello, World!(0) where the zero increments based on hello requests
"/datetime" yields the current date and time in this format 11:07AM on Friday, December 21, 2017
"/word_search?word=any_english_word" looks up in the dictionary if any_english_word is a known word
a post request to "/start_game" initiates a number guessing game
a post request to "/game" evaluates the guess a redirects to a get to /game where the number and amount of guesses is returned
"/force_error" raises a SystemError and shuts the server down
"/anything_else" returns a 404 error
"/shut_down" responds with the total amounts of requests sent to the server and closes the server
```
