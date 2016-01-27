# TODO
#### Functionality
	1. create comments
		1. create comments on posts view DONE
		2. create comments on posts on root route DONE
	2. voting system
		1. belongs to comment
		2. belongs to post
		3. Acts As Votable gem
	3. create groups
		1. has_many posts, post belongs to group
		2. has_many comments through posts
	4. search by keyword group, answers, comments
	5. Pagination for comments and posts

####User model
	1. Devise
		1. Forgot password
		2. Activation email
	2. Can destroy/edit only his posts not anyone else's
	3. Can destroy/edit his comments not anyone else's
	4. User profile page
	5. Can edit only his profile page
	6. If not logged in can not access any page then login and signup

####Layout
	1. Create partials for creating/editing posts/comments
	2. Add truncate for questions description
	3. AFTER VOTING SYSTEM: on root page show latest hottest questions
	4. Preloader between pages

####Fixes
	1. Rename Posts to Questions

####Tests
	0. Add Fake data with Faker
	1. Layout
		1. Check if comments showed on post's page are associated with that post
		2. Check if posts showed on user's page are associated with that user
		3. Showing errors
	2. User model
		1. User can only access several pages
		2. He can not change other's posts/comments
		3. If not logged in can not go into app
	3. Registration
		1. Activation email
		2. Forgot password
	4. Security

####Extras
	1. Create promoting video
	2. Landing page