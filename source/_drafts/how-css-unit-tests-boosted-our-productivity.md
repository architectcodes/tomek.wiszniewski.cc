---
title: How CSS unit tests boosted our productivity
author: Tomek Wiszniewski
author_url: https://github.com/tomekwi
cover: /img/machinery
---

The way you manage styles can make or break a long-running web project. Keeping things modular helps a great deal, but that’s only part of the solution.

Six months ago we had a go at setting up CSS unit tests for our components. Brilliant decision, as it turns out! Since then, our job is a lot nicer. The speed of development is fast and steady. Each of us on the team is now coding with confidence, without the fear that things might unexpectedly break.

And here’s how we did it:

<!-- more -->



{% raw %}<a id="/our-story"></a>{% endraw %}

## Our story

Let’s start with a story. Over a year ago I started developing a UI framework – at first, similar in scope and stack to Twitter Bootstrap. A LESS monolith with around 20 well-documented, kinda-independent components – some of them sprinkled with a pinch of JS. Development went really smoothly at first. We quickly shipped a successful prototype, very well received. We ended up with another contract for developing the long-term project itself.

With another big goal down the line, we faced scaling or framework way over what we than had. To meet a tight deadline, we took other developers on the team. After all, a bigger team means that things go faster – that’s how it’s supposed to work, isn’t it?

Well, not in our case. As soon as more people laid their hands on the project, serious problems began.

{% pullquote %}
When your team grows,  
CSS gets hairy
{% endpullquote %}

“Why is this CSS rule here? What happens if I change it? Looks good in this view, should be okay.” — “This other view is broken! Why was this line of CSS over there changed three weeks ago?” We all know this, right?

{% pullquote %}
“Poking around  
until it works”
{% endpullquote %}

On the other hand, we all know the feeling when stylesheets grow fat over time, out of uncertainty. “Why is this CSS rule here? This view looks good if I change it, but what if I break another view? I’d better add a new class and use the new one instead.” Everyone keeps adding stuff to the CSS, rather than reusing, optimizing or cleaning up existing code.

<p class="text-center"><figure><img class="img-responsive"
  src="/post-images/stacking-foam-blocks.gif"
  alt="Video of a guy stacking giant foam blocks in a warehouse"
  style="width: 100%"
/><figcaption>Source: giphy.com</figcaption></figure></p>




{% raw %}<a id="/a-step-back"></a>{% endraw %}

## A step back

Before we see the solution, let’s take a broader look at the problem itself. CSS was originally designed to power simple websites – and it’s a wonderful tool for that. It’s amazing how quickly you can get up and running creating beautiful UI nuggets, which work across all platforms and devices. Just a few lines of CSS make a pretty decent-looking button:

<iframe src="https://jsfiddle.net/27eb7a01/embedded/css,html,result" style="border: none; width: 100%; height: 13em"></iframe>

But since CSS appeared in 1996, the web has changed beyond recognition. We’re now delivering full-blown apps with beautiful, immersive user experiences. Like never before, we’re living the “write once, run anywhere” dream. Web apps [run without installation][step-back.A] on any device and adapt to the size of the screen, network availability, user permissions, pointing device, viewing mode, browser support and other factors.

[step-back.A]: /good-quotes/#/web-best-app-delivery-platform "The web as an app delivery platform"

{% pullquote %}
A modern web frontend  
has zillions of moving parts
{% endpullquote %}

The price for all this awesomeness is complexity. Countless moving parts which we have to wire up and keep synchronized. And let’s face it – despite web standards moving forward at breakneck speed today, the building blocks that power our apps are still good old HTML, CSS and JavaScript. Technologies designed for simple websites in the mid-nineties.

Let’s focus on CSS. We all know the [problems with CSS at scale][step-back.C]. We know the feeling when you discover a visual bug caused by that line of CSS changed weeks ago at the other end of your app. We know how much harder it gets with every new member on the team.

[step-back.C]: https://speakerdeck.com/vjeux/react-css-in-js?slide=2 "CSS in JS — by Christopher Chedeau"

<p class="text-center"><figure><img class="img-responsive"
  src="/post-images/simpsons-jenga.gif"
  alt="CSS at scale is like Bart Simpson playing Jenga"
  style="width: 100%"
