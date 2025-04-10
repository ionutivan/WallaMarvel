## Wallapop take home test

I took various decisions:

* No fancy UI, as I consider that is time consuming and would not reflect my programmer skills too much
* I preffered splitting the codebase into several modules instead of building the filtering (less features, but better quality)
* The testing is by far not as extensive as I would have wanted. I preffered showing how I would **approach** testing, mainly unit testing. 

The modules have been created alongside the folders already created for file organization.

Although I preffered to use async/await for Networking, I opted to not solve the warnings related to Structured Concurrency. 

Related to the MD5 algorithm that Apple calls insecure, this is what Marvel API requests, so I didn't consider that a security liability.

The private API key has been moved to a xcconfig file that has been added to gitignore. Now, the private key is not available in plain on GH, Gitlab, etc.
