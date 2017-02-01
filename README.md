plan:

Sessions Controller - started

new, create

*********************************************

User -

has_one :profile

has_many :comments

3 roles - User = 0, moderator = 1, admin = 2



user table to create

username

password_digest - added to db/added bcrypt gem and has_secure_password in User model

password_confirmation - not included in db.


no guest will have access since this is a private message board.


User can delete their own account

moderator can suspend a user.

Admin can delete a User

Admin can add or remove a moderator.

*********************************************
Profile - started

belongs_to user

profile table to create:

picture

*********************************************
Post -

has_many_users

has_many :comments, through => users

posts table to create

title

content

**********************************************
Comments

belongs_to :user

belongs_to :post


comments table to create

user_id

post_id

content