/><figcaption>Source: giphy.com</figcaption></figure></p>

Brilliant folks keep coming up with [loads][step-back.B2] [of][step-back.B3] [brilliant][step-back.B4] [solutions][step-back.B5] to many of these problems. We are learning to [write our styles in a modular way][step-back.B6], not needing to worry about the global namespace anymore. We’re learning to [share variables and logic between CSS and JS][step-back.B1]. All this improves scalability – but it’s just part of the solution. Just as the arrival of modules to JavaScript didn’t magically make our apps well-organized and bug-free, modular CSS isn’t a cure for everything.

[step-back.B1]: https://git.io/jss-lite-loader#/usage/code-sharing "A css-in-js webpack loader – tomekwi/jss-lite-loader"
[step-back.B2]: https://github.com/jsstyles/jss "A lib for generating Style Sheets with JavaScript – jsstyles/jss"
[step-back.B3]: https://github.com/krasimir/cssx "CSS in JavaScript – krasimir/cssx"
[step-back.B4]: https://github.com/css-modules/css-modules "A CSS file in which all names are scoped locally by default – css-modules/css-modules"
[step-back.B5]: https://github.com/rtfeldman/elm-css "Elm CSS preprocessor that lets you use union types rather than Strings for your classes and IDs – rtfeldman/elm-css"
[step-back.B6]: http://chrispearce.co/elephants-the-three-code-ilities-two-months-with-css-modules/ "Elephants, The Three Code Ilities, & Two Months With CSS Modules — by Chris Pearce"




{% raw %}<a id="/moving-fast"></a>{% endraw %}

## Moving fast

The key to moving fast is to embrace change – or even [drive change][moving-fast.A]. Move forward with confidence, without looking back.

[moving-fast.A]: https://vimeo.com/91537336 "Bringing Change to Life — by Bill Scott"

