# Building a gem

In this post I'm going to go through the process of building a gem called Football Now. In the process of building it out we'll touch on various topics like Object relationships and responsibilities, setting up your environment and building a CLI controller to handle the user interaction, plus a few neat Ruby tips and tricks picked up along the way.

### Step 1: What should this app do?

Before writing any code I opened up a NOTES.MD file in Atom and started freewriting about what my little app would do.

I decided first that, in an nutshell, my Football Now gem would allow a user to check on the top European football leagues, look up recent results, look up league standings, and look up any team in any of the included leagues and see their record as well as all results up to the moment.

Then I went about imagining how the app might work. I wrote, deleted, wrote some more, made up commands and wrote out flow charts in bullet points, until I had something that looked like the following.

> How should this go...
> Top Level commands:
>
>1. User Chooses a League to Explore:
>2. User has options:
>  a. List recent scores (latest round
>  b. Get league standings
>  c. List teams
>    i. Choose team to list all match results and its standing in the league.
>
>OTHER OPTIONS:
> - `exit` to quite
> - `back` to go back to previous menu

From here I went out to describe what I thought my classes would be like, but I was keeping a very open mind - things would change as I started writing the program and better ideas or patterns occurred to me. So I didn't want to waste too much more time, just get an idea of where I might be able to start.
