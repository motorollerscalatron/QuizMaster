# Quiz Master

## Sample Application

You can find app on heroku. https://enigmatic-gorge-54512.herokuapp.com/

This site is for the guiding purpose, and not ready for performance/stress test.


First, please sign up using your email address. Once you register them, you are redirected to home (There is no activation phase).

To make your own quiz,
 - you can use the form in the login home (`/`)

Once the question is submitted, until you make the quiz item public, it will not be visible to other users.


To see a list of quiz of all users, go to [TODO]

To solve the questions, you can go to [TODO]

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

## Technical note

### Notes on design decision

#### App is based on the rails tutorial sample App.

Judging from the time constraints of the assignment, I decided to use a tutorial app as a basis.

#### Prioritized features rather than user interfaces.
To make the application ready for some reviews, the user interface was kept minimal.


### DB structures ###

#### users ####

| Field           | Type             | Null | Key | Default |
|-----------------|------------------|------|-----|---------|
| id              | int              | NO   |     |         |
| name            | string           | NO   |     |         |
| created_at      | datetime         | NO   |     | false   |
| updated_at      | datetime         | NO   |     | false   |
| password_digest | string           | NO   |     |         |
| remember_digest | string           | NO   |     |         |
| admin           | boolean          | NO   |     | false   |

The `Users` table conforms to the default table structure shown in the tutorial, minus some additional columns used in the user activation, which was omitted in this project.

#### questions ####



#### challenges ####