{% blockquote Eric Elliott https://medium.com/javascript-scene/how-to-build-a-high-velocity-development-team-4b2360d34021 How to build a high-velocity development team %}
Eradicate your team’s fear of change.  
This should be **priority number one** until nobody  
worries about changing a line of code again.
{% endblockquote %}

Facebook [used to say “move fast and break things”][moving-fast.C] – but a couple of years ago they announced in a famous keynote: “Breaking things wasn’t helping us to move faster, because we had to slow down to fix these bugs and it wasn't improving our speed”. Following this conclusion, they changed their motto to “move fast with stable infra”.

[moving-fast.C]: http://mashable.com/2014/04/30/facebooks-new-mantra-move-fast-with-stability/#BryYX_gAQsqq "Facebook Changes Its ‘Move Fast and Break Things’ Motto — at Mashable"

<p class="text-center"><figure><img class="img-responsive"
  src="/post-images/move-fast-with-stable-infra.jpg"
  alt="Mark Zuckerberg saying “move fast with stable infra”"
/><figcaption>Source: facebook</figcaption></figure></p>

But what exactly does it mean to “not look back”? What exactly does “stable infra” mean? How to make sure nobody worries about changing code? Eric Elliott gives us another hint in his [series of][moving-fast.B2] [thought-provoking articles][moving-fast.B1]:

[moving-fast.B1]: https://medium.com/javascript-scene/what-every-unit-test-needs-f6cd34d9836d "5 Questions Every Unit Test Must Answer"
[moving-fast.B2]: https://medium.com/javascript-scene/how-to-build-a-high-velocity-development-team-4b2360d34021 "How to build a high-velocity development team"

{% blockquote Eric Elliott https://medium.com/javascript-scene/how-to-build-a-high-velocity-development-team-4b2360d34021 How to build a high-velocity development team %}
**Write automated tests**  
for every feature  
and every bug fix.
{% endblockquote %}

We definitely found this to be true with libraries doing business logic.

Heavy refactoring. Taking new people on the team. A major rebase. Swapping out a dependency. Getting rid of dead code. Resurrecting code months after the last commit. Handing projects over. These things happen day to day in an environment of constant change. Without unit tests, you might be facing days, weeks or even months of tedious work. But when a good suite of unit tests has your back, each of these is a breeze.

But what about CSS? How is it possible to keep a similar pace of development there?




{% raw %}<a id="/heres-how"></a>{% endraw %}

## Here’s how

Writing unit tests for CSS is a lot easier than it looks. If you’ve already written these for other languages, you’ll feel right at home.

This section is structured like a simple tutorial – feel free to follow along or play around with the live snippets. At the end of the article, I’ll explain how to run the tests headlessly and get the workflow more automated.

Our task is to solve the perennial problem of [centering an element within its parent both horizontally and vertically][heres-how.B1]. We’ll do this in a test-driven manner and go on to see how this helps keep a steady pace of development in a UI-heavy project.

[heres-how.B1]: http://stackoverflow.com/questions/14123999/center-a-div-horizontally-and-vertically "Center a DIV horizontally and vertically – on StackOverflow"

First of all, let’s install the [good and simple][heres-how.A1] test library [*tape*][heres-how.A2]. You could do this all with *tape* itself, but we’ve written a kinda-plugin for it to make CSS unit tests much more elegant: [*tape-css*][heres-how.A3]. Let’s install that as well. The last tool we need is [*hyperscript*][heres-how.A5] – it’ll help us create test DOM trees more conveniently. So here’s our test boilerplate, along with a sample test and assertion:

[heres-how.A1]: https://medium.com/javascript-scene/why-i-use-tape-instead-of-mocha-so-should-you-6aa105d8eaf4 "Why I use Tape Instead of Mocha & So Should You"
[heres-how.A2]: https://github.com/substack/tape "tap-producing test harness for node and browsers – substack/tape"
[heres-how.A3]: https://git.io/tape-css "CSS unit testing. Lightning-fast. tape-style – git.io/tape-css"
[heres-how.A4]: https://github.com/Jam3/tap-browser-el "A tap reporter which adds an element to the DOM – Jam3/tap-browser-el"
[heres-how.A5]: https://github.com/dominictarr/hyperscript "Create HyperText with JavaScript – dominictarr/hyperscript"

<iframe src="https://jsfiddle.net/3w6aun36/4/embedded/js,result" style="border: none; width: 100%; height: 15.5em"></iframe>

Now, let’s make sure we know exactly what our element should do.

* `.parent` should take up the whole width and height of its container.
* `.child` should grow and shrink to fit its contents.
* `.child` should be centered horizontally within its `.parent`.
* `.child` should be centered vertically within its `.parent`.

Let’s translate this to tests, which will automatically make sure our requirements are met. Since we’ll be working a lot with positioning, let’s define a simple helper function for that:

<iframe src="https://jsfiddle.net/5ypbnuk9/2/embedded/js" style="border: none; width: 100%; height: 8em"></iframe>

Now we have that covered, we can write the tests themselves:

<iframe src="https://jsfiddle.net/5ypbnuk9/4/embedded/js,result" style="border: none; width: 100%; height: 50em"></iframe>

By the way, we’ve just done a very healthy thing – we’re thinking about *what* we want to do before we actually do it.

If you switched to the *Result* tab above, you surely noticed that our tests fail. No wonder – we haven’t written any styles yet! Let’s do it right now. To keep things simple, we’ll write the styles as a raw string right inside our test file. In the real world, you’d probably want to import them from a CSS module, a raw CSS file, or a preprocessor like [JSS][heres-how.C] or LESS. There we go:

[heres-how.C]: https://github.com/jsstyles/jss "A lib for generating Style Sheets with JavaScript – jsstyles/jss"

<iframe src="https://jsfiddle.net/spsv13sa/embedded/js" style="border: none; width: 100%; height: 19.5em"></iframe>

Now let’s wire that up with all we’ve written so far. Et voilà! Our component is ready.

<iframe src="https://jsfiddle.net/5ypbnuk9/5/embedded/result,js" style="border: none; width: 100%; height: 20em"></iframe>


<!--
The first concept of testing whole UIs is integration testing by [comparing screenshots][heres-how.A]. There are several problems with that though. You can’t write your tests before implementing stuff. You can’t automate it fully. You can’t run the tests in different browsers.

{% pullquote %}

{% endpullquote %}

[heres-how.A]: http://tldr.huddle.com/blog/css-testing/ "CSS regression testing"
-->
