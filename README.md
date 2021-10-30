# Online vulnerability detection platform based on fuzzing 

Fuzzing Platform is an easy-to-use web portal which allows users to submit their own program files to be tested using fuzzing software. The backend fuzz testing software that is utilised is the open-source American Fuzzy Lop Plus Plus (AFL++) fuzzer. It is a branched version of AFL which follows the common brute-force technique while also implementing an instrumentation-guided genetic algorithm, meaning it mutates the initial seed input to increase the amount of path coverage, hence delivering performance superior to those of regular blind fuzzers. With community patches and software upgrades, it provides "more speed, more and better mutations, more and better instrumentation, and custom module support".

## Website Sitemap

The website sitemap is as follows:

    ├── Login
    │   ├── Sign Up
    │   ├── Sign In
    │   └── Forgot Password
    ├── Home
    ├── About Us
    ├── Dashboard
    │   ├── How To Use
    │   ├── Upload
    │   │   └── Upload Result
    │   └── Job History
    ├── Live Metrics
    └── Reset Password

## Documentation

The following website documentation can be found within /docs:
 - `BackendREADME.md`: Outline of the scripts within the backend
 - `BashScripts.md`: Steps to build your own image (although one will be provided to you)
 - `FirebaseSetUp.md`: Steps to setup the user management system required using Firebase
 - `MariaDBSetUp.md`: Steps to setup the file management system required using MariaDB

 ## Contributors 
  - Allan Ou: 102311652
  - Bronson Johnson: 102094694
  - Filip Medrala: 102606361
  - Owen Cartmel: 102575801
  - Ryan Coates: 102112211
  - Siena Muscat: 101669774