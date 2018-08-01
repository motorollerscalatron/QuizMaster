# Quiz Master

[![Inline docs](http://inch-ci.org/github/motorollerscalatron/QuizMaster.svg?branch=master)](http://inch-ci.org/github/motorollerscalatron/QuizMaster)  [![Build Status](https://travis-ci.com/motorollerscalatron/QuizMaster.svg?branch=master)](https://travis-ci.com/motorollerscalatron/QuizMaster)

## Sample Application

You can find app on heroku server location, which would be emailed separately.
This site is for the guiding purpose, and not ready for performance/stress test.

## Getting started

First, please sign up using your email address. Once you register them, you are redirected to home (There is no activation phase).

Once the user signed up successfully, you could see the instruction on the right side of home screen.
Once the question is submitted, until you make the quiz item public, it will not be visible to other users.

### challenge

To solve the questions,
 - Choose Challenge! in the menu (you will jump to public quiz list `/questions`) and choose the quiz you would like to solve.
 - fill in the form and click on Submit.
 - You can see the total number of challenges is user's profile.

### manage

`Manage Your Quiz` lists the questions you created.

You have two places to create the question: home(`/`) and Create a quiz(`/questions/new`).
Once you created a question, you can update attributes by edit.

### account

`profile` shows your user profile. In `setting`, you can edit your account information.

## Set up

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
$ rails db:seed
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

### Development style
As the project delivery is short (2 weeks) and the style of the given specification can have some interpretations, I decided to develop this project on the prototype base.
That is, once the branch is made, some features are implemented on best-efforts basis, and every time the one is merged, the project is reviewed by myself, and issues raised consequently.


### Notes on design decision

Considering the nature of this project, I chose to stick to several development styles, such as follows:

#### 1. App is based on the rails tutorial sample App.

Judging from the time constraints of the assignment, I decided to use a tutorial app(https://www.railstutorial.org/book/) as a template of application.
The following features were omitted due to the time restriction and the necessity to this project:
 - Account activation (Chapter 11)
 - Password reset (Chapter 12)
 - Following users (Chapter 14)

 #### consequence

 :+1: it saved several efforts to set up the basic user authentication and questions data structure (using analogy from `microposts` in the original tutorial)

 :-1: Development lacking a wireframe based on the updated spec (after the second iteration) left some corner cases that came up as bug (e.g. https://github.com/motorollerscalatron/QuizMaster/issues/1)

#### 2. Prioritized features rather than performances / user interfaces.

To make the application ready for some reviews, the user interface was kept minimal.
This focus also forfeits the choice of flexible implementations by react.js (suggested initially) and backend API.

#### 3. Simplicity

Though the application is based on the tutorial application which is already minimalistic, yet whenever I find I can omit some existing features or interfaces, I tried to diminish the size of components.

### DB structures ###

see `schema.db`

#### users ####

| Field           | Type             | Null | Key | Default |
|-----------------|------------------|------|-----|---------|
| id              | int              | NO   |     |         |
| name            | varchar          | NO   |     |         |
| created_at      | datetime         | NO   |     | false   |
| updated_at      | datetime         | NO   |     | false   |
| password_digest | varchar          | NO   |     |         |
| remember_digest | varchar          | NO   |     |         |
| admin           | boolean          | NO   |     | false   |

The `Users` table conforms to the default table structure shown in the tutorial, minus some additional columns used in the user activation, which was omitted in this project.

#### questions ####

| Field           | Type             | Null | Key | Default |
|-----------------|------------------|------|-----|---------|
| id              | int              | NO   |     |         |
| description     | text             | NO   |     |         |
| answer          | text             | YES  |     |         |
| is_public       | boolean          | YES  |     | false   |
| user_id         | int              | NO   |     |         |
| created_at      | datetime         | NO   |     | false   |
| updated_at      | datetime         | NO   |     | false   |

Ideologically, answer should be non-null attribute. However, the record is regarded as "draft", while `is_public` is false.
For such cases, users can
While any users can create questions unlimitedly, the `is_public` flag determines if these questions are exposed to other users.


#### challenges ####

| Field           | Type             | Null | Key | Default |
|-----------------|------------------|------|-----|---------|
| id              | int              | NO   |     |         |
| question_id     | int              | NO   |     |         |
| user_id         | int              | NO   |     |         |
| result          | boolean          | NO   |     |         |
| created_at      | datetime         | NO   |     | false   |
| updated_at      | datetime         | NO   |     | false   |



### further developments

At first, you can see issues in the project.

As for the general course of UI and UX, if I had more time available, the following enhancements could be considered to enhance the UX, rather than the old school layout in the current implementation.


 - tutorial overlays ... Only in the first occasion of the sign-in, the user see an tutorial dialog overlay on the normal screen.
 - dynamic interaction ... The user can answer a question(or see feedback) without screen transition.
 - recommendation ... The user can have next questions to solve as recommendation, based on the history.
